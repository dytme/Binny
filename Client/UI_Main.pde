
// ██╗███╗░░██╗████████╗███████╗██████╗░███████╗░█████╗░░█████╗░███████╗
// ██║████╗░██║╚══██╔══╝██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝
// ██║██╔██╗██║░░░██║░░░█████╗░░██████╔╝█████╗░░███████║██║░░╚═╝█████╗░░
// ██║██║╚████║░░░██║░░░██╔══╝░░██╔══██╗██╔══╝░░██╔══██║██║░░██╗██╔══╝░░
// ██║██║░╚███║░░░██║░░░███████╗██║░░██║██║░░░░░██║░░██║╚█████╔╝███████╗
// ╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚══════╝

// Assets
PImage binnyIcon;
PImage binnyLogo;
PFont robotoMono48;

PFont poppinsBold100;
PFont poppinsMedium60;

// Objects
LoadingBobber loadingBobber;
ShadowText factLabel;




// █▀ █▀▀ ▀█▀ █░█ █▀█
// ▄█ ██▄ ░█░ █▄█ █▀▀

void settings() {
  // Set up Canvas
  fullScreen();
  pixelDensity(1);
}

void setupWindow() {
  frameRate(60);
  
  // Load in icon before other assets.
  binnyIcon = loadImage("branding/icon_320x.png");
  
  surface.setIcon(binnyIcon);
  surface.setTitle("Binny Desktop Client");
}


void loadAssets() {
  // Load in UI assets
  binnyLogo = loadImage("branding/icon_1600x.png");
  robotoMono48 = loadFont("fonts/RobotoMono-Regular-48.vlw");
  poppinsBold100 = loadFont("fonts/Poppins-Bold-100.vlw");
  poppinsMedium60 = loadFont("fonts/Poppins-Medium-60.vlw");

  // Load in JSON Objects
  funnyPhrases = loadJSONObject("tables/funny_phrases.json");
  funFacts = loadJSONObject("tables/fun_facts.json");
}


void setupInterface() {
  // Load in universal loading bobber
  loadingBobber = new LoadingBobber(width/2, height*4/5 + 120);
  
  // Load in fun fact label (keeps user entertained)
  factLabel = new ShadowText("Loading fun facts to keep you entertained.", width/10, height*4/5, width*8/10, height/4);
  factLabel.setTextFont(robotoMono48);
  factLabel.setTextSize(height/40);

}




// █▀█ █▀▀ █▄░█ █▀▄ █▀▀ █▀█
// █▀▄ ██▄ █░▀█ █▄▀ ██▄ █▀▄

int globalClock = 0; // Basically acts as frameCount but is going to be reset back down to 0 every 60 seconds.
                     // We're doing this so that we can avoid integer overflows, considering that our program runs for a very long time.
void updateGlobalClock() {
  // Increase the globalClock up to 3600 frames (60 seconds)
  if (globalClock >= 3600) globalClock = 0;
  globalClock++;
}



String currentScene = "INITIALIZE";
void updateCurrentScene() {
  // Determine the scene that will be shown.
  switch(currentScene) {
    case "INITIALIZE": SCENE_LOAD(); break;
    case "SERVICE_DESK": RESULT_SERVICE_DESK(); break;
    case "ORGANIC": RESULT_ORGANIC(); break;
    case "PLASTIC": RESULT_PLASTIC(); break;
    case "PAPER": RESULT_PAPER(); break;
    case "RESIDUAL": RESULT_RESIDUAL(); break;
    case "MAINTENANCE": SCENE_MAINTENANCE(); break;
    case "ERROR": SHOW_ERROR(null, null); break;
    case "ANALYZE": SCENE_ANALYZE(); break;
    default: SCENE_DEFAULT(); break; // Idle
  }
}