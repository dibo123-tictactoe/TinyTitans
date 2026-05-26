int selectedP1 = -1;
int selectedP2 = -1;
boolean p1Locked = false;
boolean p2Locked = false;

PImage[] charImgs = new PImage[5];
PImage[] nameImgs = new PImage[5];
PImage charBoard, selectBtnImg;
PImage p1Img, p2Img, vsImg, startImg;

int[] gx = new int[5];
int[] gy = new int[5];
int cellW = 110, cellH = 110;

// start button position — below charboard center
int startBtnX = 400 - 70;
int startBtnY = 460;
int startBtnW = 150, startBtnH = 100;

void setupCharacterSelect() {
  charImgs[0] = loadImage("eagle.png");
  charImgs[1] = loadImage("chicken.png");
  charImgs[2] = loadImage("rat.png");
  charImgs[3] = loadImage("carabao.png");
  charImgs[4] = loadImage("cockroach.png");

  nameImgs[0] = loadImage("AGILA.png");
  nameImgs[1] = loadImage("MANOK.png");
  nameImgs[2] = loadImage("DAGA.png");
  nameImgs[3] = loadImage("KALABAW.png");
  nameImgs[4] = loadImage("IPIS.png");

  charBoard    = loadImage("charboard.png");
  selectBtnImg = loadImage("selectbutton.png");
  p1Img        = loadImage("player1.png");
  p2Img        = loadImage("player2.png");
  vsImg        = loadImage("vs.png");
  startImg     = loadImage("start.png");
}

void drawCharacterSelectScreen() {
  stroke(255, 0, 0); 
  noFill();
rectMode(CENTER);
rect(gx[i], gy[i], w, h);

  // ── charboard ────────────────────────────────────
  int cW = 400, cH = 280;
  int cX = 200;
  int cY = 160;

  if (charBoard != null) {
    image(charBoard, cX, cY, cW, cH);
  } else {
    fill(30, 80, 120, 200);
    stroke(160, 220, 255);
    strokeWeight(2);
    rect(cX, cY, cW, cH, 10);
    noStroke();
  }

  // ── grid: 3 top, 2 bottom ───────────────────────
  int row1Y = cY + 95;
  int row2Y = cY + 215;

  gx[0] = cX + 60;  gy[0] = row1Y;
  gx[1] = cX + 190; gy[1] = row1Y;
  gx[2] = cX + 330; gy[2] = row1Y;
  gx[3] = cX + 135; gy[3] = row2Y;
  gx[4] = cX + 265; gy[4] = row2Y;

  for (int i = 0; i < 5; i++) {
    imageMode(CENTER);
    if (charImgs[i] != null) {
      if (i == 1) {
        image(charImgs[i], gx[i], gy[i], 130, 130);
      } else if (i == 4) {
        image(charImgs[i], gx[i], gy[i], 200, 200);
      } else if (i == 0) {
        image(charImgs[i], gx[i], gy[i], 150, 150);
      } else if (i == 2) {
        image(charImgs[i], gx[i], gy[i], 120, 110);
      } else {
        image(charImgs[i], gx[i], gy[i], 120, 120);
      }
    }
    imageMode(CORNER);
  }

  // ── player slots ────────────────────────────────
  drawPlayerSlot(1, 100, 300, selectedP1, p1Locked);
  drawPlayerSlot(2, 700, 300, selectedP2, p2Locked);

  // ── PLAYER 1, VS, PLAYER 2 above the characters ─
  // drawn AFTER slots so they appear on top
  imageMode(CENTER);
  if (p1Img != null) image(p1Img, 100, 140, 240, 90);
  if (vsImg != null) image(vsImg, 400, 105, 160, 90);
  if (p2Img != null) image(p2Img, 700, 140, 240, 90);
  imageMode(CORNER);

  // ── START button — bottom center, only when both locked ──
  if (p1Locked && p2Locked) {
    if (startImg != null) {
      image(startImg, startBtnX, startBtnY, startBtnW, startBtnH);
    } else {
      fill(0, 180, 60);
      stroke(0, 255, 80);
      strokeWeight(2);
      rect(startBtnX, startBtnY, startBtnW, startBtnH, 8);
      noStroke();
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(18);
      text("START", 400, startBtnY + startBtnH / 2);
    }
  }
}

void drawPlayerSlot(int pNum, int x, int y, int sel, boolean locked) {
  imageMode(CENTER);

  // portrait
  if (sel != -1 && charImgs[sel] != null) {
    float bob = sin(frameCount * 0.05) * 4;
    int portraitSize = (sel == 1) ? 210 : 180;
    image(charImgs[sel], x, y - 30 + bob, portraitSize, portraitSize);
  }

  // name image
  if (sel != -1 && nameImgs[sel] != null) {
    image(nameImgs[sel], x, y + 100, 200, 50);
  }

  imageMode(CORNER);

  // SELECT button — disappears when locked
  if (!locked) {
    int btnW = 180, btnH = 100;
    int btnX = x - btnW / 2;
    int btnY = y + 130;

    if (selectBtnImg != null) {
      image(selectBtnImg, btnX, btnY, btnW, btnH);
    } else {
      fill(60, 60, 180);
      stroke(180, 180, 255);
      strokeWeight(2);
      rect(btnX, btnY, btnW, btnH, 8);
      noStroke();
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(18);
      text("SELECT", x, btnY + btnH / 2);
    }
  }
}

void mousePressedCharacterSelect() {
  // 1. grid clicks
  for (int i = 0; i < 5; i++) {
    // Determine the dimensions used when drawing in drawCharacterSelectScreen()
    int w = 120; // Default width
    int h = 120; // Default height

    // Match the logic you used in drawCharacterSelectScreen()
    if (i == 1) { w = 130; h = 130; }
    else if (i == 4) { w = 200; h = 200; }
    else if (i == 0) { w = 150; h = 150; }
    else if (i == 2) { w = 120; h = 110; }

    // Now check if mouse is inside the image (using CORNER mode logic for safety)
    // Since images are drawn CENTERED at (gx[i], gy[i]):
    if (mouseX >= gx[i] - w/2 && mouseX <= gx[i] + w/2 &&
        mouseY >= gy[i] - h/2 && mouseY <= gy[i] + h/2) {
      
      if (!p1Locked && mouseX < 400) selectedP1 = i;
      if (!p2Locked && mouseX >= 400) selectedP2 = i;
      return; 
    }
  }

  // 2. SELECT buttons
  int btnW = 140, btnH = 46;

  int p1BtnX = 100 - btnW / 2;
  int p1BtnY = 300 + 130;
  if (!p1Locked && selectedP1 != -1 &&
      mouseX >= p1BtnX && mouseX <= p1BtnX + btnW &&
      mouseY >= p1BtnY && mouseY <= p1BtnY + btnH) {
    p1Locked = true;
    return;
  }

  int p2BtnX = 700 - btnW / 2;
  int p2BtnY = 300 + 130;
  if (!p2Locked && selectedP2 != -1 &&
      mouseX >= p2BtnX && mouseX <= p2BtnX + btnW &&
      mouseY >= p2BtnY && mouseY <= p2BtnY + btnH) {
    p2Locked = true;
    return;
  }

  // 3. START button — bottom center of charboard
  if (p1Locked && p2Locked &&
      mouseX >= startBtnX && mouseX <= startBtnX + startBtnW &&
      mouseY >= startBtnY && mouseY <= startBtnY + startBtnH) {
    gameState = 3;
    println("Going to game! P1=" + selectedP1 + " P2=" + selectedP2);
  }
}

void resetCharacterSelect() {
  selectedP1 = -1;
  selectedP2 = -1;
  p1Locked   = false;
  p2Locked   = false;
}
