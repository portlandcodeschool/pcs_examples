var Note = function(id) {
  this.baseUrl = '//localhost:9292/note/';
  this.id = id;
  this.subject = '';
  this.content = '';
};

Note.prototype.fetch = function () {
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

Note.prototype.save = function () {

};

(function () {
  var steve = new Note(1).fetch();
})();