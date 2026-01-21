
// █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ █▀   █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀█ ▄▀█   █▀▀ █▀▀ █▀▀ █▀▄
// █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ ▄█   █▄▄ █▀█ █░▀░█ ██▄ █▀▄ █▀█   █▀░ ██▄ ██▄ █▄▀

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

		requestDetection("capture.jpg").thenAccept(result -> {
		// Process Result
		println("Got result of detection.");
		processModelResult(result);
		});

	} else { 
		println("Forced result: " + forcedResult);
		processModelResult(forcedResult);
	}

}

void triggerBinny() {

	if (currentScene == "DEFAULT") { // If we're currently in seeking/default mode, trigger the AI based on the viewport
		if (processingDetection) return;
	
		// Process the camera feed through the AI model.
		processCameraFeed();
		// Returning to normal functioning (default / seeking objects) is done through processCameraFeed();
	} else { // Otherwise, tell the program to cut short the splash screen and go back to default/seek mode.
		currentScene = "DEFAULT";
		sceneLoaded = false;
	}

}



// █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▀ █▀█   █▀▄▀█ █▀█ █▀▄ █▀▀
// █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ ██▄ █▀▄   █░▀░█ █▄█ █▄▀ ██▄

void keyPressed() {

	switch(key) {
		case 'm': SCENE_MAINTENANCE(); break;
		case 'h': SCENE_DEFAULT(); break;
		case ' ': triggerBinny(); break;
		default: break;
	}
}