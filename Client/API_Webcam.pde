// █▀█ █▀▀ █▀█ █░█ █ █▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀
// █▀▄ ██▄ ▀▀█ █▄█ █ █▀▄ ██▄ █░▀░█ ██▄ █░▀█ ░█░ ▄█

// For the purposes of avoiding any demo-day curses, we have left the code required to get the program to work with a webcam in here.
// Ideally, we would't be this using this, but rather the ESP32 camera.

/*
Processing Video Library
@ Processing Foundation
Licensed under Creative Commons (CC BY-NC-SA 4.0)
https://processing.org/reference/libraries/video/index.html
*/

import processing.video.*; // Import the official library that lets us utilize the webcam's input.
Capture video; // Video feed

void captureWebcamFeed() {
    if (video == null) return;

    // If there's a newer image available, load that one in. Otherwise, keep the older one loaded in.
    // This is used to combat framerate differences between the camera and our program. Our program runs at 60 FPS, while the webcam or ESP camera run at much lower frame rates.
    if (video.available()) {
        video.read();
        lastValidCameraFeed = video;
        lastValidCameraFeed.save("data/capture.jpg");
    } 
}