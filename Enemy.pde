
int ENEMY_TOTAL_LIVES = 8;
float ENEMY_SPEED = 1.6;
float PROBABILITY_CHANGE_DIRECTION = 0.95;
final int TO_RIGHT = 0, TO_UP = 1, TO_LEFT = 2, TO_DOWN = 3;

class Enemy implements Comparable<Enemy>{
  PVector pos;
  int dir;
  int lives;
  int hits = 0;
  int lastShot = -1;
  int lastDamage = -1;
  PImage sprite = enemySpriteRight;
  
  Enemy() {
    pos = new PVector(random(0, width), random(0, height));
    do {
      pos = new PVector(random(0, width), random(0, height));
    } while(dist(width/2, height/2, pos.x, pos.y) < 150);
    dir = (int) random(4);
    if(dir == TO_LEFT) {
      sprite = enemySpriteLeft;
    }
    lives = 8;
  }
  
  boolean isAlive() {
    return lives > 0;
  }
  
  void nextStep() {
    if(isAlive()) {
      if(random(1) > PROBABILITY_CHANGE_DIRECTION) {
          this.dir = (int) random(4);
      }
      switch(dir) {
        case TO_RIGHT: {
          if(pos.x + ENEMY_SPEED < width - sprite.width/2) {
            pos.x += ENEMY_SPEED;
            sprite = enemySpriteRight;
          }
          break;
        }
        case TO_UP: 
          if(pos.y + ENEMY_SPEED < height - sprite.height/2)
            pos.y += ENEMY_SPEED;
            break;
        case TO_LEFT: {
          if(pos.x - ENEMY_SPEED - sprite.width/2 > 0) {
            pos.x -= ENEMY_SPEED;
            sprite = enemySpriteLeft;
          }
          break;
        }  
        case TO_DOWN: {
          if(pos.y - ENEMY_SPEED > 0) {
            pos.y -= ENEMY_SPEED; 
          }
          break;
        }
      }
      if(lives < ENEMY_TOTAL_LIVES && frameCount/100 > lastShot/100+1) {
        lastShot = frameCount;
        lives++;
      }
    }
  }
  
  void draw() {
    if(isAlive()) {
      noStroke();
      fill(0, 128);
      ellipse(pos.x, pos.y+28, 60, 10);
      fill(255, 0, 0);
      
      noTint();
      image(sprite, pos.x, pos.y);
      //int damage = ENEMY_TOTAL_LIVES - lives;
      //tint(255, 0, 0, map(damage, 0, ENEMY_TOTAL_LIVES, 0, 255));
      

      image(sprite, pos.x, pos.y);
      
      if(lives < ENEMY_TOTAL_LIVES) {
        rectMode(CORNER);
        noStroke();
        fill(0);
        rect(pos.x-30, pos.y-30, 60, 5);
        fill(255, 0, 0);
        rect(pos.x-30, pos.y-30, map(lives, 0, ENEMY_TOTAL_LIVES, 0, 60), 5);
      }
      
    } else if(frameCount < lastShot + 300) {
      noTint();
      image(enemySpriteDead, pos.x, pos.y);
    }    
  }
  
  void takeHit(Bullet bullet) {
    lastShot = frameCount;
    lives -= bullet.damage;
    hits++;
  }
  
  public int compareTo(Enemy other) {
    return (int) this.pos.y - (int) other.pos.y;
  }
  
}
