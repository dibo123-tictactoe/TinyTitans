// 1. Updated variable name
PImage[] aiCardImgs = new PImage[5];
PImage leftArrowImg, rightArrowImg, start2Img; 
int aiCardIndex = 0;

int leftArrX  = 60,  leftArrY  = 250, arrW = 60, arrH = 70;
int rightArrX = 680, rightArrY = 250;
float start2BtnX = 650, start2BtnY = 520, start2BtnW = 160, start2BtnH = 60; 

void setupPlayerVsAI() {
  aiCardImgs[0] = loadImage("eagleAI.png");
  aiCardImgs[1] = loadImage("chickenAI.png");
  aiCardImgs[2] = loadImage("ratAI.png");
  aiCardImgs[3] = loadImage("carabaoAI.png");
  aiCardImgs[4] = loadImage("cockroachAI.png");

  leftArrowImg  = loadImage("leftarrow.png"); 
  rightArrowImg = loadImage("rightarrow.png");
  
  // 2. Updated loader to use "start2.png"
  start2Img = loadImage("start2.png"); 
}

void drawPlayerVsAIScreen() {
  pushMatrix();
  scale(scaleW, scaleH);
  
  imageMode(CENTER);
  if (aiCardImgs[aiCardIndex] != null) {
    image(aiCardImgs[aiCardIndex], 400, 300, 800, 600);
  }
  
  imageMode(CORNER);
  if (leftArrowImg != null) image(leftArrowImg, leftArrX, leftArrY, arrW, arrH);
  if (rightArrowImg != null) image(rightArrowImg, rightArrX, rightArrY, arrW, arrH);
  
  // 3. Updated drawer to use start2Img
  imageMode(CENTER);
  if (start2Img != null) {
    image(start2Img, start2BtnX, start2BtnY, start2BtnW, start2BtnH);
  }
  
  popMatrix();
}

void mousePressedPlayerVsAI() {
  float mouseX_scaled = mouseX / scaleW;
  float mouseY_scaled = mouseY / scaleH;
  
  if (mouseX_scaled >= leftArrX && mouseX_scaled <= leftArrX + arrW &&
      mouseY_scaled >= leftArrY && mouseY_scaled <= leftArrY + arrH) {
    aiCardIndex = (aiCardIndex - 1 + 5) % 5;
  }
  else if (mouseX_scaled >= rightArrX && mouseX_scaled <= rightArrX + arrW &&
           mouseY_scaled >= rightArrY && mouseY_scaled <= rightArrY + arrH) {
    aiCardIndex = (aiCardIndex + 1) % 5;
  }
  else if (mouseX_scaled >= start2BtnX - start2BtnW/2 && mouseX_scaled <= start2BtnX + start2BtnW/2 &&
           mouseY_scaled >= start2BtnY - start2BtnH/2 && mouseY_scaled <= start2BtnY + start2BtnH/2) {
    gameState = 3; 
  }
}
