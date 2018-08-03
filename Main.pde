//David Chen - super smash bros 

Animation player1, player2; 
Hitbox p1, p2; 
boolean restart; 
PImage bg;
PImage[] death = new PImage[3]; 
PImage[] playerTracker = new PImage[2]; 
PImage splashScreen; 
PImage endScreen; 

void setup() {
  size(1280, 720); 
  bg = loadImage("fd.jpg"); //Map - Final Destination, is loaded 
  player1 = new Animation(100, 500); //Players are loaded - 2 player game 
  player2 = new Animation(1000,500); 
  splashScreen = loadImage("slashScreen.jpg");
  background(bg); 

  playerTracker[0] = loadImage("ps1.png"); 
  playerTracker[1] = loadImage("ps2.png"); 
  death[0] = loadImage("death.png"); 
  death[1] = loadImage("death2.png"); 
  death[2] = loadImage("death3.png");
 endScreen = loadImage("endscreen.jpg");

} void draw() {
  
  if (millis() < 3000) { //Up to 3 seconds, splash screen is displayed 
   image(splashScreen,0,1); 
  } else {
    
  p1 = new Hitbox(player1.xpos, player1.ypos + 300, player1.getWidth(), player1.getHeight());
  p2 = new Hitbox(player2.xpos, player2.ypos + 300, player2.getWidth(), player2.getHeight()); 
  //Hitboxes are loaded 
  background(bg);
  
  player1.display(); 
  player1.move(); 
 
  textSize(32);
  stroke(188, 2, 2); 
  fill(188, 2, 2);
  text("P1", player1.xpos, height - player1.ypos); //This tracks which character is who

   
  player2.display();
  player2.move();
  
  textSize(32); 
  stroke(1, 40, 142); 
  fill(1, 40, 142);
  text("P2", player2.xpos, height - player2.ypos);
 
  
  pushMatrix(); //This is metaknight icon displayed next to player data
  scale(-1, 1); 
  image(player1.spriteSheet.get(49, 565, 29, 26), - 144, 558, player1.spriteSheet.get(49, 565, 29, 26).width * 3, player1.spriteSheet.get(49, 565, 29, 26).height *3); 
  popMatrix(); 
  image(player2.spriteSheet.get(49, 565, 29, 26), bg.width - 144, 558, player1.spriteSheet.get(49, 565, 29, 26).width * 3, player1.spriteSheet.get(49, 565, 29, 26).height *3);  
  
  stroke(255, 10, 10); //Displays player 1's percentage
  fill(255, 255, 255); 
  textSize(32);
  text(player1.percentage, 175, 625);
  
  
  textSize(32); //Displays player 2's percentage 
  stroke(255,10,10); 
  fill(255,255,255); 
  text(player2.percentage, bg.width - 200, 625); 
  
  
  
  textSize(32); //Displayers player 1's lives
  text(player1.lives, 175, 575);
  
  
  textSize(32); //Displays player 2's lives 
  text(player2.lives, bg.width - 200, 575); 
  
  if (!player1.win(player2) && !player2.win(player1)) { //If no one has won yet, the program will continue to detect collisions and death count. Otherwise, it will take you to the endScreen
    combat(); 
    deaths(); 
  } else {
    restart(keyPressed); 
  }
  
  }
  
} void keyPressed() { //Note: Max number of keys that can be pressed at once vary by keyboard
  
  char in = key; 
  in = Character.toLowerCase(in);
 
  if (player1.underAttack == true) { //If you are under attack, you freeze 
    player1.keys[0] = false;
    player1.keys[1] = false; 
    player1.keys[2] = false;
    player1.keys[3] = false; 
  } else {
  if (in == 'w') { //Move up
  player1.keys[0] = true; 
  } if (in == 'a') {//Move left
  player1.keys[1] = true;
 
  } if (in == 's') { //Block
  player1.keys[2] = true;
  player1.block = true;
 
  } if (in == 'd') { //Move right
  player1.keys[3] = true; 
 
  } if (in == 'c') { //Basic Attack
  player1.keys[4] = true; 
  } if (in == 'v') { //Special attack
  player1.keys[5] = true; 
  
  
  } 
  }
   
  if (player2.underAttack == true) {
    player2.keys[0] = false;
    player2.keys[1] = false; 
    player2.keys[2] = false;
    player2.keys[3] = false; 
  } else {
    if (key == CODED) {
    if (keyCode == UP) {
     player2.keys[0] = true; 
    } if (keyCode == LEFT) {
     player2.keys[1] = true; 
     player2.flip = false;
    }  if (keyCode == DOWN) {
     player2.keys[2] = true;
     player2.block = true;
    } if (keyCode == RIGHT) {
     player2.keys[3] = true; 
     player2.flip = true;
  }
  } if (in == 'j') {
  player2.keys[4] = true;
  } if (in == 'k') {
     player2.keys[5] = true;  
  } 
  }

} 
void keyReleased() {
  
  char in = key; 
  in = Character.toLowerCase(in);
  
    if (in == 'w') {
  player1.keys[0] = false; 
  } if (in == 'a') {
  player1.keys[1] = false; 
  }  if (in == 's') {
  player1.keys[2] = false; 
  player1.block = false;
  }  if (in == 'd') {
  player1.keys[3] = false; 
  } if (in == 'c') {
  player1.keys[4] = false; 
  } if (in == 'v') {
  player1.keys[5] = false;
  } 
  
  if (key == CODED) {
    if (keyCode == UP) {
     player2.keys[0] = false; 
    }  if (keyCode == LEFT) {
     player2.keys[1] = false; 
    }  if (keyCode == DOWN) {
     player2.keys[2] = false;
     player2.block = false;
    } if (keyCode == RIGHT) {
     player2.keys[3] = false; 
  }  
}
  if (in == 'j') {
  player2.keys[4] = false;
  } if (in == 'k') {
  player2.keys[5] = false; 
  } 

} void combat() {
  
 if (p1.collisionDetect(p2) == false || p2.collisionDetect(p1) == false) { //Detects if player 1's hitbox intersects with player 2's hitbox. Here, if it doesn't intersect, percentage should remain the same, and both characters should be able to freely move
    player1.percentage = player1.percentage;
    player2.percentage = player2.percentage; 
    player1.underAttack = false;
    player2.underAttack = false; 
  } else {
    if (player1.attackMode == true || player2.attackMode == true) { //If a character is under attack, it only happens if the character under attack is not blocking.
     
      if (player1.attackMode == false) {
        if (player1.block == false) {        
        player1.percentage += player2.damage;    
        player1.underAttack = true; 
        player1.freeze(player1.underAttack, player1.gravity(player1.percentage)); //In super smash bros, the more damage you receive, the easier it is for the opponent to "knock you out" ie, your gravity increases with damage
        } else {
         player1.percentage = player1.percentage; 
         player1.freeze(player1.block, player1.gravity(player1.percentage)); 
        }
      
    } else {
      
      if (player2.block == false) {        
        player2.percentage += player1.damage;         
        player2.underAttack = true; 
        player2.freeze(player2.underAttack, player2.gravity(player2.percentage)); 
      } else {
   
        player2.percentage = player2.percentage; 
        player2.freeze(player2.block, player2.gravity(player2.percentage)); 
      }
      
      
    } 
    } else {
      player1.percentage = player1.percentage;
      player2.percentage = player2.percentage; 
      player1.underAttack = false;
      player2.underAttack = false; 
    }  
   }
  
} void deaths() {
  if (player1.xpos < 0 || player1.xpos > 1280 || player1.ypos < 0 || player1.ypos > 720) { //Should you leave the map boundaries, you die and lose a life
    player1.lives--;    
    player1.death(); 
    //player1.Animation; 
  } else if (player2.xpos < 0 || player2.xpos > 1280 || player2.ypos < 0 || player2.ypos > 720) {
     player2.lives--; 
     player2.death();
  } 
} void restart(boolean pressed) { //Resets game after a match 
  if (pressed) {
    
    player1.percentage = 0; 
    player1.lives = 3;
    player1.xpos = 100;
    player2.percentage = 0;
    player2.lives = 3;
    player2.xpos = 1000;
    player2.flip = false; 
   
  }
}
