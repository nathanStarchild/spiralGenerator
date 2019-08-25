int rep, segments, fTime, revs, rfacInit, restart, myBrush, goCount, loopEvery; //<>//
float fib = 1.61803398875;
float symmetry, tf, scl, scaleInc, rfacDt, rainbowRate, rotRateZ, rotRateX, repShift;
float rfac, fullTime, fibPow;
color c1, c2;
boolean scalingOn, rotateZOn, clockwiseOn, counterClockwiseOn, bgOn; 
boolean parameterDisplayOn, rotateXOn, mouseCameraOn, ctl, alt;
float xmag, ymag = 0;
float newXmag, newYmag = 0; 
float dxmag, dymag = 0;
float dnewXmag, dnewYmag = 0; 
PFont mono;
PFont schild;
boolean drawControls, paramRoutineControls, goTime, dragOn, cursorOn, growthOn, mSize;
boolean fftOn;
color f1, s1, f2, s2;
int satf1, sats1, satf2, sats2, brif1, bris1, brif2, bris2;
int alphaf1, alphas1, alphaf2, alphas2, cShifts1, cShifts2, cShiftf2;
int strWeight;
boolean record;
PImage starter;
int n=0;
int hue;
int fr1;
int recordStart = 0;
//color[] palette;
Palette myPalette;
String mode;
ParamRoutine symRtn, segRtn, sizeRtn, repRtn, rainbowRtn, tfRtn, rShiftRtn, rrzRtn, rrxRtn;
int nSaves = 0;


void setup() {
  fullScreen(P3D, SPAN);
  //fullScreen(P3D, 2);
  //size(800, 800, P3D);
  background(0, 0, 0);
  noCursor();
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(PI/3.0, float(width)/float(height), cameraZ/100.0, cameraZ*1000.0);
  colorMode(HSB, 255);
  rectMode(RADIUS);
  fr1 = 0;

  mono = createFont("Ubuntu Mono Bold", 13);
  schild = createFont("arial", 14);
  // starter = loadImage("bg.tga");
  
  record = false;
  goTime = false;
  goCount = 0;

  drawControls = false;
  paramRoutineControls = false;
  mouseCameraOn = false;
  dragOn = false;
  cursorOn = false;
  growthOn = true;
  mSize = false;
  
  myPalette = new Palette();
  loadParameters(981);
  mode = "live";
  fftOn = false;
  
  if (fftOn) {
    fftSetup();
  }

}  

void draw() {
  
  if (fftOn) {
    //do fft analysis
    fftLoop();
  }

  if (mode == "live") {
    fTime = (millis() - restart)*60/1000;
  } else {
    fTime = frameCount - restart;
  }

  if (growthOn) {
    rfac = rfacInit + pow(fTime*rfacDt, 2);
    //rfac = rfacInit + pow(fTime*rfacDt, segments);//for looping purposes
  } else if (mSize) {
    rfac = map(mouseY, 0, height, 0, 4*height);
  }
  // rotRateZ = 720 / float(loopEvery*rep);
  runParamRoutines();

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

  //interact with mouse
  if (mousePressed & dragOn) {    
    rotateX(-ymag); 
    rotateZ(-xmag);
    dragMatrix();
  } else if (mouseCameraOn) {
    mouseCamera(1);
  } else {
    mouseCamera(0);
  }

  if (rotateXOn) {
    rotateX(fTime*rotRateX*PI/360 - PI/4);
  }
  if (rotateZOn) {
    rotateZ(-fTime*rotRateZ*PI/360);
  }
  if (frameCount<=-1) {
    pushMatrix();
    rotateX(PI);
    image(starter, -width/2.0, -height/2.0);
    popMatrix();
  }
  
  strokeWeight(strWeight);
  
  //draw the spirals
  for (int n=0; n<rep; n++) {
    rotateZ(2*PI/rep);
    //rotateX(2*PI/rep);
    hue = int((n*repShift+(fTime / rainbowRate)) % 256);
    for (int t=0; t<segments*revs; t++) {
      f1 = myPalette.getColor(int((hue+(t*tf))%256), alphaf1); //<>//
      s1 = myPalette.getColor(int((hue+(t*tf)+cShifts1)%256), alphas1);
      f2 = myPalette.getColor(int((hue+(t*tf)+cShiftf2)%256), alphaf2);
      s2 = myPalette.getColor(int((hue+(t*tf)+cShifts2)%256), alphas2);
      float theta = t * 2 * PI / (segments);
      float theta2 = 2 * PI - theta;
      float r =  rfac * pow(fib, (-1 * symmetry * t/float(segments)));
      float s = r/pow(fib, fibPow);
      if (fftOn) {
        // s = s * correctedSpectrum[t%usefulBands]; 
      }
      if (r<0.01) {
        break;
      }
      if ((r-s)/30<sqrt(pow(width/2, 2) + pow(height/2, 2)) && r > 0.1 || myBrush == 3) {
        pushMatrix();
        translate(0, 0, r);
        fill(f1);
        stroke(s1);
        if (alphaf1 == 0) {
          noFill();
        } else if (alphas1 == 0) {
          noStroke();
        }
        if (clockwiseOn) {
          brush(r*sin(theta), r*cos(theta), s);
        }
        if (counterClockwiseOn) {
          fill(f2);
          stroke(s2);
          if (alphaf2 == 0) {
            noFill();
          } else if (alphas2 == 0) {
            noStroke();
          }
          brush(r*sin(theta2), r*cos(theta2), s);
        }
        popMatrix();
      }
    }
  }
  popMatrix();//pushMatrix() line 104

  if (parameterDisplayOn) {
    displayParameters();
  }

  //Recording biz
  //if (frameCount % 2 == 0) {
    //if (record && frameCount % 3 == 0) {
    if (record && false) {
    saveFrame("ok" + goCount + "/frame" + nf(n, 5) + ".tga");
    n++;
  }
  //if (frameCount > 60*30*0.5) {
    if (record && fTime == recordStart + loopEvery) { // hue == 0) {
    record = false;
    parameterDisplayOn = true;
  }
  if (goTime || fTime == fr1 - 1) {// && hue == 0) {
    parameterDisplayOn = false;
    record = true;
    goTime = false;
    goCount++;
    recordStart = fTime + 1;
    n = 0;
  }
}

void fftSetup() {
  //switching to use minim instead...
}
  

void fftLoop() {
  //switching to use minim instead....
}


void loadParameters(int n) {
  //eep what a mess. These should all be saved in some file format...
  if (mode == "record") {
    restart = frameCount;
  } else {
    restart = millis();
  }
  if (n==0) {
    revs = 10;
    symmetry = 10;//0.74;
    segments = 84;
    fibPow = 6;
    rep = 9;
    scl = 1;
    //loops every 300 frames
    loopEvery = 1200;
    rainbowRate = loopEvery / (256.0);//0.0024?
    tf = 1;
    repShift = 0.000001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,25);///!!!!
    rfacInit = 1000;
    rotRateZ = 720 / float(loopEvery*rep);
    rotRateX = pow(PI, -1);
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 0;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 255;
    alphaf2 = 255;
    alphas2 = 255;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 1211);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 0, 1);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 2, 230);
    rShiftRtn = new ParamRoutine(true, 4, 330);
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
  } else if (n==1) {
    revs = 10;
    symmetry = fib;//0.74;
    segments = 48;
    fibPow = 6.287;
    rep = 7;
    scl = 1;
    //loops every 300 frames
    loopEvery = 200;
    rainbowRate = 1.481;//0.0024?
    tf = 5.333;
    repShift = 0.000001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 800;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 0;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 255;
    alphaf2 = 255;
    alphas2 = 255;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 1, 2.5);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(false, 3, 25);
    rShiftRtn = new ParamRoutine(true, 2, 23);
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
    myPalette.setPalette(13);
    
  } else if (n==19) {
    revs = 10;
    symmetry = 200;//PI;
    segments = 18;
    fibPow = 2;
    rep = 1;
    scl = 1;
    rainbowRate = PI;
    tf = PI;
    repShift = fib;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = true;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,10);
    rfacInit = 1;
    rotRateZ = pow(PI, -1);
    rotRateX = pow(PI, -2.5);
    clockwiseOn = false;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 1;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 252;
    alphaf2 = 255;
    alphas2 = 252;
    cShifts1 = 256/2;
    cShifts2 = 256/2;
    cShiftf2 = 0;
    
    symRtn = new ParamRoutine(true, 3, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 130);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
    
  } else if (n==102) {
    revs = 10;
    symmetry = PI;
    segments = 121;
    fibPow = 7;
    rep = 1;
    scl = 1;
    rainbowRate = 36;
    tf = 12;
    repShift = fib;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = true;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,10);
    rfacInit = 1;
    rotRateZ = 12;
    rotRateX = pow(PI, -2.5);
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 1;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 255;
    alphaf2 = 255;
    alphas2 = 255;
    cShifts1 = 0;
    cShifts2 = 256/2;
    cShiftf2 = 256/2;
    
    
    symRtn = new ParamRoutine(false, 1, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 130);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
    
  } else if (n==33) {
    revs = 10;
    symmetry = 6;
    segments = 121;
    fibPow = 4;
    rep = 1;
    scl = 1;
    rainbowRate = 4;
    tf = fib;
    repShift = fib;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,6);
    rfacInit = 1;
    rotRateZ = 0.1;
    rotRateX = 0.00001;
    clockwiseOn = true;
    counterClockwiseOn = false;
    bgOn = false;
    myBrush = 1;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 255;
    alphaf2 = 255;
    alphas2 = 255;
    cShifts1 = 0;
    cShifts2 = 256/2;
    cShiftf2 = 256/2;
    
    symRtn = new ParamRoutine(false, 1, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 130);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
    
  } else if (n == 4) {//apple
    
    revs = 1;
    symmetry = 24;
    segments = 84;//96*4;
    fibPow = 7;
    rep = 24;
    scl = 1;
    rainbowRate = 3.7;
    tf = 2.5 * 96 * 4 / segments;
    repShift = 1;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/50.0;
    rfacInit = 10;
    rotRateZ = 0.07;
    rotRateX = 0.01;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = false;
    myBrush = 0;
    strWeight = 2;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 90;
    alphas1 = 90;
    alphaf2 = 90;
    alphas2 = 90;
    cShifts1 = 256/2;
    cShifts2 = 0;
    cShiftf2 = 256/2;
    
    symRtn = new ParamRoutine(false, 1, 60);
    segRtn = new ParamRoutine(true, 0, 110);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 130);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
    
    myPalette.setPalette(2);

  } else if (n == 5) {
    
    revs = 5;
    symmetry = 4.167;
    segments = 145;
    fibPow = 5;
    rep = 12;
    scl = 1;
    rainbowRate = 1;
    tf = 0.00001;
    repShift = 0.01;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,10);
    rfacInit = 1;
    rotRateZ = 0.05;
    rotRateX = 0.00001;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = false;
    myBrush = 0;
    strWeight = 1;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 0;
    alphas1 = 100;
    alphaf2 = 0;
    alphas2 = 100;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 256/2;
    
    symRtn = new ParamRoutine(false, 1, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(true, 2, 600);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
    
    myPalette.setPalette(5);

  } else if (n==6) {
    
    revs = 4;
    symmetry = 2.618;
    segments = 84;
    rep = 5;
    scl = 1;
    rainbowRate = 3.5;
    tf = 1.57;
    repShift = 48;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1.0E-9;
    rfacInit = 303;
    rotRateZ = 0.2;
    rotRateX = pow(PI, -1);
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 2;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 252;
    alphas1 = 150;
    alphaf2 = 252;
    alphas2 = 150;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;
    
    symRtn = new ParamRoutine(false, 1, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(true, 5, 120);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);

    myPalette.setPalette(3);
  } else if (n==66) {
    
    revs = 4;
    symmetry = 16.667;
    segments = 1;//234;
    fibPow = 3;
    rep = 5;
    scl = 1;
    rainbowRate = 5.42;
    tf = 0.122;
    repShift = 1;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = true;
    scaleInc = 0.001;
    rfacDt = 1/100.0;
    rfacInit = 1;
    rotRateZ = 0.07;
    rotRateX = pow(PI, -1);
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 0;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 190;
    alphas1 = 100;
    alphaf2 = 190;
    alphas2 = 100;
    cShifts1 = 256/4;
    cShifts2 = 3*256/4;
    cShiftf2 = 256/2;
    
    symRtn = new ParamRoutine(false, 1, 60);
    segRtn = new ParamRoutine(true, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 600);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);

  } else if (n==77) {
    
    revs = 10;
    symmetry = 200;
    segments = 112;
    fibPow = 5;
    rep = 8;
    scl = 1;
    rainbowRate = fib;//0.0024?
    tf = fib;
    repShift = 0.01;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 1;
    rotRateZ = 0.05;
    rotRateX = pow(PI, -1);
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = false;
    myBrush = 0;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 50;
    alphas1 = 150;
    alphaf2 = 50;
    alphas2 = 150;
    cShifts1 = 256/6;
    cShifts2 = 256/2;
    cShiftf2 = 256/3;
  
    symRtn = new ParamRoutine(true, 3, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 600);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
  
  } else if (n==7) {
    
    revs = 10;
    symmetry = 8.264;
    segments = 84;
    fibPow = 6;
    rep = 20;
    scl = 1;
    rainbowRate = 2.22;//0.0024?
    tf = 11.031;
    repShift = 13.402;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 100;
    rotRateZ = 0.05;
    rotRateX = pow(PI, -1);
    clockwiseOn = true;
    counterClockwiseOn = false;
    bgOn = false;
    myBrush = 0;
    strWeight = 1;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 50;
    alphas1 = 150;
    alphaf2 = 50;
    alphas2 = 150;
    cShifts1 = 256/6;
    cShifts2 = 256/2;
    cShiftf2 = 256/3;
  
    symRtn = new ParamRoutine(false, 3, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 600);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
    
    
    myPalette.setPalette(6);
  
  } else if (n==8) {
    
    revs = 10;
    symmetry = 2.71828;//PI;
    segments = 72;
    fibPow = 4;
    rep = 1;
    scl = 1;
    rainbowRate = PI;
    tf = PI;
    repShift = fib;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = true;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,10);
    rfacInit = 1;
    rotRateZ = pow(PI, -1);
    rotRateX = pow(PI, -3);
    clockwiseOn = false;
    counterClockwiseOn = true;
    bgOn = false;
    myBrush = 1;
  
    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 22;
    alphas1 = 252;
    alphaf2 = 22;
    alphas2 = 252;
    cShifts1 = 256/2;
    cShifts2 = 0;
    cShiftf2 = 256/2;
    
    
    symRtn = new ParamRoutine(false, 3, 60);
    segRtn = new ParamRoutine(false, 0, 100);
    sizeRtn = new ParamRoutine(false, 1, 70);
    repRtn = new ParamRoutine(false, 0, 300);
    rainbowRtn = new ParamRoutine(false, 1, 450);
    tfRtn = new ParamRoutine(false, 2, 600);
    rShiftRtn = new ParamRoutine(false, 2, 330);
    rrzRtn = new ParamRoutine(false, 1, 118);
    rrxRtn = new ParamRoutine(false, 1, 121);
  
  } else if (n==99) {
    revs = 33;
    symmetry = 1.5;//0.74;
    segments = 48;
    fibPow = 7;
    rep = 7;
    scl = 1;
    //loops every 300 frames
    loopEvery = 300;
    tf = 256/float(segments);
    repShift = 0;
    rainbowRate = loopEvery / ((256.0*4) - repShift);//0.0024?
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacInit = 800;
    //rfacDt = sqrt((rfacInit*(pow(fib, symmetry)-1))/(pow(fib, symmetry)*pow(loopEvery, 2)));
    //rfacDt = ((pow(rfacInit*(pow(fib, symmetry)-1), 1/float(segments))))/float(loopEvery);
    fr1 = 1800;
    float n1 = rfacInit*(pow(fib, symmetry) - 1);
    println(str(n1));
    println(pow(fr1+loopEvery, segments));
    println((pow(fib, symmetry))*(pow(fr1, segments)));
    float n2 = pow(fr1+loopEvery, segments) - ((pow(fib, symmetry))*(pow(fr1, segments)));
    println(n2);
    rfacDt = pow(((rfacInit*(pow(fib, symmetry) -1))/(pow(fr1+loopEvery, segments)-(pow(fib, symmetry)*pow(fr1, segments)))), 1/float(segments)); //<>//
    rfacDt = 0.000001;
    rotRateZ = 720 / float(loopEvery*rep);
    rotRateX = pow(PI, -1);
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 0;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 255;
    alphaf2 = 255;
    alphas2 = 255;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(true, 1, loopEvery/(120.0));
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 1, loopEvery/(120.0));
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(false, 3, loopEvery/(120.0));
    rShiftRtn = new ParamRoutine(true, 2, 2*loopEvery/(120.0));
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
    mode = "record";
    goTime = false;
    
  } else if (n==9) {
    revs = 22;
    symmetry = fib;//0.74;
    segments = 318;
    fibPow = 6;
    rep = 1;
    scl = 1;
    //loops every 300 frames
    loopEvery = 900;
    tf = 256/float(segments);
    repShift = 0;
    rainbowRate = loopEvery / ((256.0) - repShift);//0.0024?
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacInit = 303686;
    //rfacDt = sqrt((rfacInit*(pow(fib, symmetry)-1))/(pow(fib, symmetry)*pow(loopEvery, 2)));
    //rfacDt = ((pow(rfacInit*(pow(fib, symmetry)-1), 1/float(segments))))/float(loopEvery);
    //fr1 = 1800;
    //float n1 = rfacInit*(pow(fib, symmetry) - 1);
    //println(str(n1));
    //println(pow(fr1+loopEvery, segments));
    //println((pow(fib, symmetry))*(pow(fr1, segments)));
    //float n2 = pow(fr1+loopEvery, segments) - ((pow(fib, symmetry))*(pow(fr1, segments)));
    //println(n2);
    //rfacDt = pow(((rfacInit*(pow(fib, symmetry) -1))/(pow(fr1+loopEvery, segments)-(pow(fib, symmetry)*pow(fr1, segments)))), 1/float(segments));
    rfacDt = 0.000000001;
    rotRateZ = 7*720 / float(loopEvery*rep);
    rotRateX = pow(PI, -1);
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 3;
    strWeight = 9;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 150;
    alphaf2 = 255;
    alphas2 = 150;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 1, loopEvery/(120.0));
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 1, loopEvery/(120.0));
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    //tfRtn = new ParamRoutine(true, 5, loopEvery/(120.0));
    tfRtn = new ParamRoutine(true, 5, 120);
    rShiftRtn = new ParamRoutine(false, 2, 2*loopEvery/(120.0));
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
    
  } else if (n==2) { //heartless machine
    revs = 10;
    symmetry = fib;//0.74;
    segments = 48;
    fibPow = 6.287;
    rep = 7;
    scl = 1;
    //loops every 300 frames
    loopEvery = 200;
    rainbowRate = 1.481;//0.0024?
    tf = 5.333;
    repShift = 0.000001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 800;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 0;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 255;
    alphaf2 = 255;
    alphas2 = 255;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(true, 1, 4.872);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 3, 85);
    rShiftRtn = new ParamRoutine(true, 2, 31);
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
    myPalette.setPalette(1);
    
    mode = "live";
    goTime = false;
    
  }  else if (n==3) { //why do you ask
    revs = 33;//?
    symmetry = 0.913;//0.74;
    segments = 48;
    fibPow = 6.287;
    rep = 7;
    scl = 1;
    //loops every 300 frames
    loopEvery = 200;
    rainbowRate = 12;//0.0024?
    tf = 5.333;
    repShift = 0.163;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 800;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = false;
    myBrush = 0;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 0;
    alphas1 = 255;
    alphaf2 = 0;
    alphas2 = 255;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(true, 2, 97);
    sizeRtn = new ParamRoutine(true, 1, 14.872);
    repRtn = new ParamRoutine(true, 1, 156);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 5, 328);
    rShiftRtn = new ParamRoutine(false, 2, 11);
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
    myPalette.setPalette(14);
    
    mode = "live";
    goTime = false;
    
  }  else if (n==981) { //why do you ask
    revs = 33;//?
    symmetry = 0.913;//0.74;
    segments = 84;
    fibPow = 6.287;
    rep = 6;
    scl = 1;
    //loops every 300 frames
    loopEvery = 200;
    rainbowRate = 12;//0.0024?
    tf = 5.333;
    repShift = 0.00163;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,21);
    rfacInit = 800;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = false;
    myBrush = 0;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 255;
    alphaf2 = 255;
    alphas2 = 255;
    cShifts1 = 256/12;
    cShifts2 = 256/12;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(false, 2, 97);
    sizeRtn = new ParamRoutine(false, 1, 14.872);
    repRtn = new ParamRoutine(false, 1, 156);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 10, 60);
    rShiftRtn = new ParamRoutine(false, 2, 11);
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
    myPalette.setPalette(0);
    
    mode = "live";
    goTime = false;
    
  }
  
}

void saveParams() {
  StringList list = new StringList();
  list.append(revs + "");
  list.append("" + symmetry);
  list.append("" + segments);
  list.append("" + fibPow);
  list.append("" + rep);
  list.append("" + scl);
  list.append("" + rainbowRate);
  list.append("" + tf);
  list.append("" + repShift);
  list.append("" + scalingOn);
  list.append("" + rotateZOn);
  list.append("" + rotateXOn);
  list.append("" + scaleInc);
  list.append("" + rfacDt);
  list.append("" + rfacInit);
  list.append("" + rotRateZ);
  list.append("" + rotRateX);
  list.append("" + clockwiseOn);
  list.append("" + counterClockwiseOn);
  list.append("" + bgOn);
  list.append("" + myBrush);
  list.append("" + strWeight);
  list.append("" + satf1);
  list.append("" + sats1);
  list.append("" + satf2);
  list.append("" + sats2);
  list.append("" + brif1);
  list.append("" + bris1);
  list.append("" + brif2);
  list.append("" + bris2);
  list.append("" + alphaf1);
  list.append("" + alphas1);
  list.append("" + alphaf2);
  list.append("" + alphas2);
  list.append("" + cShifts1);
  list.append("" + cShifts2);
  list.append("" + cShiftf2);
  list.append("" + symRtn.enabled);
  list.append("" + symRtn.mode);
  list.append("" + symRtn.speed);
  list.append("" + segRtn.enabled);
  list.append("" + segRtn.mode);
  list.append("" + segRtn.speed);
  list.append("" + sizeRtn.enabled);
  list.append("" + sizeRtn.mode);
  list.append("" + sizeRtn.speed);
  list.append("" + repRtn.enabled);
  list.append("" + repRtn.mode);
  list.append("" + repRtn.speed);
  list.append("" + rainbowRtn.enabled);
  list.append("" + rainbowRtn.mode);
  list.append("" + rainbowRtn.speed);
  list.append("" + tfRtn.enabled);
  list.append("" + tfRtn.mode);
  list.append("" + tfRtn.speed);
  list.append("" + rShiftRtn.enabled);
  list.append("" + rShiftRtn.mode);
  list.append("" + rShiftRtn.speed);
  list.append("" + rrzRtn.enabled);
  list.append("" + rrzRtn.mode);
  list.append("" + rrzRtn.speed);
  list.append("" + rrxRtn.enabled);
  list.append("" + rrxRtn.mode);
  list.append("" + rrxRtn.speed);
  
  list.append("" + myPalette.current);
    
  list.append(mode);  
  
  saveStrings("saves/saved"+nSaves+".txt", list.array());
  nSaves++;
}

void brush(float x, float y, float s) {
  if (myBrush == 0) { 
    rect(x, y, s, s);
  } else if (myBrush == 1) {
    ellipse(x, y, s, s);
  } else if (myBrush == 2) {
    rect(x, y, s, s);
    //        textSize(s);
    //textFont(mono);
    //text("@ starchildart", x, y);
  } else if (myBrush == 3) {
    //pushStyle();
    //strokeWeight(2);
    line(0, 0, 0, x, y, s);
    //popStyle();
  }
}

public class ParamRoutine {
  boolean enabled;
  int mode;
  float speed, prevVal;
  int nModes;
    ParamRoutine (boolean on, int m, float s) {
      this.enabled = on;
      this.mode = m;
      this.speed = s;
      this.nModes = 13;
      this.prevVal = -99;
    }

    int getInt(int valIn) {
      int valOut = valIn;
      if (mode==0) {
        if (fTime % max(1, abs(int(speed))) == 0) {
          return int(valIn + int(speed/abs(speed)));
        }
      } else if (mode == 1) {
        float t = fTime/(60*2*this.speed);
        valOut = int(map(sin(6*PI/10 + t*PI*10), -1, 1, 1, 18));
      } else if (mode == 2) { //0 - 255 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = int(map(sin(6*PI/10 + t*PI*2), -1, 1, 1, 255));
      } else if (mode == 6) { //mousex
        valOut = int(map(mouseX, 0, width, 0, 150));
      }
      return valOut;
    }

    float getFloat(float valIn) {
      float valOut = valIn;
      if (mode == 0) {
        valOut = pow(valIn, speed);
      } else if (mode == 1) {
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(PI/2 + t*PI*2), -1, 1, 0.3, 7.5);
      } else if (mode == 2) { //0 - 255 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(3*PI/2 + t*PI*2), -1, 1, 0, 255);
      } else if (mode == 3) { //0 - 255 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(3*PI/2 + t*PI*2), -1, 1, 0, 255/2);
      } else if (mode == 4) { //0 - 255/16 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(3*PI/2 + t*PI*2), -1, 1, 0, 12);
      } else if (mode == 5) { //0 - 255/16 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(3*PI/2 + t*PI*2), -1, 1, 0, 3);
      } else if (mode == 5) {
        if (valOut > 100) {
          valOut *= 0.9996;
        } else if (valOut > 50) {
          valOut *= 0.9997;
        } else if (valOut > 20) {
          valOut *= 0.9998;
        } else if (valOut > 10) {
          valOut *= 0.99981;
        } else if (valOut > 5) {
          valOut *= 0.99981;
        } else if (valOut > 2) {
          valOut *= 0.99981;
        } else if (valOut > 1) {
          valOut *= 0.99981;
        }  else if (valOut > 0.5) {
          valOut *= 0.999812;
        }
      } else if (mode == 6) { //mousex
        valOut = map(mouseX, 0, width, 0, 15);
      } else if (mode == 7) { //0 - 255 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(3*PI/2 + t*PI*2), -1, 1, 40, 295);
      } else if (mode == 8) { //0 - 255 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(3*PI/2 + t*PI*2), -1, 1, 65, 295);
      } else if (mode == 9) { //7 -> 0 log
        //float t = (1 + fTime)/(this.speed);
        //println(log(t));
        //valOut = map(log(t), log(1/(this.speed)), 100000, 7, 0);
        float t = (fTime)/(this.speed);
        valOut = pow(7, 1-t);
      } else if (mode == 10) {
        float th = (fTime/(30 * this.speed)) * 2 * PI ;
        float r = 20;
        float x = r * cos(th);
        float y = r * sin(th);
        valOut = map(noise(x, y), 0, 1, (0), (256*2));
      } else if (mode == 11) {
        float th = (fTime/(30 * this.speed)) * 2 * PI ;
        float r = 3;
        float x = r * cos(th);
        float y = r * sin(th);
        valOut = map(noise(x, y), 0, 1, -4, 8);
      } else if (mode == 12) {
        float th = (fTime/(30 * this.speed)) * 2 * PI ;
        float r = 2;
        float x = 4 + r * cos(th);
        float y = 4 + r * sin(th);
        valOut = map(noise(x, y), 0, 1, 0, 4);
      }
      if (prevVal == -99) {
        prevVal = valOut;
      }
      float v = lerp(prevVal, valOut, 0.001);
      prevVal = v;
      return v;
    }

    void toggle() {
      this.enabled = !this.enabled;
    }

    void nextMode() {
      this.mode = (this.mode + 1) % this.nModes;
    }
    
    void setMode(int n) {
      this.mode = n;
    }

    void setSpeed(float speedIn) {
      this.speed = speedIn;
    }

    void incSpeed(float fac) {
      this.speed *= fac;
    }

    void decSpeed(float fac) {
      this.speed /= fac;
    }

    void reverse() {
      this.speed = -this.speed;
    }
}

void runParamRoutines() {
  //symRtn, segRtn, sizeRtn, repRtn, rainbowRtn, tfRtn, rShiftRtn, rrzRtn, rrxRtn
  
  if (symRtn.enabled) {
    symmetry = symRtn.getFloat(symmetry);
  }
  if (segRtn.enabled) {
    segments = segRtn.getInt(segments);
  }
  if (sizeRtn.enabled) {
    fibPow = sizeRtn.getFloat(fibPow);
  }
  if (repRtn.enabled) {
    rep = repRtn.getInt(rep);
  }
  if (rainbowRtn.enabled) {
    rainbowRate = rainbowRtn.getFloat(rainbowRate);
  }
  if (tfRtn.enabled) {
    tf = tfRtn.getFloat(tf);
  }
  if (rShiftRtn.enabled) {
    repShift = rShiftRtn.getFloat(repShift);
  }
  if (rrzRtn.enabled) {
    rotRateZ = rrzRtn.getFloat(rotRateZ);
  }
  if (rrxRtn.enabled) {
    rotRateX = rrxRtn.getFloat(rotRateX);
  }
}

public void keyReleased() {
  if (key == CODED) {
    if (keyCode == CONTROL) {
      ctl = false;
    } else if (keyCode == ALT) {
      alt = false;
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == CONTROL) {
      ctl = true;
    } else if (keyCode == ALT) {
      alt = true;
    }
  }
  if (!(drawControls || paramRoutineControls)) {
    switch(key) {
      case('1'):
        loadParameters(1);
        break;
      case('2'):
        loadParameters(2);
        break;
      case('3'):
        loadParameters(3);
        break;
      case('4'):
        loadParameters(4);
        break;
      case('5'):
        loadParameters(5);
        break;
      case('6'):
        loadParameters(6);
        break;
      case('7'):
        loadParameters(7);
        break;
      case('8'):
        loadParameters(8);
        break;
      case('9'):
        loadParameters(9);
        break;
      case('0'):
        loadParameters(0);
        break;
      case('!'):
        goTime = true;
        //goCount++;
      break;
      case('@'):
      record = false;
      break;
      case('"'):
      save("savedImage"+int(random(10000))+".tif");
      break;
      case('Q'):
      paramRoutineControls = true;
      break;
      case('q'):
      revs = revs + 1;
      break;
      case('a'):
      revs = max(1, revs - 1);
      break;
      case('w'):
      symmetry = symmetry * 1.1;
      break;
      case('s'):
      symmetry = symmetry / 1.1;
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
      tf = tf / 1.1;
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
      if (mode == "record") {
        restart = frameCount;
      } else {
        restart = millis();
      }
      //record = true;
      //symmetry = 200;
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
      case('c'):
        xmag = 0;
        ymag = 0;
      break;
      case('v'):
        mouseCameraOn = !mouseCameraOn;
      break;
      case('V'):
      drawControls = true;
      break;
      case('b'):
      bgOn = !bgOn;
      break;
      case('n'): 
        dragOn = !dragOn;
      break;
      case('N'):
        cursorOn = !cursorOn;
        
        if (!cursorOn) {
          noCursor();
        } else {
          cursor(CROSS);
        }
      break;
      case('m'):
      rotateZOn = !rotateZOn;
      break;
      case('M'):
      rotateXOn = !rotateXOn;
      break;
      case('.'):
      rotRateZ *= 1.1;
      break;
      case(','):
      rotRateZ /= 1.1;
      break;
      case('>'):
      rotRateX *= 1.1;
      break;
      case('<'):
      rotRateX /= 1.1;
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
      case('P'):
      rfacDt *=11;
      break;
      case(';'):
      rfacDt /= 1.1;
      break;   
      case(':'):
      rfacDt /= 11;
      break;   
      case('['):
        growthOn = !growthOn;
      break;
      case('{'):
        mSize = !mSize;
      break;
      case(']'):
        growthOn = false;
        mSize = true;
        symRtn.enabled = true;
        symRtn.setMode(6);
      break;  
      case('}'):
        growthOn = true;
        mSize = false;
        symRtn.enabled = false;
        symRtn.setMode(6);
      break;    
      case('B'):
      myBrush = (myBrush + 1) % 4;
      break;
      case('+'):
        saveParams();
        break;
      case(' '):
        fftOn = !fftOn;
        break;
    }
  } else if (drawControls) {
    switch(key) {
      case('1'):
      myPalette.setPalette(1);
      break;
      case('2'):
      myPalette.setPalette(2);
      break;
      case('3'):
      myPalette.setPalette(3);
      break;
      case('4'):
      myPalette.setPalette(4);
      break;
      case('5'):
      myPalette.setPalette(5);
      break;
      case('6'):
      myPalette.setPalette(6);
      break;
      case('7'):
      myPalette.setPalette(7);
      break;
      case('8'):
      myPalette.setPalette(8);
      break;
      case('9'):
      myPalette.setPalette(9);
      break;
      case('0'):
      myPalette.setPalette(0);
      break;
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
      case('o'):
      strWeight++;
      break;
      case('O'):
      strWeight = 1;
      break;
      case('l'):
      strWeight--;
      break;
      case('p'):
      myPalette.nextPalette();
      break;
      case('V'):
      drawControls = false;
      break;
      case('a'):
      cShifts1 += 256/36;
      break;
      case('A'):
      cShifts1 += 256/8;
      break;
      case('s'):
      cShiftf2 += 256/36;
      break;
      case('S'):
      cShiftf2 += 256/8;
      break;
      case('d'):
      cShifts2 += 256/36;
      break;
      case('D'):
      cShifts2 += 256/8;
      break;
      case('z'):
      cShifts1 -= 256/36;
      cShifts1 = max(0, cShifts1);
      break;
      case('Z'):
      cShifts1 -= 256/8;
      cShifts1 = max(0, cShifts1);
      break;
      case('x'):
      cShiftf2 -= 256/36;
      cShiftf2 = max(0, cShiftf2);
      break;
      case('X'):
      cShiftf2 -= 256/8;
      cShiftf2 = max(0, cShiftf2);
      break;
      case('c'):
      cShifts2 -= 256/36;
      cShifts2 = max(0, cShifts2);
      break;
      case('C'):
      cShifts2 -= 256/8;
      cShifts2 = max(0, cShifts2);
      break;
    }
  } else if (paramRoutineControls) {
    switch(key) {
      case('Q'):
      paramRoutineControls = false;
      break;
      case('2'):
      symRtn.toggle();
      break;
      case('@'):
      symRtn.nextMode();
      break;
      case('w'):
      symRtn.incSpeed(1.1);
      break;
      case('W'):
      symRtn.incSpeed(2);
      break;
      case('s'):
      symRtn.decSpeed(1.1);
      break;
      case('S'):
      symRtn.decSpeed(2);
      break;
      case('x'):
      symRtn.reverse();
      break;
      case('X'):
      symRtn.setMode(6);
      break;
      case('3'):
      segRtn.toggle();
      break;
      case('#'):
      segRtn.nextMode();
      break;
      case('e'):
      segRtn.incSpeed(1.1);
      break;
      case('E'):
      segRtn.incSpeed(2);
      break;
      case('d'):
      segRtn.decSpeed(1.1);
      break;
      case('D'):
      segRtn.decSpeed(2);
      break;
      case('c'):
      segRtn.reverse();
      break;
      case('C'):
      segRtn.setMode(6);
      break;
      case('4'):
      sizeRtn.toggle();
      break;
      case('$'):
      sizeRtn.nextMode();
      break;
      case('r'):
      sizeRtn.incSpeed(1.1);
      break;
      case('R'):
      sizeRtn.incSpeed(2);
      break;
      case('f'):
      sizeRtn.decSpeed(1.1);
      break;
      case('F'):
      sizeRtn.decSpeed(2);
      break;
      case('v'):
      sizeRtn.reverse();
      break;
      case('V'):
      sizeRtn.setMode(6);
      break;
      case('5'):
      repRtn.toggle();
      break;
      case('%'):
      repRtn.nextMode();
      break;
      case('t'):
      repRtn.incSpeed(1.1);
      break;
      case('T'):
      repRtn.incSpeed(2);
      break;
      case('g'):
      repRtn.decSpeed(1.1);
      break;
      case('G'):
      repRtn.decSpeed(2);
      break;
      case('b'):
      repRtn.reverse();
      break;
      case('B'):
      repRtn.setMode(6);
      break;
      case('6'):
      rainbowRtn.toggle();
      break;
      case('^'):
      rainbowRtn.nextMode();
      break;
      case('y'):
      rainbowRtn.incSpeed(1.1);
      break;
      case('Y'):
      rainbowRtn.incSpeed(2);
      break;
      case('h'):
      rainbowRtn.decSpeed(1.1);
      break;
      case('H'):
      rainbowRtn.decSpeed(2);
      break;
      case('n'):
      rainbowRtn.reverse();
      break;
      case('N'):
      rainbowRtn.setMode(6);
      break;
      case('7'):
      tfRtn.toggle();
      break;
      case('&'):
      tfRtn.nextMode();
      break;
      case('u'):
      tfRtn.incSpeed(1.1);
      break;
      case('U'):
      tfRtn.incSpeed(2);
      break;
      case('j'):
      tfRtn.decSpeed(1.1);
      break;
      case('J'):
      tfRtn.decSpeed(2);
      break;
      case('m'):
      tfRtn.reverse();
      break;
      case('M'):
      tfRtn.setMode(6);
      break;
      case('8'):
      rShiftRtn.toggle();
      break;
      case('*'):
      rShiftRtn.nextMode();
      break;
      case('i'):
      rShiftRtn.incSpeed(1.1);
      break;
      case('I'):
      rShiftRtn.incSpeed(2);
      break;
      case('k'):
      rShiftRtn.decSpeed(1.1);
      break;
      case('K'):
      rShiftRtn.decSpeed(2);
      break;
      case(','):
      rShiftRtn.reverse();
      break;
      case('<'):
      rShiftRtn.setMode(6);
      break;
      case('9'):
      rrzRtn.toggle();
      break;
      case('('):
      rrzRtn.nextMode();
      break;
      case('o'):
      rrzRtn.incSpeed(1.1);
      break;
      case('O'):
      rrzRtn.incSpeed(2);
      break;
      case('l'):
      rrzRtn.decSpeed(1.1);
      break;
      case('L'):
      rrzRtn.decSpeed(2);
      break;
      case('.'):
      rrzRtn.reverse();
      break;
      case('0'):
      rrxRtn.toggle();
      break;
      case(')'):
      rrxRtn.nextMode();
      break;
      case('p'):
      rrxRtn.incSpeed(1.1);
      break;
      case('P'):
      rrxRtn.incSpeed(2);
      break;
      case(';'):
      rrxRtn.decSpeed(1.1);
      break;
      case(':'):
      rrxRtn.decSpeed(2);
      break;
      case('/'):
      rrxRtn.reverse();
      break;
    }
  }
}

void mouseCamera(int action) {
  
  if (action == 0) {
    rotateX(-ymag); 
    rotateZ(-xmag);
    return;
  }
    


  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/(float(height) * 0.9) * TWO_PI;

  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0;
  }

  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0;
  }

  if (action == 1) { //rotate
    rotateX(-ymag); 
    rotateZ(-xmag);
  } else if (action ==0 ) {
    //pass
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

String fmtStr(float x, int digits) {
  float rounded = round(x * pow(10, digits))/pow(10, digits);
  String stringOut = str(rounded);
  float decimal = round((rounded - floor(x)) * pow(10, digits))/pow(10, digits);
  if (str(decimal).length() - 2 < digits) {
    for (int i=0; i<digits - (str(decimal).length() - 2); i++) {
      stringOut += "0";
    }
  }
  return stringOut;
}

String padString(String x, int digits) {
  String stringOut = x;
  int l = stringOut.length();
  if (l < digits) {
    for (int i=0; i<digits - l; i++) {
      stringOut += " ";
    }
  }
  return stringOut;
}

String paramRtnStr(ParamRoutine p) {
  String out = "";
  if (p.enabled) {
    out += "on ";
  } else {
    out += "off";
  }
  out += " " + str(p.mode);
  out += " " + padString(fmtStr(p.speed, 3), 7);
  return out;
}

void displayParameters() {
  int tab = 30;
  int x = tab;
  //int y = height - 150;
  int y = 60;
  int count = 0;
  pushStyle();  
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  rectMode(CORNER);
  fill(170, 20, 255);
  noStroke();
  rect(0, y-35, width, 50);
  fill(170, 255, 0);
  textFont(mono);
  String params = "";
  params += " " + int(frameRate) + " ";
  //params += "  fTime " + fTime;
  //params += padString(fmtStr((fullTime) - (frameCount / (60.0 * 60.0)), 3), 7);
  if (paramRoutineControls) {
    params += " " + paramRtnStr(symRtn);
    params += " " + paramRtnStr(segRtn);
    params += " " + paramRtnStr(sizeRtn);
    params += " " + paramRtnStr(repRtn);
    params += " " + paramRtnStr(rainbowRtn);
    params += " " + paramRtnStr(tfRtn);
    params += " " + paramRtnStr(rShiftRtn);
    params += " " + paramRtnStr(rrzRtn);
    params += " " + paramRtnStr(rrxRtn);
  } else if (drawControls) {
    params += " 0  ";
    params += " " + padString(str(alphaf1), 3);
    params += "   " + padString(fmtStr(cShifts1, 0), 3);
    params += " " + padString(str(alphas1), 3);
    params += "   " + padString(fmtStr(cShiftf2, 0), 3);
    params += " " + padString(str(alphaf2), 3);
    params += "   " + padString(fmtStr(cShifts2, 0), 3);
    params += " " + padString(str(alphas2), 3);
    params += "   " + padString(str(strWeight), 3);
    
  } else {
    params += " " + padString(str(int(rfac)), 7);
    params += " " + padString(str(revs), 7);
    params += " " + padString(fmtStr(symmetry, 3), 7);
    params += " " + padString(str(segments), 7);
    params += " " + padString(fmtStr(fibPow, 3), 7);
    params += " " + padString(str(rep), 7);
    params += " " + padString(fmtStr(rainbowRate, 3), 7);
    params += " " + padString(fmtStr(tf, 3), 7);
    params += " " + padString(fmtStr(repShift, 3), 7);
    //params += " " + rfacInit;
    params += " " + padString(fmtStr(rfacDt, 3), 7);
    params += " " + padString(fmtStr(rotRateZ, 3), 7);
    params += " " + padString(fmtStr(rotRateX, 3), 7);

  }
  text(params, x, y); 

  hint(ENABLE_DEPTH_TEST);
  popStyle();
}
