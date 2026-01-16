
/*

██████╗░███████╗░██████╗██╗░░░██╗██╗░░░░░████████╗  ░██████╗░█████╗░███████╗███╗░░██╗███████╗░██████╗
██╔══██╗██╔════╝██╔════╝██║░░░██║██║░░░░░╚══██╔══╝  ██╔════╝██╔══██╗██╔════╝████╗░██║██╔════╝██╔════╝
██████╔╝█████╗░░╚█████╗░██║░░░██║██║░░░░░░░░██║░░░  ╚█████╗░██║░░╚═╝█████╗░░██╔██╗██║█████╗░░╚█████╗░
██╔══██╗██╔══╝░░░╚═══██╗██║░░░██║██║░░░░░░░░██║░░░  ░╚═══██╗██║░░██╗██╔══╝░░██║╚████║██╔══╝░░░╚═══██╗
██║░░██║███████╗██████╔╝╚██████╔╝███████╗░░░██║░░░  ██████╔╝╚█████╔╝███████╗██║░╚███║███████╗██████╔╝
╚═╝░░╚═╝╚══════╝╚═════╝░░╚═════╝░╚══════╝░░░╚═╝░░░  ╚═════╝░░╚════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═════╝░

Scenes that render based on the model's detection result.

*/





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

void renderResultSceneTitle(String title) {

    textAlign(CENTER, TOP);

    ShadowText sceneTitle = new ShadowText(title, 0, height/10, width, height/6);
    sceneTitle.setTextFont(poppinsBold100);
    sceneTitle.setTextSize(height/10);
    sceneTitle.render();


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

    sceneLoaded = false;

}





// █▀█ █▀▀ █▀ █░█ █░░ ▀█▀   █▀ █▀▀ █▀▀ █▄░█ █▀▀ █▀
// █▀▄ ██▄ ▄█ █▄█ █▄▄ ░█░   ▄█ █▄▄ ██▄ █░▀█ ██▄ ▄█

boolean sceneLoaded = false;


void RESULT_ORGANIC() {
    
    currentScene = "ORGANIC";

    if (sceneLoaded) { 
        delay(splashScreenDuration);
    } else {

        color resultColor = #AEC036;

        background(resultColor);
        
        ResultCard organic = new ResultCard("ORGANIC", resultColor, "result_icons/ORGANIC.png");
        organic.xSize = width;
        organic.ySize = height;
        organic.render();

        renderResultSceneTitle("MY GUESS IS");

        factLabel.yPos = height*4/5;
        factLabel.content = "Did you know: The University will (most likely) use\nwhat you're about to throw out as Biofuel to heat the buildings on campus?";
        factLabel.render();

        sceneLoaded = true;
        return;


    }

    clearScene();

}


void RESULT_PLASTIC() {
    
    currentScene = "PLASTIC";

    if (sceneLoaded) { 
        delay(splashScreenDuration);
    } else {

        background(#F47920);

        // Plastic Card
        ResultCard plastic = new ResultCard("PLASTIC", #F47920, "result_icons/PLASTIC.png");
        plastic.xSize = width/2;
        plastic.ySize = height;
        plastic.render();

        renderAlternative(); // Mention that it may be dropped off in Residual as well, depending on the item.

        renderResultSceneTitle("MY GUESS IS");
        

        // Fact Label
        textFont(robotoMono48);

        factLabel.yPos = height*4/5;
        factLabel.content = "You may throw this item into the ORANGE bin,\nas long as it is not dirty or contaminated with food.";
        factLabel.render();

        sceneLoaded = true;
        return;


    }

    clearScene();

}


void RESULT_PAPER() {
    
    currentScene = "PAPER";

    if (sceneLoaded) { 
        delay(splashScreenDuration);
    } else {

        background(#F47920);

        // Plastic Card
        ResultCard paper = new ResultCard("PAPER", #0080C6, "result_icons/PAPER.png");
        paper.xSize = width/2;
        paper.ySize = height;
        paper.render();

        renderAlternative(); // Mention that it may be dropped off in Residual as well, depending on the item.


        renderResultSceneTitle("MY GUESS IS");
        

        // Fact Label
        textFont(robotoMono48);

        factLabel.yPos = height*4/5;
        factLabel.content = "You may throw this item into the BLUE bin,\nas long as it is not dirty or contaminated with food.";
        factLabel.render();

        sceneLoaded = true;
        return;


    }

    clearScene();

}


void RESULT_RESIDUAL() {
    
    currentScene = "RESIDUAL";

    println("Residual Waste Scene Loaded In.");

    if (sceneLoaded) { 
        println("Applying Delay for the result to be properly shown.");
        delay(splashScreenDuration);
    } else {

        println("Applying visual state of the scene");
        color resultColor = #9D9999;
        
        background(resultColor);
        
        ResultCard organic = new ResultCard("RESIDUAL WASTE", resultColor, "result_icons/RESIDUAL.png");
        organic.xSize = width;
        organic.ySize = height;
        organic.render();


        renderResultSceneTitle("MY GUESS IS");
        
        factLabel.yPos = height*4/5;
        factLabel.content = "Unfortunately, there's a chance that this item is not recyclable.\nWhen in doubt, it's better to be safe than to contaminate a recycling plant.";
        factLabel.render();

        println("Stating that the scene was loaded in properly");

        sceneLoaded = true;
        return;


    }

    clearScene();

}


void RESULT_SERVICE_DESK() {
    
    currentScene = "SERVICE_DESK";

    if (sceneLoaded) { 
        delay(splashScreenDuration);
    } else {

        background(#AEC036);
        
        ResultCard organic = new ResultCard("SERVICE DESK", #E62081, "result_icons/OTHER.png");
        organic.xSize = width;
        organic.ySize = height;
        organic.render();


        renderResultSceneTitle("MY GUESS IS");
        
        factLabel.yPos = height*4/5;
        factLabel.content = "This item cannot be disposed of in a regular waste bin.\nPlease go to the nearest Service Desk (Hal 2B) in order to dispose of it properly.";
        factLabel.render();

        sceneLoaded = true;
        return;


    }

    clearScene();

}




// █▀▀ █▀█ █▀█ █▀█ █▀█ █▀
// ██▄ █▀▄ █▀▄ █▄█ █▀▄ ▄█


void SHOW_ERROR(String errorCode, String errorMessage) {
    
    currentScene = "ERROR";

    if (sceneLoaded) { 
        delay(splashScreenDuration);
    } else {

        background(#DD0051);
        
        // Set the Error Code
        if (errorCode == null) errorCode = "FATAL";
        else errorCode = ("CODE " + errorCode);

        ResultCard organic = new ResultCard(errorCode, #DD0051, "result_icons/ERROR.png");
        organic.xSize = width;
        organic.ySize = height;
        organic.render();


        renderResultSceneTitle("ERROR");
        
        factLabel.yPos = height*4/5;
        factLabel.content = "Unknown Error Occoured.\nIf this issue persists, please contact my administrators.";
        if (errorMessage != null) factLabel.content = errorMessage;
        factLabel.render();

        sceneLoaded = true;
        return;


    }

    clearScene();

}