//const captionsFileURL = "captions.json";
const captionsFileURL = "text.json";
const youtubeVideoId = 'TrJKPP4kVHU';

const videoElement = $('#video').get(0);

$.getJSON(captionsFileURL, function (json) {

  $("#videoText").append(buildTextHTML(json));
  const $spans = $("span");

  let player = youtube({
    el: videoElement,
    id: youtubeVideoId,
    rel: false,
    modestbranding: true
  });

  player.addEventListener('ready', function (event) {
    this.play();
  });

  player.addEventListener('timeupdate', function (event) {
    console.log(player.currentTime);
    $spans.each(function (item) {
      let span = $(this);
      let start = span.attr("data-start");
      let end = span.attr("data-end");
      let time = player.currentTime;
      if (time >= start && time <= end) {
        span.addClass('current');
      } else {
        span.removeClass('current');
      }
    });
  });

}).fail(function () {
  $("#videoText").append("Sorry the video text could not be loaded at this time.");
})

function showsection(time) {

};

function buildTextHTML(data) {
  let html = '';
  if (data.paras != undefined) {
    console.log("has paras");
    data.paras.forEach(function (para, index) {
      html += '<p>'
      para.captions.forEach(function (item, index) {
        html += '<span data-start="' + item.start + '" data-end="' + item.end + '">' + item.text + '</span> ';
      });
      html += '</p>'
    });
  } else {
    console.log("no paras")
    html += '<p>'
    data.captions.forEach(function (item, index) {
      html += '<span data-start="' + item.start + '" data-end="' + item.end + '">' + item.text + '</span> ';
    });
    html += '</p>'
  }

  return html;
}