int ENEMIES = 10;

PVector CENTER_POINT;

Game game;

String enteredName = "";

void setup() {
  size(800, 600);
  //fullScreen(P2D, SPAN);
  noSmooth();
  readScores();
  

  noCursor();
  imageMode(CENTER);
  CENTER_POINT = new PVector(width/2, height/2);
  loadMedia();
  game = new Game();
  
}

void draw() {
  
  game.nextStep();
  
  background(0, 196, 0);
   
  if(game.isRunning()) {
    game.player.draw();
    for(Bullet bullet : game.bullets) {
      bullet.draw();
    }
    
    for (Enemy enemy : game.enemies) {
      enemy.draw();
    }
    
    fill(64);
    textSize(16);
    textAlign(LEFT, CENTER);
    text("Points: " + game.player.points, 10, 70);
    
    stroke(0);
    fill(255, 0, 0, 64);
    rectMode(CORNER);
    rect(30, 10, 442, 22);
    noStroke();
    fill(255, 0, 0);
    rect(30, 10, map(game.player.life, 0, 100, 0, 442), 22);
    imageMode(CORNER);
    noTint();
    image(lifeBarSprite, 2, 2);
    imageMode(CENTER);
  } else if(game.player.isAlive()) {
    background(0, 255, 0);
    for (Enemy enemy : game.enemies) {
      image(enemySpriteDead, enemy.pos.x, enemy.pos.y);
    }
    noStroke();
    fill(0, 192);
    rect(0, 0, width, height);
    fill(255, 255, 128);
    stroke(128, 128, 0);
    ellipse(width/2, height/2, 200, 200);
    fill(128, 128, 0);
    textSize(32);
    textAlign(CENTER, CENTER);
    String message = getMessage(100.0f * game.player.points / (game.enemies.size()*25.0) );
    text(message + "\n" + game.player.points + " points", width/2, height/2);
    text("Player: " + enteredName, width/2, height/2+120);
        
    colorMode(HSB, 360, 100, 100);
    noFill();
    stroke(map(game.player.points, 0, game.enemies.size()*25, 0, 120), 100, 100);
    strokeWeight(10);
    arc(width/2, height/2, 200, 200, radians(-90) , map(game.player.points, 0, game.enemies.size()*25, radians(-90), radians(270)));
    colorMode(RGB, 255, 255, 255);
  } else { //Player is dead
    background(0, 255, 0);
    for (Enemy enemy : game.enemies) {
      enemy.draw();
    }
    noStroke();
    fill(0, 128);
    rect(0, 0, width, height);
    fill(255, 128, 128);
    stroke(128, 128, 0);
    ellipse(width/2, height/2, 200, 200);
    fill(128, 0, 0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("You loose!\n" + game.player.points + " points", width/2, height/2);
    
  } 
  
  drawCross();
  
 
}

void stop() {
  shotSound.stop();
  ouchSound.stop();
  aaghSound.stop();
}

void mousePressed() {
  if(game.player.isAlive() && game.countAliveEnemies() > 0) {
    PVector target = new PVector(mouseX, mouseY);
    if(keyPressed && key == '1') {
      game.multiShoot(target);
    } else {
      game.singleShoot(target);
    }
  }
}

void keyPressed() {
  if(game.isRunning()) {
    switch(key) {
      case 'a' : game.player.moveLeft(); break;
      case 'w' : game.player.moveUp(); break;
      case 's' : game.player.moveDown(); break;
      case 'd' : game.player.moveRight(); break;
    }
  }
  if(game.countAliveEnemies() == 0) {
    if (keyCode == BACKSPACE) {
      if (enteredName.length() > 0) {
        clickSound.play();
        enteredName = enteredName.substring(0, enteredName.length()-1);
      }
    } else if (keyCode == DELETE) {
      enteredName = "";
    } else if (keyCode == ENTER || keyCode == RETURN) {
      if(!enteredName.isEmpty()) {
        saveScores();
        game.restartGame();
      }
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
      clickSound.play();
      enteredName = enteredName + key;
    }  
  }
}

 //<>// //<>//



void drawCross() {
  stroke(0);
  strokeWeight(1);
  line(mouseX - 10, mouseY, mouseX + 10, mouseY);
  line(mouseX, mouseY - 10, mouseX, mouseY + 10); 
}



String getMessage(float percent) {
  String message = "Aim better :(";
  if(percent >= 99.5f) {
    message = "Excellent!!";
  } else if(percent >= 85.0f) {
    message = "Great job!";
  } else if(percent >= 50.0f) {
    message = "Not bad.";
  } else if(percent >= 25.0f) {
    message = "Ummh...";
  }
  
  return message;
}
