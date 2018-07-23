int rep, segments, fTime, fibPow, revs, rfacInit, restart;
float fib = 1.61803398875;
float symmetry, tf, scl, scaleInc, rfacDt, rainbowRate, rotRate, repShift;
color c1, c2;
boolean scalingOn, rotateOn, clockwiseOn, counterClockwiseOn; 
float xmag, ymag = 0;
float newXmag, newYmag = 0; 
float dxmag, dymag = 0;
float dnewXmag, dnewYmag = 0; 

void setup() {
  //size(1700, 1100);
  fullScreen(P3D, SPAN);
  background(0, 0, 0);
  noCursor();
  symmetry = 1.1;
  segments = 37;
  rep = 6;
  fibPow = 6;
  scl = 1;
  rainbowRate = 1;
  tf = 4;
  repShift = 0.1;
  scalingOn = false;
  rotateOn = true;
  scaleInc = 0.001;
  revs = 10;
  rfacDt = 1/100.0;
  rfacInit = 1000;
  rotRate = 1;
  restart = 0;
  clockwiseOn = true;
  counterClockwiseOn = true;

  colorMode(HSB, 255);
  rectMode(RADIUS);
}

void draw() {
  fTime = (millis() - restart)*60/1000;
  float rfac = rfacInit + pow(fTime*rfacDt, 2);
  //background(170, 0, 255);
  if (scalingOn) {
    scl = scl + scaleInc;
    scale(scl);
  }
  //camera angle
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
      c1 = color((hue+(t*tf))%255, 252, 252, 0);
      c2 = color((hue+(t*tf)+(256/2))%255, 252, 252, 120);
      float theta = t * 2 * PI / (segments);
      float theta2 = 2 * PI - theta;
      float r =  rfac * pow(fib, (-1 * symmetry * t/float(segments)));
      float s = r/pow(fib, fibPow);
      if (r<3000){
        pushMatrix();
        translate(0, 0, r);
        fill(c1);
        stroke(c2);
        if(clockwiseOn){
          brush(r*sin(theta), r*cos(theta), s);
        }
        //ellipse(r*sin(theta), r*cos(theta), s, s);
        //rect(r*sin(theta), r*cos(theta), s, s);
        //fill(c2);
        //stroke(c1);
        if(counterClockwiseOn){
          brush(r*sin(theta2), r*cos(theta2), s);
        }
        //ellipse(r*sin(theta2), r*cos(theta2), s, s);
        //rect(r*sin(theta2), r*cos(theta2), s, s);
        popMatrix();
      }
    }
  }
  popMatrix();
}

void brush(float x, float y, float s) {
  rect(x, y, s, s);
}

void keyPressed() {
  switch(key) {
    case('l'):
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
    case('P'):
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
    case('m'):
      rotateOn = !rotateOn;
    break;
    case('.'):
      rotRate *= 1.1;
    break;
    case(','):
      rotRate *= 0.9;
    break;
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


  //pushStyle();
  //rectMode(CORNER);
  //fill(170, 50, 150);
  //rect(0, 80, 180, 100);
  //fill(170, 255, 0);
  //text("fTime: ", 20, 100); 
  //text(fTime, 80, 100);
  //text("rfac: ", 20, 150);
  //text(rfac, 80, 150);
  //popStyle();
  
