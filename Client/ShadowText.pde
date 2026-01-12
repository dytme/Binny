class ShadowText {
  String content;
  float xPos, yPos, xSize, ySize;
  float textSize = -1;
  PFont textFont;
  
  float shadowOffset = 3;
  
  ShadowText(String content, float xPos, float yPos, float xSize, float ySize) {
    this.content = content;
    this.xSize = xSize;
    this.ySize = ySize;
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  void setTextSize(float s) {
    textSize = s;
    shadowOffset = textSize/12;
  }
  
  void setTextFont(PFont f) { textFont = f; }
  
  void render() {
    if (textFont != null) textFont(textFont);
    if (textSize > 0) textSize(textSize);
    
    // println(content + ": " + xPos + " / " + yPos + " / " + xSize  + " / " + ySize);
    
    rectMode(CORNER);
    // Shadow
    fill(#44000000);
    if (content == null) content = ""; // Reset content if it's ever set to null;
    //text(content, xPos+shadowOffset, yPos+shadowOffset, xSize, ySize);
    // Actual Text
    fill(#FFFFFF);
    text(content, xPos, yPos, xSize, ySize);
  }
}
