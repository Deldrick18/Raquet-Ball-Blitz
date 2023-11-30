class Ball {
  float x, y; // Position of the ball
  float diameter; // Diameter of the ball
  float xSpeed, ySpeed; // Speed of the ball

  Ball(float x, float y, float diameter, float xSpeed, float ySpeed) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }

  void display() {
    fill(255);
    ellipse(x, y, diameter, diameter);
  }

  void move() {
    x += xSpeed;
    y += ySpeed;

    // Bounce off the walls
    if (x <= 0 || x >= width) {
      xSpeed = -xSpeed;
    }

    // Bounce off the top and bottom
    if (y <= 0 || y >= height) {
      ySpeed = -ySpeed;
    }
  }
}
