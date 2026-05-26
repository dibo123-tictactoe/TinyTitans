import gifAnimation.*;
Gif bg;
PImage titleImg, startBtnImg;
int gameState = 0;

void setup() {
  size(800, 600);
  bg = new Gif(this, "front.gif");
  bg.loop();
  bg.play();
  titleImg    = loadImage("title.png");
  startBtnImg = loadImage("presstostart.png");
  setupGameMode();
  setupCharacterSelect();
}

void draw() {
  background(0);
  if (gameState == 0) {
    drawStartScreen();
  } else if (gameState == 1) {
    drawGameModeScreen();
  } else if (gameState == 2) {
    drawCharacterSelectScreen();
  }
}

void drawStartScreen() {
  image(bg, 0, 0, 800, 600);
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
  }
}
