
// █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ █▀   █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀█ ▄▀█   █▀▀ █▀▀ █▀▀ █▀▄
// █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ ▄█   █▄▄ █▀█ █░▀░█ ██▄ █▀▄ █▀█   █▀░ ██▄ ██▄ █▄▀

// If this is set to anything but "", then it will force a fake result (for testing purposes)
String forcedResult = "";

void processCameraFeed() {

	// // Capture the latest safe image from the camera
	// if (activeCamera != "NONE") captureFeed();
	
	println("Process Request");

	currentScene = "ANALYZE";

	// If we're already processing another request, then don't overload the model.
	// A client check is normally not be ideal, but in our case, the model will only ever run internally, and won't ever be exposed publicly.
	println("Program processing older request: " + processingDetection);
	if (processingDetection) return;
	
	if (forcedResult == "") {
		println("Sending a normal request");
		// Send a request to the AI and point to the newly saved image.

		requestDetection("esptest.jpg").thenAccept(result -> {
		// Process Result
		println("Got result of detection.");
		processModelResult(result);
		});

	} else { 
		println("Forced result: " + forcedResult);
		processModelResult(forcedResult);
	}

}

void mousePressed() {

	// If the program is not currently in "Seek Object" mode, then do nothing.
	println("Mouse pressed");

	if (currentScene != "DEFAULT") return;
	if (processingDetection) return;

	// Process the camera feed through the AI model.
	processCameraFeed();
	// Returning to normal functioning (default / seeking objects) is done through processCameraFeed();

}



// █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▀ █▀█   █▀▄▀█ █▀█ █▀▄ █▀▀
// █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ ██▄ █▀▄   █░▀░█ █▄█ █▄▀ ██▄

void keyPressed() {
	switch(key) {
		case 'm': SCENE_MAINTENANCE(); break;
		case 'h': SCENE_DEFAULT(); break;
		default: break;
	}
}