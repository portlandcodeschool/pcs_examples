var Note = function (){
  this.baseUrl = "/note/";
};

Note.prototype.updateIdSelection = function(){
  $.ajax({
    url: "/notes",
    dataType: 'json',
    type: 'GET',
    success: function(data){
      $("#txt-noteid").html("");
      $(data).each(function(index){
        var curId = data[index]["id"];
        $("#txt-noteid").append('<option value="' + curId + '">'+curId+'</option>');
      });
    }
  });
};

Note.prototype.fetch = function(id){
  var _this = this;
  return $.ajax({
    url: this.baseUrl + id,
    dataType: 'json',
    type: 'GET',
    success: function(data){
      _this.subject = data['subject'];
      _this.content = data['content'];
      console.log(this.subject);
      $("#content").html("id:" + data["id"] + ", " +_this.subject+", "+_this.content);
      note.fetchAll();
      $("#txt-subject").val(_this.subject);
      $("#txt-content").val(_this.content);
    }
  });
};

Note.prototype.create = function(){
  var _this = this;
  $.ajax({
    url: this.baseUrl,
    dataType: 'json',
    type: "PUT",
    data: JSON.stringify({subject: this.subject, content: this.content}),
    success: function(data){
      _this.subject = data['subject'];
      _this.content = data['content'];
      console.log(_this.subject);
      $("#content").html(data['subject']+", "+data['content']);
      refresh();
    },
    error: function(e){
      console.log(e.responseText);
    }
  });
};

Note.prototype.update = function(id){
  var _this = this;
  $.ajax({
    url: this.baseUrl + id,
    dataType: 'json',
    type: 'POST',
    data:JSON.stringify({subject: this.subject, content: this.content}),
    success: function(data){
      _this.subject = data['subject'];
      _this.content = data['content'];
      console.log(_this.subject);
      $("#content").html(data['id']+": "+data['subject']+", "+data['content']);
      note.fetchAll();
    },
    error: function(e){
      console.log(e.responseText);
    }
  });
};

Note.prototype.remove = function(id){
  $.ajax({
    url: this.baseUrl + id,
    dataType: 'json',
    type: 'DELETE',
    success: function(data){
      $("#content").html("Content with id: " + id + " deleted.");
      refresh();
    },
    error: function(e){
      console.log(e.responseText);
    }
  });
};











