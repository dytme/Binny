
// █▀█ █▀▀ █▀█ █░█ █ █▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀
// █▀▄ ██▄ ▀▀█ █▄█ █ █▀▄ ██▄ █░▀░█ ██▄ █░▀█ ░█░ ▄█

/*
Processing Video Library
@ Processing Foundation
Licensed under Creative Commons (CC BY-NC-SA 4.0)
https://processing.org/reference/libraries/video/index.html
*/

import processing.video.*; // Import the official library that lets us utilize the webcam's input.
Capture video; // Video feed


void cameraFeedSetup() {

  video = new Capture(this, 640, 480); // PApplet + 640x480 resolution, a safe / standard choice.
                                       // The model API will handle resizing, and trying to force a square aspect ratio of 640x640 only caused compression issues.
                                       
  video.start(); // Start capturing the live feed.
  println(video.width, video.height);
}


PImage lastValidCameraFeed;
void cameraFeed() {

  // If the video service hasn't been loaded in yet, return.
  if (video == null) return;

  rectMode(CENTER);

  // If there's a newer image available, load that one in. Otherwise, keep the older one loaded in.
  // This is used to combat framerate differences between the camera and our program. Our program runs at 60 FPS, while the webcam or ESP camera run at much lower frame rates.
  if (video.available()) {
      video.read();
      lastValidCameraFeed = video;
  } 

  if (lastValidCameraFeed != null) image(lastValidCameraFeed, width/2 - 320, height/2 - 240, 640, 480);
}



PImage takePhoto() {
  if (video == null) return null;

  if (video.available()) {
    video.read();
    return video;
  } else return null;


}

void captureFeed() {

    // Capture the webcam's feed
    PImage cameraOutput = takePhoto();

    if (cameraOutput == null) return;
    cameraOutput.save("data/cameraoutput.jpg"); // Save the image (if it exists) to the drive.
    image(cameraOutput, 0, 0); // Preview the image.

}