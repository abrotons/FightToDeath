class Bullet {
  PVector pos;
  PVector vel;
  boolean active;
  int damage;
  int exploding;
  
  Bullet(PVector target, int dam) {

    pos = new PVector(width/2, height/2);

    float velX = (target.x-pos.x);
    float velY = (target.y-pos.y);
    
    vel = new PVector(velX, velY).setMag(10.0);
    active = true;
    damage = dam;
    exploding = 0;
  }
  
  boolean isActive() {
    return active;
  }
  
  void nextStep() {
    pos.add(vel);
  }
  
  void draw() {
    if(active) {
      fill(map(damage, 1, 2, 0, 255), 0, 0);
      ellipse(pos.x, pos.y, 5*damage, 5*damage);
    } else if(exploding >= 0) {
      noStroke();
      fill(32, map(exploding, 0, 10, 0, 128));
      strokeWeight(2);
      ellipse(pos.x, pos.y, map(10-exploding, 0, 10, 5*damage, 3*5*damage), map(10-exploding, 0, 10, 5*damage, 3*5*damage));
      exploding--;
    }
  }
  
  void hit() {
    active = false;
    vel = new PVector(0,0);
    exploding = 10;
  }
  
  boolean outOfBoundaries() {
    int SAFE_ZONE = 10;
    return pos.x < -SAFE_ZONE || pos.x > width+SAFE_ZONE || pos.y < -SAFE_ZONE || pos.y > height+SAFE_ZONE;
  }
}
