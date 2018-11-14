import processing.video.*;
import controlP5.*;
ControlP5 cp5;

Capture webcam;

color trackingColor;

float threshold =100;

void setup() {
  size(480, 270);
  cp5 = new ControlP5(this);
  DropdownList droplist = cp5.addDropdownList("mySuperList").setPosition(80, 80);
    for (int i=0; i<2; i++) {
    droplist.addItem("Red",i);
    droplist.addItem("Blue",i);
    droplist.addItem("Green",i);
  }
  webcam=new Capture(this, width, height, Capture.list()[6]);
  webcam.start();
  trackingColor=color(255, 0, 0);
  //printArray(Capture.list());
}

//void CaptureEvent(Capture webcam){
//webcam.read();
//}

 void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    println(theEvent.getGroup() + " => " + theEvent.getGroup().getValue());
  }
 }
 
void draw() {
  if (webcam.available()) {
    webcam.read();


    webcam.loadPixels();
  }
  float matchX=0;
  float matchY=0;
  int counter=0;
  
  float triggerX=200;
  float triggerY=200;
  for (int x=0; x<webcam.width; x++) {
    for (int y=0; y<webcam.height; y++) {
      int loc=x+y * webcam.width;
      color currentColor=webcam.pixels[loc];
      float r1= red(currentColor);
      float g1= green(currentColor);
      float b1= blue(currentColor);

      float r2=red(trackingColor);
      float g2=green(trackingColor);
      float b2=blue(trackingColor);

      float colorDiff=dist(r1, g1, b1, r2, g2, b2);
      if (colorDiff < threshold) {
        matchX = x;
        matchY = y;

        counter++;
      }
    }

  }

    //image(webcam, 0, 0);
  if (counter>0) {
    fill(trackingColor);
    ellipse(matchX, matchY, 40, 40);
    
  }
  fill(255,0,0);
  ellipse(triggerX,triggerY,40,40);
  
  if(dist(matchX,matchY,triggerX,triggerY)<20){
    background(random(255),random(255),random(255));
    textSize(20);
    text("You hit the goal!",width/2,height/2);
}
}
