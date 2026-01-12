
// █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ █▀   █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀█ ▄▀█   █▀▀ █▀▀ █▀▀ █▀▄
// █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ ▄█   █▄▄ █▀█ █░▀░█ ██▄ █▀▄ █▀█   █▀░ ██▄ ██▄ █▄▀

void processCameraFeed() {

  // Capture the latest safe image from the camera
  captureFeed();
  
  // Send a request to the AI and point to the newly saved image.
  String result = requestDetection("cameraoutput.jpg");
  
  // Process Result
  processModelResult(result);

}

void mousePressed() {
  SCENE_ANALYZE();
  processCameraFeed();
}



// █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▀ █▀█   █▀▄▀█ █▀█ █▀▄ █▀▀
// █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ ██▄ █▀▄   █░▀░█ █▄█ █▄▀ ██▄

void keyPressed() {
  switch(key) {
    case 'M': SCENE_MAINTENANCE(); break;
    default: SCENE_DEFAULT(); break;
  }
}