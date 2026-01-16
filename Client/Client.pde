
/*

██████╗░██╗███╗░░██╗███╗░░██╗██╗░░░██╗
██╔══██╗██║████╗░██║████╗░██║╚██╗░██╔╝
██████╦╝██║██╔██╗██║██╔██╗██║░╚████╔╝░
██╔══██╗██║██║╚████║██║╚████║░░╚██╔╝░░
██████╦╝██║██║░╚███║██║░╚███║░░░██║░░░
╚═════╝░╚═╝╚═╝░░╚══╝╚═╝░░╚══╝░░░╚═╝░░░

█▀▀ █░░ █ █▀▀ █▄░█ ▀█▀   █▀ █░█ █ ▀█▀ █▀▀
█▄▄ █▄▄ █ ██▄ █░▀█ ░█░   ▄█ █▄█ █ ░█░ ██▄

Software Created by @d_ytme (Sammy)

*/



// █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
// ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█

String activeCamera = "ESP32";

int splashScreenDuration = 5000;

// If this is set to anything but "", then it will force a fake result (for testing purposes)
String forcedResult = "";




// █▀ █▀▀ ▀█▀ █░█ █▀█
// ▄█ ██▄ ░█░ █▄█ █▀▀

void setup() {
  // println(System.getProperty("java.version"));
  // Version 17.x. Pretty modern, we got a lot of cool things to work with >:3
  
  settings();
  setupWindow(); // Set up the Processing Sketch Window
  loadAssets(); // Load in Assets
  setupInterface(); // Set up loading screen.

  SCENE_LOAD(); // Set up the loading scene AND load in Internal Services.

}



void setupInternalServices() {
  
  httpConnectionSetup(); // Establish connection to the Model API
  if (activeCamera == "WEBCAM") cameraFeedSetup(); // OPT* Establish connection to Webcam
  // The ESP32 Camera needs to be initialized manually through it's own utility. As such, there's no setup procedure needed in Processing.
  
  // Clear the loading screen.
  clearScene();

}



// █▀▄ █▀█ ▄▀█ █░█░█
// █▄▀ █▀▄ █▀█ ▀▄▀▄▀

void draw() {

  updateGlobalClock(); // Update and keep track of the global clock (for scheduled tasks)
  updateCurrentScene(); // Update the scene currently being rendered on screen.
  
}





