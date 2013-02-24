var links = [];
var numShakes = 1;

// Display a link when there's an error
function noImg(obj) { $(obj).replaceWith('Imagine a video is here. Or click through to see it.'); }

$(document).ready(function(){
  // $.getJSON also works for this but it's uglier
  // $.getJSON('http://api.twitter.com/1/statuses/user_timeline.json?screen_name=best_of_mlkshk&trim_user=1&include_entities=1&count=' + numShakes + '&callback=?', function(data) {});
  $.ajax({
    dataType: 'jsonp',
    url: '//api.twitter.com/1/statuses/user_timeline.json',
    data: {
      screen_name: 'best_of_mlkshk',
      trim_user: 1,
      include_entities: 1,
      count: numShakes
    },
    success: function () {
      $.each(data, function(i, item){
        var link, image_link, dupe = false;
        var entity_url = item.entities.urls[0];
        var title = item.text.match(/"(.*)"/)[1];

        if (typeof entity_url != "undefined") {
          link = entity_url.expanded_url;
          image_link = link.replace("com/p","com/r");
        }

        $.each(links, function(g, thang){
          if (link == thang[0]) {
            dupe = true;
          }
        });

        if (!dupe && link != 'null') {
          shake = $('<li class="uno-shake" />').html('<a href="' + link + '"><img src="' + image_link + '" alt="' + title + '" onerror="noImg(this);" /></a>');
          $("#all-dem-shakes").append(shake);
        }
      });
    }
  });
});