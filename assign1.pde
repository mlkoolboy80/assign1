SlotMachine machine;
boolean rolling = false;
// button information
boolean button = false;
int x = 640/2;
int y = 440;
int w = 150;
int h = 50;

// declare variables
// --------------------------------------------
// put your code inside here
int totalScore = 500;
// one time decrease 50 score
int decreaseStep = 50;
// game end flag
boolean gameEnd = false;

// --------------------------------------------

void setup() {
  size(640,480);
  textFont(createFont("fonts/Square_One.ttf", 20));
  machine = new SlotMachine();
}

void draw() {
  background(245,229,124);
  fill(64,162,171);
  rect(320,248,396,154,25);
  fill(253,253,253);
  rect(220,247,97,114,2);
  rect(320,247,97,114,2);
  rect(420,247,97,114,2);
  // draw button
  fill(64,162,171);
  noStroke();
  rectMode(CENTER);
  rect(x,y,w,h,105);
  // show title
  fill(64,64,63);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Slot Machine",x,49);
  textSize(20);
  text("Score"+" "+":"+" "+totalScore,x, 89);
  
  // event handler
  
  if(gameEnd){
    machine.stop();
    fill(253,253,253);
    textSize(19);
    text("End",x,y);
  } else {
    if (button) {
      if (!rolling){
        rolling = true;
        // start rolling
        // -------------------------------------------------
        // put your code inside here
        
        
          
        totalScore = totalScore - decreaseStep;
        // -------------------------------------------------
      }
      machine.roll();
      textSize(19);
      text("Stop",x,y);
    
    } else {
      if (rolling){
        rolling = false;
        // stop rolling
        // -------------------------------------------------
        // put your code inside here
        
        // decide seven seven seven
        boolean sevenFlag = machine.probability(0.1);
        int fruitNumbers = machine.fruitNumbers.length;
        
        // random decide three fruits
        for(int i = 0; i < machine.m; i++){
          for(int j = 0; j < machine.n; j++){
            if(sevenFlag){
              machine.setSlotFruit(i, 0); // 0: seven
            } else {
              int rnd = int(random(fruitNumbers));
              machine.setSlotFruit(i, rnd); // rnd: fruits
            }
          }
        }
        
        // calculate scores
        int getScore = 0;
        for(int i = 0; i < fruitNumbers; i++){
          int num = max(machine.getFruitCount(i)-1, 0);
          getScore = getScore + machine.getSlotScore(i) * num;
        }
        
        totalScore = totalScore + getScore;
        
        if(totalScore <= 0){
           gameEnd = true;
        }
        // -------------------------------------------------
      }
      machine.stop();
      fill(253,253,253);
      textSize(19);
      text("Roll",x,y);
    }
  }

}

// When the mouse is pressed, the state of the button is toggled.   
void mousePressed() {
  if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
    button = !button;
  }  
}


