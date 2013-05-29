$(function () {
  $boxes = $('.box');

  $boxes.on('click', function () {
    $this = $(this);
    if ($this.css('background-color') === 'rgb(0, 128, 0)') {
      $this.css('background-color', 'gray');
    } else {
      $this.css('background-color', 'green');
    }

    check_for_win();
  });

  $('#wipe-btn').on('click', function (e) {
    e.preventDefault();
    $boxes.each(function () {
      $this = $(this);
      $this.css('background-color', 'gray');
    });

    $('#success').hide();
  });

  var check_for_win = function () {
    var game_won = true;

    $boxes.each(function () {
      $this = $(this);
      if ($this.css('background-color') !== 'rgb(0, 128, 0)') {
        game_won = false;
      }
    });

    if (game_won) {
      $('#success').show();
    }
  };
});