class Player {
  PVector pos;
  
  int points = 0;
  int shots = 0;
  int hits = 0;
  int life = 100;
  float magic = 0.0f;
  
  String name = "";
  
  Player() {
    pos = new PVector(width/2, height/2);
    points = 0;
    shots = 0;
    hits = 0;
    life = 100;
    magic = 0.0f;
  }
  
  boolean isAlive() {
    return life > 0;
  }
  
  void draw() {
    noTint();
    noStroke();
    int frameSpan = 30;
    float devilColor = map(abs(frameSpan/2-frameCount%frameSpan), 0, frameSpan, 128, 192);
    float devilBaseSize = map(abs(frameSpan/2-frameCount%frameSpan), 0, frameSpan, 150, 200);
    fill(255, devilColor, devilColor);
    ellipse(pos.x, pos.y, devilBaseSize, devilBaseSize);
    fill(255);
    rectMode(CORNERS);
    rect(pos.x-25, pos.y-15, pos.x+25, pos.y+15);
    image(devilEye, map(mouseX, 0, width, pos.x-18, pos.x-8), map(mouseY, 0, height, pos.y-8, pos.y-2));
    image(devilEye, map(mouseX, 0, width, pos.x+8, pos.x+18), map(mouseY, 0, height, pos.y-8, pos.y-2));
    image(devilFace, pos.x, pos.y);
  
  
  }
  
  int PLAYER_MOVE = 3;
  
  void moveLeft() {
    if(pos.x > 50) pos.x -= PLAYER_MOVE;
  }
  
  void moveRight() {
    if(pos.y < width - 50) pos.x += PLAYER_MOVE;
  }
  
  void moveUp() {
    if(pos.y > 50) pos.y -= PLAYER_MOVE;
  }
  
  void moveDown() {
    if(pos.y < height - 50) pos.y += PLAYER_MOVE ;
  }
  
  
  
}
