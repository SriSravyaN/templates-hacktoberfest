//Code for backend game working:
'use strict';
//Constant declerations:
const tiles=document.querySelectorAll('.tile');
const tile_1=document.querySelector('.tile-1');
const tile_2=document.querySelector('.tile-2');
const tile_3=document.querySelector('.tile-3');
const tile_4=document.querySelector('.tile-4');
const tile_5=document.querySelector('.tile-5');
const tile_6=document.querySelector('.tile-6');
const tile_7=document.querySelector('.tile-7');
const tile_8=document.querySelector('.tile-8');
const tile_9=document.querySelector('.tile-9');
const actDis1=document.querySelector('.active-tile-1');
const actDis2=document.querySelector('.active-tile-2');
const modal=document.querySelector('.modal');
const overlay=document.querySelector('.overlay');
const displayWinner=document.querySelector('.modal p');
const close=document.querySelector('.close');
const replay1=document.querySelector('.replay1');
const replay2=document.querySelector('.replay2');

//Variable declerations:
let count=9;
let activePlayer;
let marker;
let t1=1,t2=2,t3=3,t4=4,t5=5,t6=6,t7=7,t8=8,t9=9;
let winner=0;

//Function to set first player:
function player(){
    activePlayer=Math.trunc(Math.random()*2)+1;
    if(activePlayer===1){
        marker='X';
        actDis1.classList.add('active');
        actDis2.classList.remove('active');
    }
    else{
        marker='O';
        actDis1.classList.remove('active');
        actDis2.classList.add('active');
    }
}

//Function to check winner:
function winCheck(){
    if(t1===t2 && t2===t3 || t4===t5 && t5===t6 || t7===t8 && t8===t9 || t1===t4 && t4===t7 || t2===t5 && t5===t8 || t3===t6 && t6===t9 || t1===t5 && t5===t9 || t3===t5 && t5===t7){
        marker==='X'?winner=1:winner=2;
        displayWinner.textContent=`🏆Player-${winner} Wins🏆`;
        displayModal();
    }
}

//Function to display winner:
function displayModal(){
    if(winner===0){displayWinner.textContent=`It's a Tie!`;}
    for(let i=0;i<tiles.length;i++)
            tiles[i].style.color="rgb(42, 42, 42,0.8)";
        modal.classList.remove('hidden');
        overlay.classList.remove('hidden');
}

//Function to run game and toggel markers:
function play(){
    if(count===0){
        winCheck();
        displayModal();
    }
    winCheck();
    if(activePlayer===1){
        activePlayer=2;
        marker='O';
        actDis1.classList.remove('active');
        actDis2.classList.add('active');
    }
    else{
        activePlayer=1;
        marker='X';
        actDis1.classList.add('active');
        actDis2.classList.remove('active');
    }
}
player();

//Tile click actions:
tile_1.addEventListener('click',function(){
    if(winner===0 && t1===1){
        count--;
        t1=marker;
        tile_1.textContent=marker;
        play();}
});

tile_2.addEventListener('click',function(){
    if(winner===0 && t2===2){
    count--;
    t2=marker;
    tile_2.textContent=marker;
    play();}
});

tile_3.addEventListener('click',function(){
    if(winner===0 && t3===3){
    count--;
    t3=marker;
    tile_3.textContent=marker;
    play();}
});

tile_4.addEventListener('click',function(){
    if(winner===0 && t4===4){
    count--;
    t4=marker;
    tile_4.textContent=marker;
    play();}
});

tile_5.addEventListener('click',function(){
    if(winner===0 && t5===5){
    count--;
    t5=marker;
    tile_5.textContent=marker;
    play();}
});

tile_6.addEventListener('click',function(){
    if(winner===0 && t6===6){
    count--;
    t6=marker;
    tile_6.textContent=marker;
    play();}
});

tile_7.addEventListener('click',function(){
    if(winner===0 && t7===7){
    count--;
    t7=marker;
    tile_7.textContent=marker;
    play();}
});

tile_8.addEventListener('click',function(){
    if(winner===0 && t8===8){
    count--;
    t8=marker;
    tile_8.textContent=marker;
    play();}
});

tile_9.addEventListener('click',function(){
    if(winner===0 && t9===9){
    count--;
    t9=marker;
    tile_9.textContent=marker; 
    play();}
});


//Modal window close action:
close.addEventListener('click',function(){
    modal.classList.add('hidden');
    overlay.classList.add('hidden'); 
});

//Replay button action:
replay1.addEventListener('click',function(){
        location.reload();
});

replay2.addEventListener('click',function(){
        location.reload();
});
