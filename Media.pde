import processing.sound.SoundFile;

PImage enemySpriteLeft, 
       enemySpriteRight, 
       enemySpriteDead, 
       devilFace, 
       devilEye, 
       lifeBarSprite;
       
SoundFile shotSound, 
       ouchSound, 
       aaghSound, 
       damageSound,
       gongSound, 
       clickSound;

void loadMedia() {
  enemySpriteLeft = loadImage("enemy_left.png");
  enemySpriteRight = loadImage("enemy_right.png");
  enemySpriteDead = loadImage("tombstone.png");
  lifeBarSprite = loadImage("life_bar.png");
  devilFace = loadImage("devil_face.png");
  devilEye = loadImage("devil_eye.png");
  
  shotSound = new SoundFile(this, "shot.mp3");
  ouchSound = new SoundFile(this, "ouch.mp3");
  aaghSound = new SoundFile(this, "aagh.mp3");
  damageSound = new SoundFile(this, "damage.mp3");
  gongSound = new SoundFile(this, "gong.mp3");
  clickSound = new SoundFile(this, "click.mp3");
}
