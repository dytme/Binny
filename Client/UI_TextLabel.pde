class ShadowText {
  String content;
  float xPos, yPos, xSize, ySize;
  float textSize = 48;
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
    this.textSize = s;
    // shadowOffset = textSize/12;
  }
  
  void setTextFont(PFont f) { textFont = f; }
  
  void render() {
    if (textFont != null) textFont(textFont);
    if (textSize > 0) textSize(this.textSize); println(this.content + ": " + this.textSize);
    
    // println(content + ": " + xPos + " / " + yPos + " / " + xSize  + " / " + ySize);
    
    rectMode(CORNER);

    if (content == null) content = ""; // Reset content if it's ever set to null;
    
    // Shadow
    // fill(#44000000);
    //text(content, xPos+shadowOffset, yPos+shadowOffset, xSize, ySize);
    // Actual Text
    fill(#FFFFFF);
    text(content, xPos, yPos, xSize, ySize);
  }
}
