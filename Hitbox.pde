class Hitbox {
 float x,y,w,h;
 
 Hitbox() {
  this.x = 0;
  this.y = 0;
  this.w = 0;
  this.h = 0;
 }
  
  Hitbox(float startX, float startY, float boxWidth, float boxHeight) { //Using getWidth and getHeight (from Animation class), this allows hitboxes to alter their size when invoked 
    x = startX;
    y = startY; 
    w = boxWidth;
    h = boxHeight; 
  
  } void display(float xpos, float ypos, float boxWidth, float boxHeight) {
   
    rect(xpos, ypos, boxWidth, boxHeight); 

    
  } boolean collisionDetect (Hitbox other) {//Checks if hitboxes collide 
  
    if ((this.x > other.x + other.w) || (this.x + this.w < other.x) || (this.y - this.h > other.y) || (this.y < other.y - other.h)) {

      return false; 
    } else {
        
      return true; 
    }  
  
} float getWidth() {
  return this.w; 
} float getHeight() {
  return this.h; 
}
}
