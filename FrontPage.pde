import gifAnimation.*;
Gif bg;
PImage titleImg, startBtnImg;
int gameState = 0;
float scaleH, scaleW;

void setup() {
  size(800, 600);
  scaleW = (float)width / 800.0;
  scaleH = (float)height / 600.0;
  bg = new Gif(this, "front.gif");
  bg.loop();
  bg.play();
  titleImg    = loadImage("title.png");
  startBtnImg = loadImage("presstostart.png");
  setupGameMode();
  setupCharacterSelect();
  setupPlayerVsAI();
}

void draw() {
  background(0); 
  
  // Only draw the screen for the current state
  if (gameState == 0) drawStartScreen();
  else if (gameState == 1) drawGameModeScreen();
  else if (gameState == 2) drawCharacterSelectScreen();
  else if (gameState == 4) drawPlayerVsAIScreen();
}

void drawStartScreen() {
  image(bg, 0, 0, width, height);
  image(titleImg,    100, 150, 600, 300);
  image(startBtnImg, 250, 430, 300, 100);
}

void mousePressed() {
  if (gameState == 0) {
    if (mouseX > 250 && mouseX < 550 &&
        mouseY > 430 && mouseY < 530) {
      gameState = 1;
    }
  } else if (gameState == 1) {
    mousePressedGameMode();
  } else if (gameState == 2) {
    mousePressedCharacterSelect();
  } else if (gameState == 3) {
    // main game mouse
  } else if (gameState == 4) {
    mousePressedPlayerVsAI();
  }
}
