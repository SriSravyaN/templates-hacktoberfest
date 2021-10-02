const inputTimerHours = document.querySelector(".timer-hours-input");
const inputTimerMinutes = document.querySelector(".timer-minutes-input");
const inputTimerSeconds = document.querySelector(".timer-seconds-input");
const btnTimerStart = document.querySelector(".btn-timer-start");
const btnTimerPause = document.querySelector(".btn-timer-pause");
const btnTimerOff = document.querySelector(".btn-off-timer");
let resume = 0;
let cancle = 0;
// Timer.
btnTimerStart.addEventListener("click", function () {
  if (resume === 0) {
    startValue =
      Number(inputTimerSeconds.value) +
      Number(inputTimerMinutes.value) * 60 +
      Number(inputTimerHours.value * 3600);
  }
  if (cancle === 0) {
    if (startValue !== 0) {
      timerInterval = setInterval(function () {
        if (inputTimerSeconds.value == 0) {
          if (inputTimerMinutes.value == 0 && inputTimerHours.value == 0) {
            playAudio();
            reset();
          } else if (
            inputTimerMinutes.value == 0 &&
            inputTimerHours.value != 0
          ) {
            inputTimerSeconds.value = 59;
            inputTimerMinutes.value = 59;
            inputTimerHours.value--;
          } else {
            inputTimerMinutes.value--;
            inputTimerSeconds.value = 59;
          }
        } else {
          inputTimerSeconds.value--;
        }

        const progressValue =
          startValue -
          (Number(inputTimerSeconds.value) +
            Number(inputTimerMinutes.value) * 60 +
            Number(inputTimerHours.value * 3600));
      }, 1000);
      cancle++;
      btnTimerStart.textContent = "Cancle";
      btnTimerStart.style.color = "red";
    }
  } else {
    reset();
  }
});
// Timer reset operation.
const reset = function () {
  inputTimerSeconds.value = inputTimerMinutes.value = inputTimerHours.value = 0;
  clearInterval(timerInterval);
  btnTimerStart.textContent = "Start";
  btnTimerStart.style.color = "";
  cancle--;
};
// Timer pause-resume operation.
const pauseResume = function () {
  if (resume === 0 && cancle !== 0) {
    btnTimerPause.textContent = "Resume";
    clearInterval(timerInterval);
    cancle--;
    resume++;
  } else if (resume !== 0 && cancle === 0) {
    btnTimerPause.textContent = "Pause";
    btnTimerStart.click();
    resume--;
  }
};
function playAudio() {
  audio = new Audio("alarm_sound.mp3");
  audio.play();
}
function pauseAudio() {
  audio.pause();
}
document.querySelector("body").addEventListener("click", () => {
  pauseAudio();
});
