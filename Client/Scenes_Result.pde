
/*

██████╗░███████╗░██████╗██╗░░░██╗██╗░░░░░████████╗  ░██████╗░█████╗░███████╗███╗░░██╗███████╗░██████╗
██╔══██╗██╔════╝██╔════╝██║░░░██║██║░░░░░╚══██╔══╝  ██╔════╝██╔══██╗██╔════╝████╗░██║██╔════╝██╔════╝
██████╔╝█████╗░░╚█████╗░██║░░░██║██║░░░░░░░░██║░░░  ╚█████╗░██║░░╚═╝█████╗░░██╔██╗██║█████╗░░╚█████╗░
██╔══██╗██╔══╝░░░╚═══██╗██║░░░██║██║░░░░░░░░██║░░░  ░╚═══██╗██║░░██╗██╔══╝░░██║╚████║██╔══╝░░░╚═══██╗
██║░░██║███████╗██████╔╝╚██████╔╝███████╗░░░██║░░░  ██████╔╝╚█████╔╝███████╗██║░╚███║███████╗██████╔╝
╚═╝░░╚═╝╚══════╝╚═════╝░░╚═════╝░╚══════╝░░░╚═╝░░░  ╚═════╝░░╚════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═════╝░

Scenes that render based on the model's detection result.

*/


int splashScreenDuration = 100;


//█▀ █░█ ▄▀█ █▀█ █▀▀ █▀▄   ▄▀█ █▀ █▀ █▀▀ ▀█▀ █▀
//▄█ █▀█ █▀█ █▀▄ ██▄ █▄▀   █▀█ ▄█ ▄█ ██▄ ░█░ ▄█

class ResultCard{
    PImage resultIcon;
    String content;
    color cardColor = -1; // By default, it will have no background/color

    float xSize, ySize;
    float xPos = 0;

    ResultCard(String content, color cardColor, String resultIconDest) {
        this.content = content;
        this.resultIcon = loadImage(resultIconDest);
        this.cardColor = cardColor;
    }

    void render() {

        noStroke();

        // Draw background for the card.
        fill(cardColor);
        rect(xPos, 0, xSize, ySize);

        // Category Icon
        rectMode(RADIUS);
        float resultIconSize = height*1/3.75;
        image(resultIcon, xPos + xSize/2 - resultIconSize/2, ySize*0.32, resultIconSize, resultIconSize);

        // Category Title
        textAlign(CENTER, TOP);

        ShadowText category = new ShadowText(content, xPos, ySize-ySize*0.37, xSize, ySize/10);
        category.setTextFont(poppinsMedium60);
        category.setTextSize(height/18);
        category.render();

    }


}

void renderSharedResultsAssets(String title) {

    textAlign(CENTER, TOP);

    ShadowText sceneTitle = new ShadowText(title, 0, height/10, width, height/6);
    sceneTitle.setTextFont(poppinsBold100);
    sceneTitle.setTextSize(height/10);
    sceneTitle.render();

    fill(000000);
    rect(0, height*4/5-48, width, height);

    factLabel.setTextSize(height/28);
    factLabel.yPos = height*5/6;
    factLabel.render();

}


void renderAlternative() {
    // Residual Card
    ResultCard residual = new ResultCard("RESIDUAL WASTE", #9D9999, "result_icons/RESIDUAL.png");
    residual.xSize = width/2;
    residual.ySize = height;
    residual.xPos = width/2;
    residual.render();

    // OR Text
    ShadowText alternativeText = new ShadowText("OR", 0, height/2-height/16, width, height/6);
    alternativeText.setTextFont(poppinsBold100);
    alternativeText.setTextSize(height/10);
    alternativeText.render();
}


void clearScene() {

    println("Scene finished showing. Returning to the default scene.");
    currentScene = "DEFAULT";

    renderFunFact(true); // Render a new fun fact to replace the (possible) explicit output in the label.
    
    // Stop the code from checking if the result is influenced by Binny's detection or not.
    waitingThrow = false;

    sceneLoaded = false;

}


void isClearAllowed() {

    println(frameCount - resultAppearFrame);
    println(splashScreenFrameCount);

    // If more frames have passed since the screen has appeared than the desired duration, 
    if (frameCount - resultAppearFrame >= splashScreenFrameCount) { 
        clearScene();
    }

}





// █▀█ █▀▀ █▀ █░█ █░░ ▀█▀   █▀ █▀▀ █▀▀ █▄░█ █▀▀ █▀
// █▀▄ ██▄ ▄█ █▄█ █▄▄ ░█░   ▄█ █▄▄ ██▄ █░▀█ ██▄ ▄█

boolean sceneLoaded = false;
int resultAppearFrame = 0;


void RESULT_ORGANIC() {
    
    // Mark the global fields required to keep this scene showing.
    sceneLoaded = true;
    currentScene = "ORGANIC";


    // Render the scene itself.
    color resultColor = #AEC036;
    background(resultColor);
    
    ResultCard organic = new ResultCard("ORGANIC", resultColor, "result_icons/ORGANIC.png");
    organic.xSize = width;
    organic.ySize = height;
    organic.render();


    // Render the explicit output
    factLabel.content = 
        "Did you know: The University will (most likely) use\n" +
        "what you're about to throw out as Biofuel to heat the buildings on campus?";
    renderSharedResultsAssets("MY GUESS IS");


    // Check if it's time to clear the scene on the next iteration
    isClearAllowed();

}




void RESULT_PLASTIC() {

    // Mark the global fields required to keep this scene showing.
    sceneLoaded = true;
    currentScene = "PLASTIC";

    // Render the scene itself
    color resultColor = #F47920;
    background(resultColor);

    // Plastic Card
    ResultCard plastic = new ResultCard("PLASTIC", resultColor, "result_icons/PLASTIC.png");
    plastic.xSize = width / 2;
    plastic.ySize = height;
    plastic.render();

    renderAlternative(); // Mention that it may be dropped off in Residual as well, depending on the item.

    // Render the explicit output
        factLabel.content =
        "You may throw this item into the ORANGE bin,\n" +
        "as long as it is not dirty or contaminated with food.";
    renderSharedResultsAssets("THROW ME IN...");


    // Check if it's time to clear the scene on the next iteration
    isClearAllowed();
}



void RESULT_PAPER() {
    
    // Mark the global fields required to keep this scene showing.
    sceneLoaded = true;
    currentScene = "PAPER";


    // Render the scene itself
    color resultColor = #0080C6;
    background(resultColor);


    // Paper Card
    ResultCard paper = new ResultCard("PAPER", resultColor, "result_icons/PAPER.png");
    paper.xSize = width/2;
    paper.ySize = height;
    paper.render();

    renderAlternative(); // Mention that it may be dropped off in Residual as well, depending on the item.


    // Render the explicit output
    factLabel.content =
        "You may throw this item into the BLUE bin,\n" +
        "as long as it is not dirty or contaminated with food.";
    renderSharedResultsAssets("THROW ME IN...");


    // Check if it's time to clear the scene on the next iteration
    isClearAllowed();

}


void RESULT_RESIDUAL() {
    
    // Mark the global fields required to keep this scene showing.
    sceneLoaded = true;
    currentScene = "RESIDUAL";


    // Render the scene itself.
    color resultColor = #9D9999;
    background(resultColor);
    
    ResultCard organic = new ResultCard("RESIDUAL WASTE", resultColor, "result_icons/RESIDUAL.png");
    organic.xSize = width;
    organic.ySize = height;
    organic.render();


    // Render the explicit output
    factLabel.content = 
        "Unfortunately, there's a chance that this item is not recyclable." +
        "When in doubt, it's better to be safe than to contaminate a recycling plant.";
    renderSharedResultsAssets("THROW ME IN...");


    // Check if it's time to clear the scene on the next iteration
    isClearAllowed();

}


void RESULT_SERVICE_DESK() {
    
    // Mark the global fields required to keep this scene showing.
    sceneLoaded = true;
    currentScene = "SERVICE_DESK";


    // Render the scene itself.
    color resultColor = #E62081;
    background(resultColor);
    
    ResultCard organic = new ResultCard("SERVICE DESK", resultColor, "result_icons/OTHER.png");
    organic.xSize = width;
    organic.ySize = height;
    organic.render();


    // Render the explicit output
    factLabel.content = 
        "This item cannot be disposed of in a regular waste bin.\n" +
        "Please go to the nearest Service Desk (Hal 2B) in order to dispose of it properly.";
    renderSharedResultsAssets("MY GUESS IS");


    // Check if it's time to clear the scene on the next iteration
    isClearAllowed();

}






// █▀▀ █▀█ █▀█ █▀█ █▀█ █▀
// ██▄ █▀▄ █▀▄ █▄█ █▀▄ ▄█


void SHOW_ERROR(String errorCode, String errorMessage) {
    
    // Mark the global fields required to keep this scene showing.
    sceneLoaded = true;
    currentScene = "ERROR";


    // Render the scene itself.
    color resultColor = #DD0051;
    background(resultColor);
    
    if (errorCode == null) errorCode = "FATAL";
    else errorCode = ("CODE " + errorCode);

    ResultCard error = new ResultCard(errorCode, resultColor, "result_icons/ERROR.png");
    error.xSize = width;
    error.ySize = height;
    error.render();


    // Render the explicit output
    factLabel.content = 
        "Unknown Error Occoured.\n" +
        "If this issue persists, please contact my administrators.";
    if (errorMessage != null) factLabel.content = errorMessage;
    renderSharedResultsAssets("ERROR");


    // Check if it's time to clear the scene on the next iteration
    isClearAllowed();

}
