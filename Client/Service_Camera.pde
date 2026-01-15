/*

░█████╗░░█████╗░███╗░░░███╗███████╗██████╗░░█████╗░  ░██████╗███████╗██████╗░██╗░░░██╗██╗░█████╗░███████╗
██╔══██╗██╔══██╗████╗░████║██╔════╝██╔══██╗██╔══██╗  ██╔════╝██╔════╝██╔══██╗██║░░░██║██║██╔══██╗██╔════╝
██║░░╚═╝███████║██╔████╔██║█████╗░░██████╔╝███████║  ╚█████╗░█████╗░░██████╔╝╚██╗░██╔╝██║██║░░╚═╝█████╗░░
██║░░██╗██╔══██║██║╚██╔╝██║██╔══╝░░██╔══██╗██╔══██║  ░╚═══██╗██╔══╝░░██╔══██╗░╚████╔╝░██║██║░░██╗██╔══╝░░
╚█████╔╝██║░░██║██║░╚═╝░██║███████╗██║░░██║██║░░██║  ██████╔╝███████╗██║░░██║░░╚██╔╝░░██║╚█████╔╝███████╗
░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝  ╚═════╝░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚══════╝

Handles the input of the Webcam or an External Camera.

*/



// █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
// ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█

String activeCamera = "NONE";




// █▀ █▀▀ ▀█▀ █░█ █▀█
// ▄█ ██▄ ░█░ █▄█ █▀▀

void cameraFeedSetup() {

  video = new Capture(this, 640, 480); // PApplet + 640x480 resolution, a safe / standard choice.
                                       // The model API will handle resizing, and trying to force a square aspect ratio of 640x640 only caused compression issues.
                                       
  video.start(); // Start capturing the live feed.
  println(video.width, video.height);
}



// █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀█ ▄▀█   █▀▀ █▀▀ █▀▀ █▀▄
// █▄▄ █▀█ █░▀░█ ██▄ █▀▄ █▀█   █▀░ ██▄ ██▄ █▄▀

PImage lastValidCameraFeed;

void cameraFeed() {

    // Depending on the current cameraType, apply the specific logic of each,
    // in order to update lastValidCameraFeed

    if (activeCamera == "ESP32") {
        captureESPFeed();
    } else if (activeCamera == "WEBCAM") {
        captureWebcamFeed();
    }
      
    // Draw the latest valid image taken from whatever camera we have enabled right now.
    rectMode(CENTER);
    println(lastValidCameraFeed);
    if (lastValidCameraFeed != null) image(lastValidCameraFeed, width/2 - 320, height/2 - 240, 640, 480);
}