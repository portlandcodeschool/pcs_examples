note = new Note();

$("button").addClass("btn btn-primary");

$("#btn-create").click(function(){
  note.subject = $("#txt-subject").val();
  note.content = $("#txt-content").val();
  note.create();
  note.updateIdSelection();
});

$("#btn-update").click(function(){
  id = $("#txt-noteid").val();
  note.subject = $("#txt-subject").val();
  note.content = $("#txt-content").val();
  note.update(id);
});

$("#btn-delete").click(function(){
  id = $("#txt-noteid").val();
  note.remove(id);
});

$("#txt-noteid").change(function(){
  id = $("#txt-noteid").val();
  note.fetch(id);
});

function refresh(){
  note.updateIdSelection();
  notes_collection.fetchAll();
}
refresh();
