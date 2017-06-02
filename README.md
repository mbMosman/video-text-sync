# Video-Text-Syncronization

This project demonstrates synchronizing video playback with text content on a web page.

The master branch contains Ruby code to convert a audio captions file (srt) into a JSON file for the web page to use.

The gh-pages branch hosts the sample web page with the Video & Text sync JS code.

Since I generally keep my videos on YouTube, I'm using the [HTML5-YouTube](https://github.com/ginpei/html5-youtube.js) library to wrap HTML5 video features around a YouTube player. Similar code could be used without the library if the video were not loaded from YouTube.
