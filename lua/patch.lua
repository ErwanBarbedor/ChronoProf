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

-- Patch functions that are bugged in plume

function _PLUME.gsub(__plume_args)
    local s = tostring(__plume_args[1])
    local f = __plume_args[2]
    local r = __plume_args[3]
    return s:gsub(f, r)
end

function _PLUME.match(__plume_args)
    local s = tostring(__plume_args[1])
    local f = tostring(__plume_args[2])
    return s:match(f)
end

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

function _PLUME.insert(__plume_args)
    local t = __plume_args[1]
    local x = __plume_args[2]
    table.insert(t, x)
end

function _PLUME.remove(__plume_args)
    local t = __plume_args[1]
    local i = __plume_args[2] or #t
    return table.remove(t, i)
end

-- And add utils ones
function _PLUME.txtFormat(__plume_args)
    local s = tostring(__plume_args[1])
    return s
        :gsub('[\n\r]+', '<br>')
        :gsub('%*%*([^\n*]*)%*%*', '<strong>%1</strong>')
        :gsub('%*([^\n*]*)%*', '<em>%1</em>')
        .."" -- trick to cut the second returned value
end