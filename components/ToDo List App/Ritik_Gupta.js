console.log("This is a notes app");

shownotes();

//Adding listener to the Submit button for adding the tasks 
let addBtn = document.getElementById("addBtn");
addBtn.addEventListener("click", addnotes);
function addnotes() {
  let addTxt = document.getElementById("addTxt");
  let addTitle = document.getElementById("addTitle");
  let notes = localStorage.getItem("notes");

  //This will make the objects taht will store title and brief of the object
  if (notes == null) {
    noteobj = [];
  } else {
    noteobj = JSON.parse(notes);
  }
  let myobj = {
    title: addTitle.value,
    text: addTxt.value,
  };
  noteobj.push(myobj);

  //Storing this in the local storage of the system
  localStorage.setItem("notes", JSON.stringify(noteobj));
  addTxt.value = "";
  addTitle.value = "";
  shownotes();
}

//This will show the task added
function shownotes() {
  let notes = localStorage.getItem("notes");
  let addtitle = document.getElementById("addTitle");
  if (notes == null) {
    noteobj = [];
  } else {
    noteobj = JSON.parse(notes);
  }
  let html = "";
  noteobj.forEach(function (element, index) {
    html += `<div class="noteCard my-2 mx-2 card" style="width: 18rem;">
      <div class="card-body">
          <h5 class="card-title">${element.title}</h5>
          <p class="card-text"> ${element.text}</p>
          <button id="${index}"onclick="deleteNote(this.id)" class="btn btn-outline-danger">Delete</button>
          <button id="${index}"onclick="editNote(this.id)" class="btn btn-outline-info">Edit</button>
      </div>
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmarks" id="${
        index + 10000
      }" onclick="addbook(this.id)"onDBLclick="addbook2(this.id)" viewBox="0 0 16 16">
  <path d="M2 4a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v11.5a.5.5 0 0 1-.777.416L7 13.101l-4.223 2.815A.5.5 0 0 1 2 15.5V4zm2-1a1 1 0 0 0-1 1v10.566l3.723-2.482a.5.5 0 0 1 .554 0L11 14.566V4a1 1 0 0 0-1-1H4z"/>
  <path d="M4.268 1H12a1 1 0 0 1 1 1v11.768l.223.148A.5.5 0 0 0 14 13.5V2a2 2 0 0 0-2-2H6a2 2 0 0 0-1.732 1z"/>
</svg>
  </div>`;
  });
  let noteselm = document.getElementById("notes");
  if (noteobj.length != 0) {
    noteselm.innerHTML = html;
  } else {
    noteselm.innerHTML = `Nothing to show`;
  }
}
// for book mark
function addbook(index) {
  let bookmark = document.getElementById(index);
  bookmark.style.fill = "red";
}
function addbook2(index) {
  let bookmark = document.getElementById(index);
  bookmark.style.fill = "black";
}

// to delete the Task
function deleteNote(index) {
  let notes = localStorage.getItem("notes");
  if (notes == null) {
    noteobj = [];
  } else {
    noteobj = JSON.parse(notes);
  }
  //This will delete that particular task from the local storage
  noteobj.splice(index, 1);
  localStorage.setItem("notes", JSON.stringify(noteobj));
  shownotes();
}

//Editing the brief
//This will populate the editing feature
function editNote(index) {
  let notes = localStorage.getItem("notes");
  if (notes == null) {
    noteobj = [];
  } else {
    noteobj = JSON.parse(notes);
  }
  let editlist = document.getElementById("editmode");
  editmode.innerHTML = `<br><h1 class="col text-center">Edit ${noteobj[index].title}</h1> <br> <div class="card">
   <div class="card-body">
     <h5 class="card-title">Edit Title</h5>
       <div class="form-group">
           <textarea class="form-control" id="editTitle" rows="1" placeholder="Task-1"></textarea>
       </div>
       <h5 class="card-title">Edit breif</h5>
       <div class="form-group">
           <textarea class="form-control" id="editTxt" rows="3" placeholder="Paritication in Hacktoberfest"></textarea>
       </div>
       <div class="d-grid mx-auto text-center">
       <button class=" gap-2 col-6  btn btn-outline-warning" id="${index}" onclick="editsubmit(this.id)">Edit</button>
       </div>
       </div>
</div>`;
}

//After submitting the edit button
function editsubmit(index) {
  let notes = localStorage.getItem("notes");
  if (notes == null) {
    noteobj = [];
  } else {
    noteobj = JSON.parse(notes);
  }
  let editTxt = document.getElementById("editTxt");
  let editTitle = document.getElementById("editTitle");
  console.log(noteobj, index);
  noteobj[index].title = editTitle.value;
  noteobj[index].text = editTxt.value;
  localStorage.setItem("notes", JSON.stringify(noteobj));

  let editlist = document.getElementById("editmode");
  editlist.innerHTML = "";
  shownotes();
}


//This is for searching purpose
let search = document.getElementById("searchTxt");
search.addEventListener("input", searchnote);
function searchnote() {
  let val = search.value.toLowerCase();
  let notecard = document.getElementsByClassName("noteCard");
  Array.from(notecard).forEach(function (e) {
    let cardtxt = e.getElementsByTagName("p")[0].innerText;
    if (cardtxt.includes(val)) {
      e.style.display = "block";
    } else {
      e.style.display = "none";
    }
  });
}
