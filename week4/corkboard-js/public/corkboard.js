var NoteJSONP = function(id) {
  this.baseUrl = '//localhost:9292/note/';
  this.id = id;
  this.subject = '';
  this.content = '';
};

NoteJSONP.prototype.fetch = function () {
  $.ajax({
    url: this.baseUrl + this.id,
    dataType: 'jsonp',
    type: 'GET',
    success: function (data) {
      this.subject = data['subject'];
      this.content = data['content'];
    }
  });
};

NoteJSONP.prototype.save = function () {
  // Oh shit, JSON-P isn't possible over GET. Should I change the server
  // or look somewhere else?
};

var Note = function(id) {
  this.baseUrl = '/note/';
  if (typeof id !== 'undefined' ) {
    this.id = id;
  }
  this.subject = '';
  this.content = '';
};

Note.prototype.fetch = function () {
  // This must be a new model
  if (typeof this.id === 'undefined') {
    return this;
  }

  $.ajax({
    url: this.baseUrl + this.id,
    dataType: 'json',
    type: 'GET',
    success: function (data) {
      this.subject = data['subject'];
      this.content = data['content'];
    }
  });
};

Note.prototype.save = function () {
  var method;

  // This must be a new model
  if (typeof this.id === 'undefined') {
    method = "PUT";
  }
  else {
    method = "POST";
  }

  $.ajax({
    url: this.baseUrl + this.id,
    dataType: 'json',
    data: {
      subject: this.subject,
      content: this.content
    },
    type: 'POST',
    success: function (data) {
      this.id = data['id'];
      this.subject = data['subject'];
      this.content = data['content'];
    }
  });
};

Note.prototype.destroy = function () {
  $.ajax({
    url: this.baseUrl + this.id,
    dataType: 'json',
    type: 'DELETE'
  });
};


(function () {
  var steve = new NoteJSONP(1).fetch();
  var existing_model = new Note(1).fetch();
  var new_model = new Note().save();
})();