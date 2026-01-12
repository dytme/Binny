class LoadingBobber {
  float xPos, yPos;
  String labelContent = "Initializing Model...";
  
  float cornerRadius = 3;
  float barHeight = 12;
  
  float indicatorWidth = 160;
  float barWidth = 30;
  
  float barPosition = indicatorWidth/2;
  
  float speedMultiplier = 2.25;
  int direction = 1;
  
  
  LoadingBobber(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  void setLabel(String s) { labelContent = s; }
  
  void render() {
    
    strokeWeight(1.35);
    
    // Draw background
    rectMode(CENTER);
    fill(#393942);
    rect(xPos, yPos, indicatorWidth, barHeight, cornerRadius);
    
    // Compute new bobber position
    if (barPosition > indicatorWidth-barWidth) direction = -1;
    if (barPosition < 0) direction = 1;
    
    barPosition += direction*speedMultiplier;
    
    rectMode(CORNER);
    
    // Draw bobber
    fill(#FFFFFF);
    rect((xPos-indicatorWidth/2)+barPosition, yPos-barHeight/2, barWidth, barHeight, cornerRadius);

    // (*OPT) Draw Label
    if (labelContent != "") {
      ShadowText labelText = new ShadowText(labelContent, 0, yPos + barHeight*2, width, barHeight*2);
      labelText.setTextSize(16);
      labelText.render();
    }
  }
  
}
