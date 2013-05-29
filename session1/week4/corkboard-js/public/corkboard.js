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
  var method, url;
  var _this = this;

  // This must be a new model
  if (typeof this.id === 'undefined') {
    url = this.baseUrl;
    method = "PUT";
  }
  else {
    url = this.baseUrl + this.id;
    method = "POST";
  }

  $.ajax({
    url: url,
    dataType: 'json',
    data: {
      subject: this.subject,
      content: this.content
    },
    type: method,
    success: function (data) {
      _this.id       = data['id'];
      _this.subject  = data['subject'];
      _this.content  = data['content'];
    }
  });
};

Note.prototype.destroy = function () {
  var _this = this;
  $.ajax({
    url: this.baseUrl + this.id,
    dataType: 'json',
    type: 'DELETE',
    success: function (data) {
      _this = null;
    }
  });
};


(function () {
  window.steve = new NoteJSONP(1).fetch();
  window.existing_model = new Note(1).fetch();
  window.new_model = new Note();
  window.new_model.content = 'saving';
  window.new_model.subject = 'subject';
  window.new_model.save();
  // window.new_model.save();
  // window.new_model.destroy();
})();