
//█▀ █░█ ▄▀█ █▀█ █▀▀ █▀▄   ▄▀█ █▀ █▀ █▀▀ ▀█▀ █▀
//▄█ █▀█ █▀█ █▀▄ ██▄ █▄▀   █▀█ ▄█ ▄█ ██▄ ░█░ ▄█

String randomJSONString(JSONObject jsonObj) {

  int jsonLength = jsonObj.size(); // Get the amount of strings
  String randomKey = str( (int) random(0, jsonLength) ); // Get a random key
  
  // print("Seeking index: " + randomKey + " in JSON: " + System.identityHashCode(jsonObj));

  String result = jsonObj.getString(randomKey); // Save the string.
  return result;
}

void renderFunFact(boolean force) {
  textAlign(CENTER, TOP);
  factLabel.setTextSize(height/32);

  if ((globalClock) % 400 == 0 || force) {
    factLabel.content = randomJSONString(funFacts);
  }

  factLabel.render();
}

void binnyLogo(String mode) {
  rectMode(CORNERS);
  
  float logoSize = height*1/10;
  float logoY = height/12;
  float textY = height/12 + logoSize + logoSize*1/4;

  if (mode == "CENTER") {
    logoSize = height/6;
    logoY = height/2 - logoSize;
    textY = height/2 + logoSize*1/4;
  }

  
  image(binnyLogo, width/2 - logoSize/2, logoY, logoSize, logoSize);


  textFont(robotoMono48);
  textAlign(CENTER,CENTER);
  ShadowText binny = new ShadowText("BINNY", 0, textY, width, logoSize*1/6);
  binny.setTextSize(logoSize*1/6);
  binny.render();
  
  ShadowText catchphrase = new ShadowText("Snap it. Sort it.", 0, binny.yPos+binny.ySize, width, logoSize*1/4);
  catchphrase.setTextSize(logoSize*1/8);
  catchphrase.render(); 
}


void updateLoadingBobber() {
    // Set the label of the bobber to something funny every couple of seconds.
    if ((globalClock) % 200 == 0) {
        loadingBobber.setLabel(randomJSONString(funnyPhrases));
    }

    // Loading Bobber
    loadingBobber.render();
}





//█ █▀▄ █░░ █▀▀   █▀ █▀▀ █▀▀ █▄░█ █▀▀ █▀
//█ █▄▀ █▄▄ ██▄   ▄█ █▄▄ ██▄ █░▀█ ██▄ ▄█



JSONObject funFacts;
// Some of these facts were taken from https://www.europarl.europa.eu/topics/en/article/20181212STO21610/plastic-waste-and-recycling-in-the-eu-facts-and-figures

void SCENE_DEFAULT() {
  currentScene = "DEFAULT"; // Set the current scene variable to itself.
  background(#000000);
  
  // Draw Binny Logo
  binnyLogo("");

  factLabel.yPos = height*5/6;
  renderFunFact(false);

  // Draw ViewPort
  cameraFeed();

  // Draw the indicators that help users line up their objects with binny
  noStroke();
  fill(#44FF9999);
  rectMode(CENTER);
  rect(width/2, height/2, 100, 3);
  rect(width/2, height/2, 3, 100);

  stroke(#44FF9999);
  strokeWeight(3);
  noFill();
  rect(width/2, height/2, camViewportX-100, camViewportY-100);

  ShadowText usageInstructions = new ShadowText(("How to use:\nLay flat on the table a SINGLE object and line it up with Binny's viewport, then press SPACEBAR."), 0, height / 2 + camViewportY/2 * 1.2, width, 48);
  usageInstructions.setTextSize(20);
  usageInstructions.setTextFont(robotoMono48);
  usageInstructions.setTextColor(#FF9999);
  usageInstructions.render();

  
  // fill(#C9C9C9);
  // rect(width/2, height/2, 640, 480);

}


JSONObject funnyPhrases;

void SCENE_ANALYZE() {

    currentScene = "ANALYZE";
    //background(#3DA3F8);
    background(#000000);
    
    // Draw Binny Logo
    binnyLogo("CENTER");
    
    // Render fun facts while the model is working.
    factLabel.yPos = height*2.15/3;
    renderFunFact(false);

    updateLoadingBobber();

}



// This scene should show whenever we disconnect the modules
void SCENE_MAINTENANCE() {

  currentScene = "MAINTENANCE";
  
  background(#767676);

  ResultCard organic = new ResultCard("I'M BEING WORKED ON!", #767676, "result_icons/MAINTENANCE.png");
  organic.xSize = width;
  organic.ySize = height;
  organic.render();


  renderSharedResultsAssets("MAINTENANCE");


  factLabel.content = "I'm temporarily offline while being worked on.\nPlease check back in later!";
  factLabel.render();

  return;

}




