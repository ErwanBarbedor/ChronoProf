--[[This file is part of ChronoProf⏳

ChronoProf⏳ is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.

ChronoProf⏳ is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with ChronoProf⏳.
If not, see <https://www.gnu.org/licenses/>.
]]

package.cpath = "./bin/?.dll;" .. package.cpath
local lfs = require "lfs"
local ffi = require("ffi")

--- CP1552 -> UTF8
-- Load the core Windows system library.
local C = ffi.load("kernel32")

-- FFI C definitions for the Windows API functions.
ffi.cdef[[
    // Use an enum for constants, which is compatible with ffi.cdef.
    enum {
        CP_1252_ = 1252, // Suffix added to avoid potential name clash
        CP_UTF8_ = 65001
    };

    // Type definitions
    typedef unsigned int DWORD;
    typedef int BOOL;
    typedef unsigned short WCHAR; // ffi maps wchar_t to uint16_t on Windows

    // Function prototypes
    int MultiByteToWideChar(
        DWORD CodePage,
        DWORD dwFlags,
        const char* lpMultiByteStr,
        int cbMultiByte,
        WCHAR* lpWideCharStr,
        int cchWideChar
    );

    int WideCharToMultiByte(
        DWORD CodePage,
        DWORD dwFlags,
        const WCHAR* lpWideCharStr,
        int cchWideChar,
        char* lpMultiByteStr,
        int cbMultiByte,
        const char* lpDefaultChar,
        BOOL* lpUsedDefaultChar
    );
]]

--- Converts a string from CP1252 to UTF-8 using the Windows API.
-- @param {string} s The input string in CP1252 encoding.
-- @return {string|nil, string} The resulting UTF-8 string, or nil and an error message.
local function cp1252_to_utf8(s)
    if not s then return end
    local len = #s
    if len == 0 then
        return ""
    end

    -- Step 1: Convert CP1252 to UTF-16 (WideChar)
    -- First, get the required buffer size for the wide char string.
    local wide_len = C.MultiByteToWideChar(C.CP_1252_, 0, s, len, nil, 0)
    if wide_len == 0 then
        error("Failed to calculate buffer size for UTF-16.")
    end
    local wide_buf = ffi.new("WCHAR[?]", wide_len)
    
    -- Now perform the actual conversion.
    local res = C.MultiByteToWideChar(C.CP_1252_, 0, s, len, wide_buf, wide_len)
    if res == 0 then
        error("CP1252 to UTF-16 conversion failed.")
    end

    -- Step 2: Convert UTF-16 to UTF-8
    -- First, get the required buffer size for the final UTF-8 string.
    local utf8_len = C.WideCharToMultiByte(C.CP_UTF8_, 0, wide_buf, wide_len, nil, 0, nil, nil)
    if utf8_len == 0 then
        error("Failed to calculate buffer size for UTF-8.")
    end

    local utf8_buf = ffi.new("char[?]", utf8_len)

    -- Perform the final conversion.
    res = C.WideCharToMultiByte(C.CP_UTF8_, 0, wide_buf, wide_len, utf8_buf, utf8_len, nil, nil)
    if res == 0 then
        error("UTF-16 to UTF-8 conversion failed.")
    end

    return ffi.string(utf8_buf, utf8_len)
end

--- Copy a file (without any check)
local function cp(src, dest)
    local srcFile  = io.open(src, 'rb')
    local destFile = io.open(dest, 'wb')

    destFile:write(srcFile:read('*a'))

    srcFile:close()
    destFile:close()
end

local specialFiles = {
    ["config.lua"]=true
}

--- Group uid
local uid=0

--- Used to track student part of multiples groups
local studentData = {}

local function loadMemberies(childPath, parent)
    local name, surname = childPath:match('^.*/([A-Z][^\\/]-)%s([A-Z][^A-Z\\/][^\\/]-)%.[a-z]-$')            
    local childDirPath = childPath:gsub('%..-$', '') 
    
    name = cp1252_to_utf8(name)
    surname = cp1252_to_utf8(surname)

    local childData = {
        name = name,
        surname = surname,
        path = cp1252_to_utf8(childPath),
        hasMembery = false,
        membery={img={}, txt={}},
        parent = parent,
    }

    if name and surname then
        local id = name .. "_" .. surname
        studentData[id] = studentData[id] or {}

        table.insert(studentData[id], parent)
        childData.links = studentData[id]
        childData.id = id
    end

    if lfs.attributes(childDirPath) then
        childData.hasMembery = true
        for subChild in lfs.dir(childDirPath) do
            local subChildPath = childDirPath .. "/" .. subChild
            local subChildInfos = lfs.attributes(subChildPath)

            if subChildInfos.mode == "file"
                and not subChild:match('^%.+$')
                and not specialFiles[subChild] then
                
                local ext = subChildPath:match('%.(.-)$')
                if ext == "txt" then
                    table.insert(childData.membery.txt, subChildPath)
                else
                    table.insert(childData.membery.img, cp1252_to_utf8(subChildPath))
                end
            end
        end
    end
    return childData
end

--- Runs through path subfolders, save folder and files names.
-- All lfs returned values are encoded in CP1252 and need to be converteds in utf8
local function loadData(path, deep)
    -- root is data
    path = path or "data"
    deep = (deep or -1)+1

    local data = {
        children      = {},
        illustrations = {}
    }

    -- harcoded first name
    if path == "data" then
        data.name = "data"
    end

    -- check for config.lua
    local defaultConfigName = "default_config/"..deep
    local defaultConfigPath = defaultConfigName..".lua"

    local configName = path.."/config"
    local configPath = configName..".lua"
    
    if lfs.attributes(configPath) then
        data.config = require(configName)
    else
        -- Load defaut one
        data.config = require(defaultConfigName)
        -- And copy it in the folder
        cp(defaultConfigPath, configPath)
    end

    for child in lfs.dir(path) do
        if not child:match('^%.+$')-- Ignore . and ..
            and not specialFiles[child] then
            local childPath = path .. "/" .. child
            local childInfos = lfs.attributes(childPath)

            if deep == 3 then -- group
                if childInfos.mode == "file" then
                    table.insert(data.children, loadMemberies(childPath, data))
                elseif child == "classe" then
                    data.common =  loadMemberies(childPath, data)
                end
            else -- default
                if childInfos.mode == "directory" then
                    if childPath:match('illustrations$') then
                        data.illustrations = {}
                        for child in lfs.dir(childPath) do
                            if not child:match('^%.+$') and not child:match('%.lua$') then
                                table.insert(data.illustrations, 
                                    cp1252_to_utf8(childPath .. "/" .. child)
                                )
                            end
                        end
                    else
                        local childData = loadData(childPath, deep)
                        uid = uid+1
                        table.insert(data.children, childData)
                        childData.name = cp1252_to_utf8(child)
                        childData.id = uid
                        childData.parent = data
                    end
                end
            end
        end
    end


    if deep == 0 then--main
        -- alphabetic sort
        table.sort(data.children, function(a, b) return a.name>b.name end)
    end

    return data
end

-- Checks if data exists
if not lfs.attributes("data") then
    print("Erreur: le dossier data n'existe pas. Assurez vous qu'il a été créé et que vous executez ce logiciel depuis le même répertoire parent.")
    os.exit(1)
end

_PLUME.data = loadData ()

-- Some checks for user configuration...
if _PLUME.data.config.illustrationMinRange >= _PLUME.data.config.illustrationMaxRange then
    print("Erreur de configuration. illustrationMinRange doit être strictement inférieur à illustrationMaxRange")
end