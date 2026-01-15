
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
  
  httpConnectionSetup();
  // cameraFeedSetup();
  
  sceneLoaded = false;
  currentScene = "DEFAULT";

}


boolean servicesReady = false;

void draw() {

  updateGlobalClock(); // Update and keep track of the global clock (for scheduled tasks)
  updateCurrentScene(); // Update the scene currently being rendered on screen.
  
}





