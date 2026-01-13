
// █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ █▀   █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀█ ▄▀█   █▀▀ █▀▀ █▀▀ █▀▄
// █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ ▄█   █▄▄ █▀█ █░▀░█ ██▄ █▀▄ █▀█   █▀░ ██▄ ██▄ █▄▀

// If this is set to anything but "", then it will force a fake result (for testing purposes)
String forcedResult = "";

void processCameraFeed() {

  // Capture the latest safe image from the camera
  captureFeed();
  
  if (forcedResult == "") {

    println("Sending a normal request");

    // Send a request to the AI and point to the newly saved image.

    requestDetection("cameraoutput.jpg").thenAccept(result -> {
      // Process Result
      println("Got result of detection.");
      processModelResult(result);
    });
    

  } else processModelResult(forcedResult);

}

void mousePressed() {

  // If the program is already analyzing something, then do nothing
  if (currentScene == "ANALYZE") return;

  // Set the new scene
  SCENE_ANALYZE();

  // Process the camera feed through the AI model.
  processCameraFeed();

  // Returning to normal functioning (default / seeking objects) is done through processCameraFeed();
}



// █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▀ █▀█   █▀▄▀█ █▀█ █▀▄ █▀▀
// █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ ██▄ █▀▄   █░▀░█ █▄█ █▄▀ ██▄

void keyPressed() {
  switch(key) {
    case 'M': SCENE_MAINTENANCE(); break;
    case 'H': SCENE_DEFAULT(); break;
    default: break;
  }
}