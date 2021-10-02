//Variables
let [milliseconds, seconds, minutes, hours] = [0, 0, 0, 0];
let int;

let show = document.querySelector("#show");
let start = document.querySelector("#start");
let reset = document.querySelector("#reset");
let pause = document.querySelector("#pause");

// event listeners for buttons
start.addEventListener('click', startTimer);
pause.addEventListener('click', pauseTimer);
reset.addEventListener('click', resetTimer);

//all Functions
function startTimer() {
    int = setInterval(showTimer, 10);
}

function pauseTimer(){
    clearInterval(int);
}

function resetTimer(){
    clearInterval(int);
    [milliseconds, seconds, minutes, hours] = [00, 00, 00, 00];
    show.innerHTML = `00h : 00m : 00s`;
}

function showTimer() {
    milliseconds += 10;
    if (milliseconds === 1000) {
        milliseconds = 0;
        seconds++;
        if (seconds === 60) {
            seconds = 0;
            minutes++;
            if (minutes === 60) {
                minutes = 0;
                hours++;
            }
        }
    }
    let h = hours < 10 ? "0" + hours : hours;
    let m = minutes < 10 ? "0" + minutes : minutes;
    let s = seconds < 10 ? "0" + seconds : seconds;
    let ms = milliseconds < 10 ? "00" + milliseconds : milliseconds < 100 ? '0' + milliseconds : milliseconds;

    show.innerHTML = `${h}h : ${m}m : ${s}s`;
}

