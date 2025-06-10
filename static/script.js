// This file is part of ChronoProf⏳

// ChronoProf⏳ is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.

// ChronoProf⏳ is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.

// You should have received a copy of the GNU General Public License along with ChronoProf⏳.
// If not, see <https://www.gnu.org/licenses/>.

// Zoom
const main = document.getElementById('main');
const body = document.body;
let zoomed = false;
window.addEventListener('click', e => {
    let elem = e.target;
    if (zoomed) {
        zoomed = false;
        main.classList.remove("fullscreen");
        document.querySelector("#fullscreen-image").remove();
        document.querySelector("#fullscreen-image-2").remove();
    }
    else if (elem.classList.contains('can-be-zoomed')) {
        zoomed = true;
        const clonedImage1 = elem.firstChild.cloneNode(true);
        const clonedImage2 = elem.firstChild.cloneNode(true);

        main.classList.add("fullscreen");
        body.appendChild(clonedImage2);
        body.appendChild(clonedImage1);

        clonedImage1.setAttribute('id', "fullscreen-image");
        
        clonedImage1.style.maxWidth = null;
        clonedImage1.style.maxHeight = null;
        clonedImage1.style.animationName = null;
        clonedImage1.classList.add("fullscreen");

        clonedImage2.setAttribute('id', "fullscreen-image-2");
        
        clonedImage2.style.maxWidth = null;
        clonedImage2.style.maxHeight = null;
        clonedImage2.style.animationName = null;

        clonedImage2.classList.add("fullscreen");
    }
    
})

// Background
function getColor(color) {
    const items = document.querySelectorAll('[data-color-'+color+']');
    let a = 0;
    let b = 0;

    const viewportHeight = window.innerHeight;
    const viewportCenterY = viewportHeight / 2;

    items.forEach(element => {
        const rect = element.getBoundingClientRect();
        const value = parseFloat(element.getAttribute("data-color-"+color));

        if (isNaN(value)) {
            console.warn("Attribut data-color-"+color+" non numérique pour l'élément:", element);
            return;
        }

        if (rect.bottom < 0 || rect.top > viewportHeight) {
            return;
        }
        
        let coef = 1;

        if (rect.bottom<viewportHeight) {
            coef = coef - (viewportHeight-rect.bottom)/viewportHeight
        }
        if (rect.top>0) {
            coef = coef - (rect.top)/viewportHeight
        }

        a += coef * value;
        b += coef;
        
    });

    return a/b;
}

function updateColors() {
    let h = getColor("h");
    let s = getColor("s");
    let l = getColor("l");

    document.querySelector("body").style.background = "hsl("+h+" "+s+"% "+l+"%)";
    document.querySelector("body").style.color = "#fff";
}

updateColors();
window.addEventListener("scroll", function(){
    updateColors();
})