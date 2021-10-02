const button=document.querySelector('button');
const close=document.querySelector('.close');
const sideWindow=document.querySelector('.blur-back');

button.addEventListener('click',function(){
    sideWindow.classList.remove('hidden');
});

close.addEventListener('click',function(){
    sideWindow.classList.add('hidden');
});
