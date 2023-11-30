class Paddle {
  float x, y; // Position of the paddle
  float w, h; // Width and height of the paddle
  float speed; // Speed of the paddle

  Paddle(float x, float y, float w, float h, float speed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
  }

  void display() {
    fill(255);
   // rect(x, y, w, h);
   imageMode(CENTER);
    PImage img = loadImage("sprite_racket0.png");
   // can multiply image by decimals to make it smaller or whole numbers to make it bigger
    image(img, x+10, y+48, img.width*4, img.height*4);
  }

  void move(boolean up) {
    if (up) {
      y -= speed;
    } else {
      y += speed;
    }    
    // Make sure the paddle stays within the canvas
    y = constrain(y, 0, height - h);
  }
      void cpuMove(boolean up) {
         if (up) {
      y -= speed;
    }
    else {
      y += speed;
    } 
    y = constrain(y, 0, height - h);
      }
  
}
