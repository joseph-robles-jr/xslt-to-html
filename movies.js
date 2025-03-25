// const firstMovie = document.getElementById('Movie-1');


function helloify() {
    var i = 0;

    while (i < 74) {
        var Movie = document.getElementById(`Movie-${i}`);
        const newTitle = `Hello World ${i + 1}`;
        if (Movie) {
            const titleElement = Movie.querySelector('.title');


            if (titleElement) {
                var oldTitle = titleElement.textContent;
                oldTitle = oldTitle.replace("Title:", "").trim();
                oldTitles[i] = oldTitle;
                titleElement.textContent = `Title: ${newTitle}`;
                console.log(`Old Title: ${oldTitle}, New Title: ${newTitle}`);
            }

        }
        i++;
    }
    if (i === 74) {
        console.log(`All ${i} records replaced.`);
    }
    isScrambled = true;
}

function unhelloify() {
    var i = 0;

    while (i < 74) {
        var Movie = document.getElementById(`Movie-${i}`);
        if (Movie) {
            const titleElement = Movie.querySelector('.title');


            if (titleElement) {
                var helloTitle = titleElement.textContent;
                titleElement.textContent = `Title: ${oldTitles[i]}`;
                console.log(`Old Title Restored: ${oldTitles[i]}`);
            }

        }
        i++;
    }
    if (i === 74) {
        console.log(`All ${i} records replaced.`);
    }
    isScrambled = false;
}

document.addEventListener("DOMContentLoaded", function() {
    // Function to fetch and parse plots.xml
    function loadPlots() {
        return fetch('plots.xml')
            .then(response => response.text())
            .then(str => (new window.DOMParser()).parseFromString(str, "text/xml"));
    }

    // Function to insert plot data into the movie entries
    function insertPlots(plots) {
        const plotElements = plots.getElementsByTagName("description");
        
        // Loop through each movie and insert the corresponding plot
        for (let i = 0; i < plotElements.length; i++) {
            const plotText = plotElements[i].getElementsByTagName("plot")[0].textContent;
            const plotSpan = document.querySelector(`#Movie-${i} .plot-text`);
            if (plotSpan) {
                plotSpan.textContent = plotText; // Insert the plot text
            }
        }
    }

    // Load plots and insert them into the movie entries
    loadPlots().then(plots => {
        insertPlots(plots);
    }).catch(error => {
        console.error("Error loading plots:", error);
    });
});



var isScrambled = false;

var oldTitles = [];

const button = document.getElementById('hello-button');
button.addEventListener('click', function () {
    if (!isScrambled) {
        helloify();
    }
    else if (isScrambled = true) {
        unhelloify();
    }
});