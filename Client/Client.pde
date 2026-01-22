
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

String activeCamera = "WEBCAM";
boolean serialConnections = true;

int splashScreenFrameCount = 8*10; // Program runs at 10 FPS. So #*10 seconds.
                                     // We're using frameCount for delays instead of milliseconds because the program is technically supposed to run for weeks on end.
                                     // Miliseconds would overflow at around the 25th day mark, while frameCount can last for much, much longer. (over a year)
int dbUpdateTreshold = 60*10; // After how many frames will the fullness tracker update the file? (per minute for now)

// If this is set to anything but "", then it will force a fake result (for testing purposes)
String forcedResult = "";

int camViewportX = 640;
int camViewportY = 480;




// █▀ █▀▀ ▀█▀ █░█ █▀█
// ▄█ ██▄ ░█░ █▄█ █▀▀

void setup() {
  // println(System.getProperty("java.version"));
  // Version 17.x. Pretty modern, we got a lot of cool things to work with >:3

  frameRate(10); // The program doesn't need to run at more than 10 frames per second
                 // This is also a very stable framerate that we can rely on for things like timing.
  
  settings();
  setupWindow(); // Set up the Processing Sketch Window
  loadAssets(); // Load in things like images and icons
  setupInterface(); // Set up loading screen.

  SCENE_LOAD(); // Set up the loading scene AND load in Internal Services.

}



void setupInternalServices() {
  
  // Establish connection to the Model API
  httpConnectionSetup(); 

  // If we're currently using the Webcam, set it up.
  if (activeCamera == "WEBCAM") cameraFeedSetup();
  // The ESP32 Camera needs to be initialized manually through it's own utility. As such, there's no setup procedure needed in Processing.
  
  // Establish Serial Connections
  if (serialConnections) serialSetup();

  // Initialize today's CSV files (if applicable)
  dataStorageSetup();

  // Clear the loading screen.
  clearScene();

}



// █▀▄ █▀█ ▄▀█ █░█░█
// █▄▀ █▀▄ █▀█ ▀▄▀▄▀

int lastDBUpdFrameCount = 0;
void draw() {

  updateGlobalClock(); // Update and keep track of the global clock (for scheduled tasks)
  updateCurrentScene(); // Update the scene currently being rendered on screen.

  // Every 10 minutes or so, store the latest fullness values to the database
  if (frameCount - lastDBUpdFrameCount > dbUpdateTreshold) {
    lastDBUpdFrameCount = frameCount;
    println("Tracking fullness");
    trackFullness();
  }
  
}





