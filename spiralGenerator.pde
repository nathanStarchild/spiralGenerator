int rep, segments, fTime, fibPow, revs, rfacInit, restart, myBrush;
float fib = 1.61803398875;
float symmetry, tf, scl, scaleInc, rfacDt, rainbowRate, rotRate, repShift;
float rfac;
color c1, c2;
boolean scalingOn, rotateOn, clockwiseOn, counterClockwiseOn, bgOn; 
boolean parameterDisplayOn;
float xmag, ymag = 0;
float newXmag, newYmag = 0; 
float dxmag, dymag = 0;
float dnewXmag, dnewYmag = 0; 
PFont mono;
PFont schild;
boolean drawControls;
color f1, s1, f2, s2;
int satf1, sats1, satf2, sats2, brif1, bris1, brif2, bris2;
int alphaf1, alphas1, alphaf2, alphas2, cShifts1, cShifts2, cShiftf2;

void setup() {
  //size(1700, 1100);
  fullScreen(P3D, SPAN);
  //fullScreen(P3D, 2);
  background(0, 0, 0);
  noCursor();
  revs = 3;
  symmetry = 66.557;
  segments = 310;
  fibPow = -1;
  rep = 5;
  scl = 1;
  rainbowRate = 2.789;
  tf = 23.03;
  repShift = 1.02;
  scalingOn = false;
  rotateOn = true;
  scaleInc = 0.001;
  rfacDt = 0.0437;
  rfacInit =20;
  rotRate = 0.006;
  restart = 0;
  clockwiseOn = false;
  counterClockwiseOn = true;
  bgOn = false;
  parameterDisplayOn = false;
  myBrush = 1;
  drawControls = false;
  
  satf1 = 252;
  sats1 = 252;
  satf2 = 252;
  sats2 = 252;
  brif1 = 252;
  bris1 = 252;
  brif2 = 252;
  bris2 = 252;
  alphaf1 = 252;
  alphas1 = 252;
  alphaf2 = 252;
  alphas2 = 252;
  cShifts1 = 256/2;
  cShifts2 = 256/2;
  cShiftf2 = 0;

  colorMode(HSB, 255);
  rectMode(RADIUS);
  
  String[] fontList = PFont.list();
  for (int i=0; i<fontList.length; i++){
    println(fontList[i]);
  }
  mono = createFont("Ubuntu Mono Bold", 14);
  schild = createFont("arial", 14);
}

void draw() {
  fTime = (millis() - restart)*60/1000;
  rfac = rfacInit + pow(fTime*rfacDt, 2);
  if (bgOn) {
    background(170, 0, 0);
  }
  if (scalingOn) {
    scl = scl + scaleInc;
    scale(scl);
  }
  pushMatrix();
  translate(width/2.0, height/2.0, 0);  
  translate(dxmag, dymag, 0);
  if (mousePressed) {    
    rotateX(-ymag); 
    rotateZ(-xmag);
    dragMatrix();
  } else {
    mouseCamera(1);
  }
  if (rotateOn) {
    rotateZ(-fTime*rotRate*PI/360);
  }
  for (int n=0; n<rep; n++) {
    rotateZ(2*PI/rep);
    int hue = int((n*repShift+(fTime / rainbowRate)) % 255);
    for (int t=0; t<segments*revs; t++) {
      f1 = color((hue+(t*tf))%255, satf1, brif1, alphaf1);
      s1 = color((hue+(t*tf)+cShifts1)%255, sats1, bris1, alphas1);
      f2 = color((hue+(t*tf)+cShiftf2)%255, satf2, brif2, alphaf2);
      s2 = color((hue+(t*tf)+cShifts2)%255, sats2, bris2, alphas2);
      float theta = t * 2 * PI / (segments);
      float theta2 = 2 * PI - theta;
      float r =  rfac * pow(fib, (-1 * symmetry * t/float(segments)));
      float s = r/pow(fib, fibPow);
      if (r<3000 && r > 0.01){
        pushMatrix();
        translate(0, 0, r);
        fill(f1);
        stroke(s1);
        if (alphaf1 == 0) {
          noFill();
        } else if (alphas1 == 0) {
          noStroke();
        }
        //noFill();
        //noStroke();
        if(clockwiseOn){
          brush(r*sin(theta), r*cos(theta), s);
        }
        //ellipse(r*sin(theta), r*cos(theta), s, s);
        //rect(r*sin(theta), r*cos(theta), s, s);
        //fill(c2);
        //stroke(c1);
        if(counterClockwiseOn){
          fill(f2);
          stroke(s2);
          if (alphaf2 == 0) {
            noFill();
          } else if (alphas2 == 0) {
            noStroke();
          }
          brush(r*sin(theta2), r*cos(theta2), s);
        }
        //ellipse(r*sin(theta2), r*cos(theta2), s, s);
        //rect(r*sin(theta2), r*cos(theta2), s, s);
        popMatrix();
      }
    }
  }
  popMatrix();
  if (parameterDisplayOn) {
    displayParameters();
  }
}

void brush(float x, float y, float s) {
  if (myBrush == 0) { 
    rect(x, y, s, s);
  } else if (myBrush == 1) {
    ellipse(x, y, s, s);
  } else if (myBrush == 2) {
    textSize(s);
    textFont(mono);
    text("@ starchildart", x, y);
  }
}

void keyPressed() {
  if (!drawControls){
    switch(key) {
      case('"'):
        save("savedImage"+int(random(10000))+".tif");
      break;
      case('q'):
      revs = revs + 1;
      break;
      case('a'):
      revs = max(1, revs - 1);
      break;
      case('w'):
      symmetry = symmetry * 1.2;
      break;
      case('s'):
      symmetry = symmetry / 1.2;
      break;
      case('e'):
      segments = segments + 1;
      break;
      case('E'):
        segments = segments + int(symmetry);
        break;
      case('d'):
      segments = segments - 1;
      break;
      case('D'):
        segments = max(1, segments - int(symmetry));
        break;
      case('r'):
        fibPow = fibPow + 1;
      break;
      case('f'):
        fibPow = fibPow - 1;
      break;
      case('t'):
        rep = rep + 1;
      break;
      case('g'):
        rep = max(1, rep - 1);
      break;
      case('y'):
        rainbowRate *= 1.1;
      break;
      case('h'):
        rainbowRate *= 0.9;
      break;
      case('u'):
        tf = tf * 1.1;
      break;
      case('j'):
        tf = tf * 0.9;
      break;
      case('i'):
        repShift = repShift * 1.1;
      break;
      case('k'):
        repShift = repShift * 0.9;
      break;
      case('z'):
        parameterDisplayOn = !parameterDisplayOn;
      break;
      case('Z'):
        restart = millis();
      break;
      case('x'):
        clockwiseOn = !clockwiseOn;
      break;
      case('X'):
        counterClockwiseOn = !counterClockwiseOn;
      break;
      case('C'):
        dxmag = 0;
        dymag = 0;
      break;
      case('V'):
        drawControls = true;
      break;
      case('b'):
        bgOn = !bgOn;
      break;
      case('m'):
        rotateOn = !rotateOn;
      break;
      case('.'):
        rotRate *= 1.1;
      break;
      case(','):
        rotRate *= 0.9;
      break;
      case('o'):
        rfacInit *=1.1;
      break;
      case('l'):
        rfacInit *= 0.9;
      break;
      case('p'):
        rfacDt *=1.1;
      break;
      case(';'):
        rfacDt *= 0.9;
      break;   
      case('B'):
        myBrush = (myBrush + 1) % 3;
      break;
         
    }
  } else {
    switch(key) {
      case('q'):
        alphaf1 = max(alphaf1 - 1, 0);
      break;
      case('Q'):
        alphaf1 = max(alphaf1 - 10, 0);
      break;
      case('w'):
        alphaf1 = min(alphaf1 + 1, 255);
      break;
      case('W'):
        alphaf1 = min(alphaf1 + 10, 255);
      break;
      case('e'):
        alphas1 = max(alphas1 - 1, 0);
      break;
      case('E'):
        alphas1 = max(alphas1 - 10, 0);
      break;
      case('r'):
        alphas1 = min(alphas1 + 1, 255);
      break;
      case('R'):
        alphas1 = min(alphas1 + 10, 255);
      break;
      case('t'):
        alphaf2 = max(alphaf2 - 1, 0);
      break;
      case('T'):
        alphaf2 = max(alphaf2 - 10, 0);
      break;
      case('y'):
        alphaf2 = min(alphaf2 + 1, 255);
      break;
      case('Y'):
        alphaf2 = min(alphaf2 + 10, 255);
      break;
      case('u'):
        alphas2 = max(alphas2 - 1, 0);
      break;
      case('U'):
        alphas2 = max(alphas2 - 10, 0);
      break;
      case('i'):
        alphas2 = min(alphas2 + 1, 255);
      break;
      case('I'):
        alphas2 = min(alphas2 + 10, 255);
      break;
      
      
      case('V'):
        drawControls = false;
      break;
      case('B'):
        myBrush = (myBrush + 1) % 3;
      break;
      
    }
  }
}

void mouseCamera(int action) {


  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;

  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0;
  }

  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0;
  }

  if (action == 1){ //rotate
    rotateX(-ymag); 
    rotateZ(-xmag);
  } else {
    translate(xmag, ymag, 0);
  }
}

void dragMatrix() {
  float diff = dxmag-mouseX+width/2.0;
  //if (abs(diff) >  0.01) { 
    dxmag -= diff;
  //}

  diff = dymag-mouseY+height/2;
  //if (abs(diff) >  0.01) { 
    dymag -= diff;
  //}
  
}

void displayParameters() {
  int tab = 60;
  int x = tab;
  int y = 60;
  //int y = 10;
  int count = 0;
  pushStyle();  
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  rectMode(CORNER);
  fill(170, 50, 150);
  noStroke();
  rect(x-tab/2, y-20, width - tab, 30);
  fill(170, 255, 0);
  textFont(mono);
  String params = "";
  params += " " + int(frameRate);
  //params += "  fTime " + fTime;
  params += "  rfac " + int(rfac);
  params += "  rev " + revs;
  params += "  sym " + symmetry;
  params += "  seg " + segments;
  params += "  sz " + fibPow;
  params += "  rep " + rep;
  params += "  R " + rainbowRate;
  params += "  tf " + tf;
  params += "  rSh " + repShift;
  params += "  rfacInit " + rfacInit;
  params += "  rfDt " + rfacDt;
  params += "  rot " + rotRate;
  
  text(params, x, y); 
  
  hint(ENABLE_DEPTH_TEST);
  popStyle();
}
  
