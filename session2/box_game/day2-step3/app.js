$(function () {
  $boxes = $('.box');

  $boxes.on('click', function () {
    var $this, neighbors;

    $this = $(this);
    neighbors = find_neighbors($this);

    change_color($this);
    $.each(neighbors, function (index, neighbor) { change_color(neighbor) });

    check_for_win();
  });

  $('#wipe-btn').on('click', function (e) {
    var $this;

    e.preventDefault();
    $boxes.each(function () {
      $this = $(this);
      $this.css('background-color', 'gray');
    });

    $('#success').hide();
  });

  var check_for_win = function () {
    var game_won, $this;
    game_won = true;

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

  var change_color = function ($el) {
    if ($el.css('background-color') === 'rgb(0, 128, 0)') {
      $el.css('background-color', 'gray');
    } else {
      $el.css('background-color', 'green');
    }
  };

  var find_neighbors = function ($el) {
    var neighbors = [], $this;

    $('.box').each(function () {
      $this = $(this);

      if ($this.data('row') === $el.data('row')) {
        if ($this.data('col') === $el.data('col') - 1) {
          neighbors.push($this);
        }
        if ($this.data('col') === $el.data('col') + 1) {
          neighbors.push($this);
        }
      }
      if ($this.data('col') === $el.data('col')) {
        if ($this.data('row') === $el.data('row') - 1) {
          neighbors.push($this);
        }
        if ($this.data('row') === $el.data('row') + 1) {
          neighbors.push($this);
        }
      }
    });
    return neighbors;
  };
});