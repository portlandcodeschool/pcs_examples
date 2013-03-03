var NotesCollection = function () {
  this.notes = [];

  this.fetch = function () {
    $.ajax({
      url: "/notes",
      dataType: 'json',
      type: 'GET',
      context: this,
      success: function(data){
        this.add_all_notes_to_collection(data);
        this.write_all_posts_to_page(data);
      }
    });
  };

  this.add_all_notes_to_collection = function (data) {

  };

  this.write_all_posts_to_page = function (data) {
    var str = "<br>All Row Data: =======================><br>";
    $(data).each(function(index){
      var subject = data[index]["subject"];
      var content = data[index]["content"];
      str += "id:" + data[index]["id"] + ", subject: " + subject + ", content:"+ content + "<br>";
    });
    $("#content").append(str);
  };
};