class Animation {
  float xpos, ypos, speed = 5, floor; //speed is separate from gravity. Gravity is a force exterted involuntarily, while speed is movement induced voluntarily by the player
  float velocity = 6;
  float jumpheight = 5;
  float acceleration = 10;
  boolean[] keys;
  boolean underAttack; 
  boolean block; 
  boolean flip = false; 
  
  PImage spriteSheet = loadImage("MetaKnight.png"); //How animation works is throught sprites. In a single image composed of smaller images, they are cycled through each frame
  PImage[] idleAnimation = new PImage[5];
  PImage[] jumpAnimation = new PImage[8]; 
  PImage[] attackAnimation = new PImage[4]; 
  PImage[] specialAttack = new PImage[2]; 
  PImage tankingDamage;
  int damage;
  boolean attackMode = false; 
  int percentage; 
  int lives; 
  
  Animation(float xpos, float ypos) { //Constructor 
 
    keys = new boolean[6]; 
    underAttack = false; 
    velocity = 0;
    jumpheight = 5;
    acceleration = 10;
    floor = 500;
    block = false; 
    this.xpos = xpos;
    this.ypos = ypos;
    
    spriteSheet = loadImage("MetaKnight.png"); 
      
   for (int k = 0; k < 8; k++) { //For loops cycle through each image required and store them in an array for a particular function ie jumping 
     int y = 120 + (k * 35); 
     jumpAnimation[k] = spriteSheet.get(y, 205, 33, 46); 
     //image(spriteSheet, 100.0 + (k * 50), 95, spriteWidth, spriteHeight); 
   }
   for (int i = 0; i < 5; i++) {
     int x1 = 147 + 47 * i;
     idleAnimation[i] = spriteSheet.get(x1, 95, 47, 34);
   }
   for (int j = 0; j < 4; j++) {
     int x2 = 245 + (j * 75);
     attackAnimation[j] = spriteSheet.get(x2, 305, 38, 50); 
   }
   for (int l = 0; l < 2; l++) {
     int x3 = 260 + (l * 37);
     specialAttack[l] = spriteSheet.get(x3, 444, 38, 59); 
   }
   tankingDamage = spriteSheet.get(442,46,39,38);
  
   percentage = 0; 
   damage= 1;
   lives = 3; 
  
   
  }
     
   void display() { //They are displayed by images cycling through arrays with each frame. 
  
    if (keys[2]) { 
      
      if (flip == true) { //Checks if image is flipped (facing right). Images are set to flip each time you press the w/d or left/right key, stored in a boolean 
        pushMatrix();
        scale(-1,1); 
        image(tankingDamage, -xpos, height - ypos, tankingDamage.width * 3, tankingDamage.height * 3); 
        popMatrix();
      } else {
        image(tankingDamage, xpos, height - ypos, tankingDamage.width * 3, tankingDamage.height * 3);  
      }
      
    } else if (keys[0]) {
      if (flip == true) {
        pushMatrix();
        scale(-1,1); 
        image(jumpAnimation[(frameCount%64/8)], - xpos, height - ypos , jumpAnimation[(frameCount%64)/8].width * 3, jumpAnimation[frameCount%64/8].height * 3);
        popMatrix(); 
      } else {
        image(jumpAnimation[(frameCount%64/8)], xpos, height - ypos , jumpAnimation[(frameCount%64)/8].width * 3, jumpAnimation[frameCount%64/8].height * 3);  
      }
    attackMode = false; 
    
    } else if (keys[4]) { 
      if (flip == true) {
       pushMatrix();
       scale(-1,1);
       image(attackAnimation[(frameCount%16)/4], - xpos, height - ypos - 50, attackAnimation[(frameCount%16)/4].width * 3, attackAnimation[(frameCount%16)/4].height * 3);
       flip = true; 
       popMatrix(); 
     } else { 
        image(attackAnimation[(frameCount%16)/4], xpos, height - ypos - 50, attackAnimation[(frameCount%16)/4].width * 3, attackAnimation[(frameCount%16)/4].height * 3);  
        flip = false; 
      }
      attackMode = true; //Attack mode checks if the player is attacking during collisions 
   
    } else if (keys[5]) {
    
      image(specialAttack[(frameCount%4)/2], xpos, height - ypos , idleAnimation[(frameCount%4)/2].width * 3, idleAnimation[(frameCount%4)/2].height * 3);
      attackMode = true; 
      
    } 
    else {
      if (flip == true) {
        pushMatrix();
        scale(-1,1);
        image(idleAnimation[(frameCount%50)/10], - xpos, height - ypos , idleAnimation[(frameCount%50)/10].width * 3, idleAnimation[(frameCount%50)/10].height * 3);
        popMatrix(); 
      } else {
        image(idleAnimation[(frameCount%50)/10], xpos, height - ypos , idleAnimation[(frameCount%50)/10].width * 3, idleAnimation[(frameCount%50)/10].height * 3);
       //flip = false; 
         
      }
      attackMode = false; 
    }
   }
  
    void move() {
      
      if (keys[2]) {
         xpos = xpos;
         ypos = ypos; 
         keys[0] = false;
         keys[1] = false;
         keys[3] = false; 
         
      }
      
    //moving left and right
      if (keys[3]) {
        xpos = xpos += speed;
        flip = true; 
        if (ypos > floor) {
        xpos += speed/2;
      }
      }
      
      
      if (keys[1]) {  
        xpos -= speed;
        flip = false; 
        if (ypos > floor) {
        xpos -= speed/2;
        }
      }
     //jumping
      if (keys[0] && (ypos == floor)) {
        velocity = jumpheight;
      }
    ypos += velocity * 100 / frameRate;

   if (ypos > floor || xpos < 80 || xpos > 1200) {
      velocity -= acceleration / frameRate;
    }

    else {
      velocity = 0;
      ypos = floor ;
    }
    
    } float getWidth() { //Returns width of an image. 
     if (keys[0]) { 
    return jumpAnimation[(frameCount%64)/8].width;  
    }
    else if (keys[4])
    {
    return attackAnimation[(frameCount%16)/4].width;
    } else if (keys[5]) {
    return specialAttack[(frameCount%4)/2].width;
    } else {
    return idleAnimation[(frameCount%50)/10].width;
    }
  } float getHeight() { //Returns height of an image. 
    if (keys[0]) { 
    return jumpAnimation[(frameCount%64)/8].height;  
    }
    else if (keys[4])
    {
    return attackAnimation[(frameCount%16)/4].height;
    } else if (keys[5]) {
    return specialAttack[(frameCount%4)/2].height;
    } else {
    return idleAnimation[(frameCount%50)/10].height;
    }
  } void freeze(boolean underAttack, int gravity) { //when you are under attack, you not only freeze, but you also face knockback, which varies based off gravity. 
    if (underAttack == true) {
      
      if (flip == true) {
       xpos -= gravity;
       ypos -= gravity; 
      } else {
       xpos += gravity;
       ypos += gravity; 
      }
      
    }
    
  } int gravity(int percentage) { //This is where varied gravity is set. 
    return (percentage / 10) + 5;
    
  } void death() { //Conditions after one player has died
    
    image(death[0], 0, 1);
    image(death[1], 0, 1);
    image(death[2], 0, 1); 
    this.xpos = 600;
    this.ypos = 200;
    this.percentage = 0;
    
  } boolean win(Animation other) { //With lives, it is near impossible to reach a tie. The player that reaches 0 lives first loses. This method checks when that occurs. 
    
    if (this.lives == 0 || other.lives == 0) {
    image(endScreen,1,0);
    
    if (other.lives == 0) {
      text("The winner is Player 1", 50, 50);
    } else {
      text("The winner is Player 2", 50, 50); 
    }
    text("Press any key to play again", 50, 100);
    return true;   
      }
    else return false;
    
    
  } 
  
}
