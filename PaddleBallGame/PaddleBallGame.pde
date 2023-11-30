import processing.sound.*;

SoundFile paddleSound;
SoundFile backgroundMusic;

PImage tenniscourtImg;
PImage startScreenImg;
PImage winScreenImg;
PImage loseScreenImg;

// Main game class
Paddle player;
Paddle cpu;
Ball ball;

//SoundFile theme;

int playerScore = 0;
int cpuScore = 0;
int scoreLimit = 5;
int gameState = 0;

void setup() {
  size(800, 600);
  player = new Paddle(width - 20, height / 2 - 40, 10, 80, 5);
  cpu = new Paddle(10, height / 2 - 40, 10, 80, 3);
  ball = new Ball(width / 2, height / 2, 20, 5, 5);
  
   // initialize my vars
  paddleSound = new SoundFile(this, "paddleHit.mp3");
  backgroundMusic = new SoundFile(this, "theme.mp3");
  
   tenniscourtImg = loadImage("tennisCourt.png");
  startScreenImg = loadImage("Raquetballblitz.jpg");
  winScreenImg = loadImage("winscreen.jpg");
  loseScreenImg = loadImage("losescreen.jpg");
  startScreenImg.resize(startScreenImg.width*4, startScreenImg.height*2);
  imageMode(CENTER);
  
}


void draw() {
  
  
  switch (gameState) {
    case 0:
      drawStartScreen();

      break;
    case 1:
    backgroundMusic.stop();
      playGame();
      break;
    case 2:
      drawWinScreen("Player 1 Wins!");
      restartGame();
      break;
    case 3:
      drawWinScreen("CPU Wins!");
      restartGame();
      break;
  }
}

void keyPressed(){
  if (key == 'r' || key == 'R') {
    restartGame();
  }
  if (key == ' '){
    gameState += 1;
    
    if (gameState > 2){
     gameState = 0; 
    }
   }
   if (key == 'b'){
    gameState -= 1; 
    if (gameState < 0){
     gameState = 2; 
    }
   }
}  



void playGame() {
  background(0);
       image(tenniscourtImg, width/2, height/2);


  
  // Display and move the player's paddle
  player.display();
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      player.move(true);
    } else if (key == 's' || key == 'S') {
      player.move(false);
    }
  }

  // Display and move the CPU's paddle (follow the ball)
  cpu.display();
  if (ball.y > cpu.y + cpu.h / 2) {
    cpu.move(false); // Move down
  } else {
    cpu.move(true); // Move up
  }

  // Display and move the ball
  ball.display();
  ball.move();

  // Check for collisions with the player's paddle
  if (ball.x + ball.diameter / 2 > player.x && ball.y > player.y && ball.y < player.y + player.h) {
    ball.xSpeed = -ball.xSpeed;
    paddleSound.play();
  }

  // Check for collisions with the CPU's paddle
  if (ball.x - ball.diameter / 2 < cpu.x + cpu.w && ball.y > cpu.y && ball.y < cpu.y + cpu.h) {
    ball.xSpeed = -ball.xSpeed;
    paddleSound.play();
  }


  // Check for scoring
  if (ball.x - ball.diameter / 2 < 0) {
    playerScore++;
    resetGame();
  } else if (ball.x + ball.diameter / 2 > width) {
    cpuScore++;
    resetGame();
  }

  // Display scores
  textSize(32);
  fill(255);
  text("Player: " + playerScore, width / 2 - 100, 50);
  text("CPU: " + cpuScore, width / 2 + 20, 50);

 

  // Check for game over
  if (playerScore >= scoreLimit) {
    gameState = 2;
  }
  
 if (cpuScore >= scoreLimit) {
    gameState = 3;
  }
}



void drawStartScreen() {
        if(!backgroundMusic.isPlaying()){
       backgroundMusic.play(); 
      }
  
   background(255,0,0);
    image(startScreenImg, width/2, height/2);
   
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Press 'SPACE' to Start", width / 2, height / 2);
}
void drawWinScreen(String winnerText) {
  // background(0);
  //fill(255);
  //textSize(32);
  //textAlign(CENTER, CENTER);
  //text(winnerText, width / 2, height / 2);
  if (gameState == 3){
    image(loseScreenImg,width/2,height/2,width,height);
  } else {
    image(winScreenImg,width/2,height/2,width,height);
  }
}

void resetGame() {
  // Reset ball position
  ball.x = width / 2;
  ball.y = height / 2;

  // Reset paddle positions
  player.y = height / 2 - 40;
  cpu.y = height / 2 - 40;
  
  // Pause briefly before restarting
  delay(1000);
}

void restartGame() {
  player = new Paddle(width - 20, height / 2 - 40, 10, 80, 5);
  cpu = new Paddle(10, height / 2 - 40, 10, 80, 3);
  ball = new Ball(width / 2, height / 2, 20, 5, 5);
  playerScore = 0;
  cpuScore = 0;
}
