import java.util.Collections;

class Game {
  
  ArrayList<Enemy> enemies;
  ArrayList<Bullet> bullets;
  Player player;
  
  Game() {
    restartGame();
  }

  void restartGame() {
  
    player = new Player();
    enemies = new ArrayList<Enemy>();
    bullets = new ArrayList<Bullet>();
    for (int i = 0; i < ENEMIES; i++) {
      Enemy enemy = new Enemy();
      enemies.add(enemy);
    }
  }
  
  int countAliveEnemies() {
    int count = 0;
    
    for(Enemy e : game.enemies) {
      if(e.lives > 0) 
        count++;
    }
    
    return count;
  }
  
  void singleShoot(PVector target) {
    player.shots++;
    shotSound.play();
    Bullet bullet = new Bullet(target, 2);
    bullets.add(bullet);
  }
  
  void multiShoot(PVector target) {
    player.shots+=5;
    shotSound.play();
    
  
    for(int ang = -2; ang <= 2; ang++) {
      PVector r1 = target.copy().sub(CENTER_POINT).rotate(ang*0.2).add(CENTER_POINT);
      bullets.add(new Bullet(r1, 1));
    }  
  
  }
  
  void removeGoneBullets() {
    ArrayList<Bullet> toClean = new ArrayList<Bullet>();
    for(Bullet b : bullets) {
      if(b.outOfBoundaries()) {
        toClean.add(b);
      }
    }
    bullets.removeAll(toClean);
  }
  
  void calculateHits(){
    for (Enemy enemy : enemies) {
      for(Bullet bullet : bullets) {
        if(bullet.isActive() && enemy.isAlive() && bullet.pos.dist(enemy.pos) < 40) {
          enemy.takeHit(bullet);
          bullet.hit();
          player.hits++;

          if(!enemy.isAlive()) {
            player.points += 25 * player.hits / player.shots;
            aaghSound.play();
          } else {
            ouchSound.play();
          }
        }
      }
      if(player.isAlive() && enemy.isAlive() && enemy.pos.dist(CENTER_POINT) < 150 && enemy.lastDamage + 100 < frameCount) {
        if(player.life > 5) {
          player.life -= 5;
          damageSound.play();
        }
        else {
          player.life = 0;
          gongSound.play();
        }
        enemy.lastDamage = frameCount;
      }
    }
  }
  
  boolean isRunning() {
    return player.isAlive() && countAliveEnemies() > 0;
  }
  
  void nextStep() {
    Collections.sort(enemies);
    removeGoneBullets();
    calculateHits();
    for(Bullet bullet : game.bullets) {
      if(bullet.isActive()) {
        bullet.nextStep();
      }
    }
    
    for (Enemy enemy : game.enemies) {
      if(enemy.isAlive()) {
        enemy.nextStep();
      }
    }
  }

}
