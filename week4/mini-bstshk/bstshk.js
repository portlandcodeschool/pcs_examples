var links = [];
var numShakes = 1;

// Sometimes people like videos, but we can't display them because this is a hack.
function noImg(obj) { $(obj).replaceWith('Imagine a video is here. Or click through to see it.'); }

$(document).ready(function(){
  $.getJSON('http://api.twitter.com/1/statuses/user_timeline.json?screen_name=best_of_mlkshk&trim_user=1&include_entities=1&count=' + numShakes + '&callback=?', function(data) {

    $.each(data, function(i, item){
      var link, title;

      if (typeof item.entities.urls[0] != "undefined") {
        link = item.entities.urls[0].expanded_url;
        image_link = link.replace("com/p","com/r");
      }
      title = item.text.match(/"(.*)"/)[1];

      // I don't want any dupes, yo.
      var dupe = false;
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
  });
});