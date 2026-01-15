
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


void cameraFeedSetup() {

  video = new Capture(this, 640, 480); // PApplet + 640x480 resolution, a safe / standard choice.
                                       // The model API will handle resizing, and trying to force a square aspect ratio of 640x640 only caused compression issues.
                                       
  video.start(); // Start capturing the live feed.
  println(video.width, video.height);
}


String camIP = "10.160.37.57";
String picURL = "http://" + camIP + "/capture";

PImage lastValidCameraFeed;
void cameraFeed() {

  // If the video service hasn't been loaded in yet, return.
  // if (video == null) return;

  
  // If there's a newer image available, load that one in. Otherwise, keep the older one loaded in.
  // This is used to combat framerate differences between the camera and our program. Our program runs at 60 FPS, while the webcam or ESP camera run at much lower frame rates.
  /*
  if (video.available()) {
    video.read();
    lastValidCameraFeed = video;
    } 
  */

  println("actively capturing field");

  try {
    byte[] pic = loadBytes(picURL);
    // println(pic);
    // if (pic != null) println(pic.length);
    if (pic != null && pic.length > 0) {  
      saveBytes("data/capture.jpg", pic);
      lastValidCameraFeed = loadImage("capture.jpg");
      println("Picture taken and saved as 'capture.jpg' (" + pic.length + " bytes)");
    } else { 
      println("Picture failed (null/0 bytes");
      // SHOW_ERROR("404", "Camera stream not found or invalidated.");
    }
  } catch (Exception e) {
    println("Capture error: " + e);
  }
    
    
    
    rectMode(CENTER);
  if (lastValidCameraFeed != null) image(lastValidCameraFeed, width/2 - 320, height/2 - 240, 640, 480);
}



PImage takePhoto() {
  if (video == null) return null;

  if (video.available()) {
    video.read();
    return video;
  } else return null;


}

// Save a valid camera feed as a local file for the model to reference.
void captureFeed() {

  /*
    // Capture the webcam's feed
    PImage cameraOutput = takePhoto();

    println("Camera output: " + cameraOutput);
    //if (cameraOutput == null) return;

    while (cameraOutput == null) delay(10);

    println("Capturing image");
    cameraOutput.save("data/cameraoutput.jpg"); // Save the image (if it exists) to the drive.
  */

  while (lastValidCameraFeed == null) {
    println("Waiting for valid camera feed");
    delay(20);
  }

  lastValidCameraFeed.save("data/cameraoutput.jpg");
    
}