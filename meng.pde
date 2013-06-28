float currentPosition = 0;
int MARGIN = 15;
int GREEN_BTN_WIDTH = 53;
int GREEN_BTN_HEIGHT = 179;


Maxim maxi;
AudioPlayer player;
AudioPlayer greenPlayer;
AudioPlayer redPlayer;
boolean buttonOn;
boolean greenEffectOn;
boolean redEffectOn;
float speedAdjust=1.0;

PImage [] vinils;
PImage btnOff;
PImage btnOn;
PImage btnGreen;
PImage btnRed;
PImage backgroundImage;
PImage [] speedLights;
PImage [] offLights;

void setup()
{
    maxi = new Maxim(this);
    player = maxi.loadFile("beat2.wav");
    greenPlayer = maxi.loadFile("piano-effect.wav");
    redPlayer = maxi.loadFile("splash.wav");
    vinils = loadImages("images/vinils/vinil",".png", 15);
    btnOff = loadImage("images/off.png");
    btnOn = loadImage("images/on.png");
    btnGreen = loadImage("images/effects/touch1.png");
    btnRed = loadImage("images/effects/touch2.png");
    backgroundImage = loadImage("images/mix-console.png");
    speedLights = loadImages("images/speedLights/sl",".png",11);
    offLights = loadImages("images/speedLights/off",".png",11);
    int tmpWidth = backgroundImage.width; 
    int tmpHeight = backgroundImage.height;
    size(tmpWidth, tmpHeight);
}

void draw()
{ 
    background(backgroundImage);
    drawSpeed();
    
    if(greenEffectOn){
      image(btnGreen, GREEN_BTN_WIDTH, GREEN_BTN_HEIGHT);
    }
    
   if(buttonOn){
     image(btnOn, btnOn.width, btnOn.width);
     
     image(btnRed, 135, 179);
   }else{
     image(btnOff, btnOn.width, btnOn.width);
   } 
    
    image(vinils[(int)currentPosition], width/2, MARGIN);
    if(buttonOn){
      //currentPosition += 1;
        player.speed(speedAdjust);
        //player2.speed((player2.getLengthMs()/player1.getLengthMs())*speedAdjust);
        currentPosition= currentPosition+1*speedAdjust;
    }
   if(currentPosition >= vinils.length)     
   {
         currentPosition = 0;
    }
}

void drawSpeed(){
  for(int i=0; i<offLights.length;i++){
      image(offLights[i], (MARGIN*2)*(i+1), height-(MARGIN*4));
  }
  if(buttonOn){
    int tmpSpeedPosition = calculeSpeed(speedAdjust, 1.98);
    for(int i=0; i<tmpSpeedPosition && i<speedLights.length;i++){
      image(speedLights[i], (MARGIN*2)*(i+1), height-(MARGIN*4));
    }
  } 
}

void mousePressed() {
  // check if the pressed
  int tmpMiddleSize = btnOn.width/2;
  if(dist(mouseX-tmpMiddleSize, mouseY-tmpMiddleSize, btnOn.width, btnOn.width) < tmpMiddleSize){
    buttonOn = !buttonOn;
    if (buttonOn){
        player.cue(0);
        player.play();
    }
    else {
      player.stop();
    }
  }
  startGreenEffect();
}

void startGreenEffect(){
   System.out.println("medida max ->"+GREEN_BTN_WIDTH/2);
   System.out.println("dist-> "+dist(mouseX-btnGreen.width, mouseY-btnGreen.height, btnGreen.width, btnGreen.height));
  if(dist(mouseX, mouseY, GREEN_BTN_WIDTH, GREEN_BTN_HEIGHT) < GREEN_BTN_WIDTH/2){
    greenEffectOn = !greenEffectOn;
    if (greenEffectOn){
        greenPlayer.cue(0);
        greenPlayer.play();
    }
    else {
      greenPlayer.stop();
    }
  }
}

void mouseDragged() {
 if (mouseX > width/2) {
   speedAdjust=map(mouseY,0,width,0,2);
   /*System.out.println("speedAdjust ->"+speedAdjust);
   System.out.println("volume %"+calculeSpeed(speedAdjust, 1.98));*/
 } 
}

public int calculeSpeed(float speed, float max){
  int tmpSpeed = (int)((speed*10)/max);
  return tmpSpeed;
}

