int x = 0, y = 0; //X and Y represent the coordinates on the board
float dx, dy; //dx and dy represent the speed of the potato at random intervals
float w = width*.5, h = height*.5; //this will be used to determine the potato dimensions
int started = 0; //This will be used to determine which form of the game we are in
int cash = 0; //This variable keeps track of the amount of cash the user has
int countdown = 0; //this variable counts down at random timeframes for the game 
int lose = 0; //this will be used to help determine when a winner loses
String tool = "Finger"; //This keeps track of the current tool the user is using 
int taps = 0; //This is the number of peels/taps that are required to win the round 
int money; //How much bonus money the user gets at the end of the round
int flag = 0; //The flag will be used to create a delay between rounds 
int time = 0; //This time is used for the timer 
int currentTool = 0; //This is used to determine the hardness during the game

//This PImage initializes each of our images
PImage farm, potato, dollarSign, timer, peel, shop, intro;
PImage instruc, instructions2, shopPotato, finger, spoon, scissors;
PImage sword, laser, dynamite, lock;

//Each of these booleans will be used in determining the current user tool
boolean tool2Bought = false, tool3Bought = false, tool4Bought = false, tool5Bought = false, tool6Bought = false;
boolean tool3Unlocked = false, tool4Unlocked = false, tool5Unlocked = false , tool6Unlocked = false;

//Setup will be called throughout the program as well as at the very beginning
void setup() {
  
  //We set our canvas
  size(650, 650);
  smooth();
  background(170);
  
  //We set our textsize to 20 and we randomize our velocities in the x and y direction
  //We also create the countdown variable to determine how much time is left
  textSize(20);
  dx = random(10) + 1;
  dy = random(10) + 1;
  time = millis();
  countdown = (int) (random(15) + 10);
  
  //This is where each of our images are loaded
  intro = loadImage("intro.PNG");
  instruc = loadImage("instructions.PNG");
  timer = loadImage("timer.png");
  shop = loadImage("shop.PNG");
  peel = loadImage("peel.PNG");
  instructions2 = loadImage("instructions2.PNG");
  shopPotato = loadImage("shop2.PNG");
  finger = loadImage("finger.PNG");
  spoon = loadImage("spoon.PNG");
  scissors = loadImage("scissors.PNG");
  sword = loadImage("sword.png");
  laser = loadImage("laser.png");
  dynamite = loadImage("dynamite.PNG");
  lock = loadImage("lock.PNG");
  farm=loadImage("farm.jpg");
  potato=loadImage("potato.png");
  dollarSign = loadImage("dollar-sign.png");
  
  
  //We resize each of our images based on what we need them to look like
  intro.resize((int) (width*1.3), (int) (height*.95));
  instruc.resize((int) (width * 1.75), (int) (height*1.2));
  shop.resize((int) (width*.7), (int) (height*.5));
  peel.resize((int) (width ), (int) (height*.8));
  timer.resize((int) (width * .05), (int) (height *.05));
  instructions2.resize((int) (width*.5), (int) (height*.4));
  shopPotato.resize((int) (width*.4), (int) (height*.25));
  dollarSign.resize((int) (width*.05), (int) (height*.05));
  potato.resize((int)(width*.5), (int)(height*.5));
  farm.resize(width, height);
  
  //We randomize the number of taps that the user requires for a round
  taps = ((int) (random(30) + 20 * currentTool * 3)) + 1 ;  
  money = taps;
  lose = 0;

  //This is used to set the stage for the intro screen
  intro();
}

void draw(){
  
  
  if(flag == 1){
     delay(2000);  
     setup();
     flag = 0;
  }
  
  if(started == 1){
    mainGame();
  }else if(started == 0){
      setup();
      x = 0;
      y = 0;
  }else if(started == 2){
    shop();
  } else if(started == 3){
    instructions();
  }
}

//Intro screen
void intro(){
  image(farm, 0, 0);
  image(intro, -105, -195);
  image(instruc, -50, 390);
  image(peel, 0, 125);
  image(shop, 250, 375);

}

void mainGame(){

  image(farm, 0, 0);
    fill(0);
    rect(0,0, (int) (height-1), (int) (width*.05));
    
    
    image(timer, 570, 0);
    fill(0,255,0);
    if (countdown <= 5){
      fill(255, 0, 0);
    }
    text(countdown, 600, 28);
    
    
    image(dollarSign, 0, 0);    
    
    fill(0,255,0);
    String peelsMessage = "Number of Peels: " + taps;
    text(peelsMessage, 180, 28);
    
    
    fill(0,255,0);
    textSize(30);
    text(cash, 30, 28);
    stroke(0);

    fill(255);
    text("Q - Quit", 5, 640);
    
    textSize(15);
    fill(255,255,255);
    text("Current \n Tool:", 585, 550); 
    textSize(30);
     if (tool.equals("Finger")){
       finger.resize(60,60);
       image(finger, 580, 580);
     }   
     if (tool.equals("Spoon")){
       spoon.resize(60,60);
       image(spoon, 580, 580);
     }   
     if (tool.equals("Scissors")){
       scissors.resize(60,60);
       image(scissors, 580, 580);
     }   
     if (tool.equals("Sword")){
       sword.resize(60,60);
       image(sword, 580, 580);
     }   
     if (tool.equals("Laser")){
       laser.resize(60,60);
       image(laser, 580, 580);
     }   
     if (tool.equals("Dynamite")){
       dynamite.resize(60,60);
       image(dynamite, 580, 580);
     }   
    
    
    x+=dx;
    y+=dy;
    image(potato, x, y);
    
    if(x <= 0 || x >= width - w - 265){
      dx = -dx;
    }
    if(y >= height - h - 265){
       dy = -dy;
    }
    if(y <= width * .05){
      dy = -dy;
      y = (int)(width * .05);
    }
    
    if(millis() - time >= 1000){
      countdown--;
      time = millis();
      if(countdown == 0){
        taps = 0;
        lose = 1;
      }
    }
    
    
    if(taps == 0){
      
      image(farm,0,0);
      fill(0);
      textSize(20);

      String newPotato = "A new Potato is ready to be peeled!";
      String moreMoney;
      if(lose == 0){
        moreMoney = "You have earned " + money + " dollars for peeling this potato!";
        cash += money;
        text(moreMoney, 80, 150);
      }
      else{
         moreMoney = "Better luck on the next potato!"; 
         text(moreMoney, 168, 150);
      }
      text(newPotato, 155, 200);
      flag = 1;
    }

}


void instructions(){
     
    image(instructions2, 160, 15);
  
    fill(275,275,275);
    rect(55, 320, 550,170);
    
    fill(0);
    textSize(20);
    text("Click on the moving potato until you run out of peels!", 70, 350);
    text("But don't run out of time!", 200, 375);
    text("You earn money for each peel and bonus money for", 70, 400);
    text("each completely peeled potato.", 173, 425);
    text("Press Q at any time to return to the main menu.", 100, 475);

}


void shop(){

    finger.resize(120,120);
    spoon.resize(120, 120);
    scissors.resize(120, 120);
    sword.resize(120, 120);
    laser.resize(120, 120);
    dynamite.resize(120, 120);
    lock.resize(120, 120);
    
    
    image(farm,0,0);
    image(shopPotato, 220, 25);
   
    fill(0);
    text("Buy all of your tools below", 200, 200);
    
    text("Cash: $" + cash, 170, 225);
    text("Current tool: " + tool, 320, 225);
   
     fill(255);
    text("Q - Quit", 5, 640);
    
    textSize(17);
    fill(255, 255, 255);
    
    rect(55, 250, 120, 120); 
    image(finger, 55, 250);
    text("Unlocked", 75, 390);
    
    rect(255, 250, 120, 120);
    image(spoon, 255, 250);
    if(!tool2Bought){
      text("Buy: $150", 270, 390);
    } else {
      text("Unlocked", 270, 390);
    }
    
    rect(455, 250, 120, 120);
    if(!tool3Unlocked){
      image(lock, 455, 250);
    } else {
      image(scissors, 455, 250);
    }  
    if(!tool3Unlocked){
      text("Locked", 480, 390);
    } else if (tool3Unlocked && !tool3Bought){
      text("Buy: $700", 475, 390);
    } else {
      text("Unlocked", 475, 390);
    }
    
    rect(55, 450, 120, 120);
    if(!tool4Unlocked){
      image(lock, 55, 450);
    } else {
      image(sword, 55, 450);
    }    
    if(!tool4Unlocked){
      text("Locked", 80, 590);
    } else if (tool4Unlocked && !tool4Bought){
      text("Buy: $3000", 75, 590);
    } else {
      text("Unlocked", 75, 590);
    }
    
    rect(255, 450, 120, 120);
    if(!tool5Unlocked){
      image(lock, 255, 450);
    } else {
      image(laser, 255, 450);
    }   
    if(!tool5Unlocked){
      text("Locked", 280, 590);
    } else if (tool5Unlocked && !tool5Bought){
      text("Buy: $10000", 275, 590);
    } else {
      text("Unlocked", 275, 590);
    }
    
    rect(455, 450, 120, 120);
    if(!tool6Unlocked){
      image(lock, 455, 450);
    } else {
      image(dynamite, 455, 450);
    }  
    if(!tool6Unlocked){
      text("Locked", 480, 590);
    } else if (tool6Unlocked && !tool6Bought) {
      text("Buy: $30000", 475, 590);
    } else {
      text("Unlocked", 475, 590);
    }
    
    textSize(20);
}


void keyPressed() {
  if(key == 'P' || key == 'p'){
    started = 1;
  }
  if((key == 'Q' || key == 'q') && started != 0){
    image(farm, 0, 0);
    
    textSize(30);
    text("Returning to the Main Menu...", (int) (width *.5 - 200), (int) (height *.5 + 50 ));
    started = 0;
  }
  if(started == 0 && (key == 'S' || key == 's')){
    started = 2;
    image(farm, 0, 0);
  }
  if(started == 0 && (key == 'I' || key == 'i')){
    started = 3;
    image(farm, 0, 0);
  }
}





void mousePressed(){
    if(mouseX >= x && mouseX <= x + 240 && mouseY >= y && mouseY <= y + 280){      
      int original = taps;
      if (taps > 0 && tool.equals("Finger")){
        taps--;
      } else if (taps > 0 && tool.equals("Spoon")){
        taps -= 2;
      } else if (taps > 0 && tool.equals("Scissors")){
        taps -= 4;
      } else if (taps > 0 && tool.equals("Sword")){
        taps -= 8;
      } else if (taps > 0 && tool.equals("Laser")){
        taps -=16;
      } else if (taps > 0 && tool.equals("Dynamite")){
        taps -= 32;
      }
      if(taps < 0){
          taps = 0;
       }
       original -= taps;
       cash += original;
    }
    
    if(started == 2 && !tool2Bought && cash >= 150 && mouseX >= 255 && mouseX <= 375 && mouseY >= 250 && mouseY <= 370){
      tool = "Spoon";
      cash -= 150;
      tool2Bought = true;
      tool3Unlocked = true;
      currentTool = 2;
    }
    
    if(started == 2 && !tool3Bought && tool3Unlocked && cash >= 700 && mouseX >= 455 && mouseX <= 575 && mouseY >= 250 && mouseY <= 370){
      tool = "Scissors";
      cash -= 700;
      tool3Bought = true;
      tool4Unlocked = true;
      currentTool *= 2;
    }
    
    if(started == 2 && !tool4Bought && tool4Unlocked && cash >=  3000  && mouseX >= 55  && mouseX <= 175 && mouseY >= 450 && mouseY <= 570){
      tool = "Sword";
      cash -= 3000;
      tool4Bought = true;
      tool5Unlocked = true;
      currentTool *= 2;

    }
    
    if(started == 2 && !tool5Bought && tool5Unlocked && cash >=  10000 && mouseX >= 255  && mouseX <= 375 && mouseY >= 450 && mouseY <= 570){
      tool = "Laser";
      cash -= 10000;
      tool5Bought = true;
      tool6Unlocked = true;
      currentTool *= 2;
    }
    
    if(started == 2 && !tool6Bought && tool6Unlocked && cash >=  30000  && mouseX >= 455 && mouseX <= 575 && mouseY >= 450 && mouseY <= 570){
      tool = "Dynamite";
      cash -= 30000;
      tool6Bought = true;
      currentTool *= 2;
    }
}