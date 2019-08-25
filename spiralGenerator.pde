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

import processing.sound.*;
FFT fft;
SoundFile aIn;
//AudioIn aIn;
int bands = 512;
int usefulBands = bands/2;
float[] sum = new float[usefulBands];
float[] avg = new float[usefulBands];
float[] correctedSpectrum = new float[usefulBands];
//float[] spectrum = new float[bands];
float smoothingFactor = 0.1;
int count = 0; //changeme
float totalAverage = 0.01; //changeme
float currentAvg = 0;

void setup() {
  fullScreen(P3D, SPAN);
  //fullScreen(P3D, 2);
  //size(800, 800, P3D);
  background(0, 0, 0);
  noCursor();
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(PI/3.0, float(width)/float(height), cameraZ/100.0, cameraZ*1000.0);
  mode = "record";//"live";//or "record"
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
  
  //palette = rainbowPalette();
  //palette = switchPalette(2);
  myPalette = new Palette();
  loadParameters(981);
  mode = "live";
  fftOn = false;
  
  if (fftOn) {
    fftSetup();
  }
  //lights();

}  

void draw() {
  
  if (fftOn) {
    fftLoop();
  }

  //mode = "live";
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
  //tfRoutine();
  //symmetryRoutine();
  //rainbowRate = symmetry*11;
  runParamRoutines();
  //tf = 15 + currentAvg * 255;
  //symmetry = 5 - currentAvg * 255;
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
  if (true) {
    //rotateX(PI/8);
    //rotateX(map(sin((fTime/(60.0*60.0))*4*PI), -1, 1, -PI/6, PI/6));
    //rotateY(map(sin((fTime/(60.0*60.0))*4.5*PI), -1, 1, -PI/6, 0));
  }
  
  strokeWeight(strWeight);
  
  for (int n=0; n<rep; n++) {
    rotateZ(2*PI/rep);
    //rotateX(2*PI/rep);
    hue = int((n*repShift+(fTime / rainbowRate)) % 256);
    for (int t=0; t<segments*revs; t++) {
      //f1 = color((hue+(t*tf))%256, satf1, brif1, alphaf1);
      //s1 = color((hue+(t*tf)+cShifts1)%256, sats1, bris1, alphas1);
      //f2 = color((hue+(t*tf)+cShiftf2)%256, satf2, brif2, alphaf2);
      //s2 = color((hue+(t*tf)+cShifts2)%256, sats2, bris2, alphas2);
      f1 = myPalette.getColor(int((hue+(t*tf))%256), alphaf1); //<>//
      s1 = myPalette.getColor(int((hue+(t*tf)+cShifts1)%256), alphas1);
      f2 = myPalette.getColor(int((hue+(t*tf)+cShiftf2)%256), alphaf2);
      s2 = myPalette.getColor(int((hue+(t*tf)+cShifts2)%256), alphas2);
      float theta = t * 2 * PI / (segments);
      float theta2 = 2 * PI - theta;
      float r =  rfac * pow(fib, (-1 * symmetry * t/float(segments)));
      //r = r * correctedSpectrum[t%usefulBands]; 
      //float s = r * correctedSpectrum[t%usefulBands] * 5/pow(fib, fibPow);
      float s = r/pow(fib, fibPow);
      if (fftOn) {
        s = s * correctedSpectrum[t%usefulBands]; 
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
  popMatrix();
  if (parameterDisplayOn) {
    displayParameters();
  }
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
  aIn = new SoundFile(this, "left alone.wav");
  aIn.loop();
  // Create an Audio input and grab the 1st channel
  //aIn = new AudioIn(this, 0);
  // Begin capturing the audio input
  //aIn.start();
  fft = new FFT(this, bands);
  fft.input(aIn);
}
  

void fftLoop() {
  // Perform the analysis
  fft.analyze();
  
  float avgSum = 0;
  currentAvg = 0;
  

  for (int i = 0; i < usefulBands; i++) {
    // Smooth the FFT spectrum data by smoothing factor
    //sum[i] += (fft.spectrum[i] - sum[i]) * smoothingFactor;
    if (fft.spectrum[i] > sum[i]) {
      sum[i] = lerp(sum[i], fft.spectrum[i], 0.5);
    } else {
      sum[i] = lerp(sum[i], fft.spectrum[i], 0.05);
    }
      
    currentAvg += sum[i];
    
    //keep a running average
    avg[i] = (sum[i] + avg[i] * count) / (count + 1);
    count++;
    avgSum += avg[i];

    // Draw the rectangles, adjust their height using the scale factor
    //rect(i*barWidth, height, barWidth, -sum[i]*height);
    //pushStyle();
    //fill(100, 100, 255);
    //ellipse(i*barWidth, height-avg[i]*height, barWidth, barWidth);
    float cf = totalAverage / avg[i];
    //fill(100, 100, 100);
    //popStyle();
    //rect(i*barWidth, height, barWidth/2, -sum[i]*height*cf*scale);
    correctedSpectrum[i] = sum[i] * cf;
  }
  totalAverage = avgSum/usefulBands;
  currentAvg = currentAvg / usefulBands;
}


void loadParameters(int n) {
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

class Palette {
  int nPalettes, current;
  color[] palette;
  
  Palette () {
    nPalettes = 35;
    current = 0;
    palette = this.switchPalette(0);
  }
  
  color getColor(int n, int alpha) {
    color c = this.palette[n];
    color alphaColor = alpha << 030;
    return c & ~#000000 | alphaColor; //some serious bitbanging magic
  }
  
  void nextPalette(){
    this.current = (this.current + 1) % this.nPalettes;
    this.palette = this.switchPalette(this.current);
  }
  
  void setPalette(int n) {
    if (n >= this.nPalettes) {
      return;
    }
    this.current = n;
    this.palette = this.switchPalette(this.current);    
  }
  
  color[] rainbowPalette() {
    pushStyle();
    colorMode(HSB, 360, 1, 1);
    int[] hueValues = {0, 15, 30, 60, 90, 120, 150, 180, 210, 225, 240, 270, 300, 330};//, 360};
    color[] c = new color[hueValues.length];
    for (int index = 0; index < hueValues.length; index++) {
      c[index] = color(hueValues[index], 1, 1);
    }
    popStyle();
    return this.getPalette(c);
  }
  
  color[] rainbowBWPalette() {
    pushStyle();
    colorMode(HSB, 360, 1, 1);
    int[] hueValues = {0, 15, 30, 60, 90, 120, 150, 180, 210, 225, 240, 270, 300, 330};//, 360};
    color[] c = new color[hueValues.length*2];
    for (int index = 0; index < hueValues.length; index++) {
      c[2*index] = color(hueValues[index], 1, 1);
      c[2*index + 1] = color(1, 0,  index%2);
    }
    popStyle();
    return this.getPalette(c);
  }
  
  color[] getPalette(color[] colorsIn) {
    int nColors = colorsIn.length;
    color[] palette = new color[256];
    int stepsPerCycle = 256 / nColors;
    int n = 0;
    int c = 0;
    while (n < 256) {
      for (int i=0; i<stepsPerCycle; i++) {
        if (n<256){
          //palette[n] = lerpColor(colorsIn[c%nColors], colorsIn[(c+1)%nColors], float(i)/float(stepsPerCycle));
          palette[n] = smootherStepC(colorsIn[c%nColors], colorsIn[(c+1)%nColors], float(i)/float(stepsPerCycle));
        }
        n++;
      }
      c++;
    }
    return palette;
  }
  
  color[] switchPalette(int n) {
    if (n==1) {
      //b/w
      return this.getPalette(new color[] {color(0), color(255)});
    } else if (n==2) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[9];
      c[0] = color(184, 215, 0);
      c[1] = color(0, 181, 8);
      c[2] = color(251, 81, 3);
      c[3] = color(251, 153, 20);
      c[4] = color(247, 221, 0);
      c[5] = color(239, 192, 114);
      c[6] = color(248, 238, 203);
      c[7] = color(88, 206, 210);
      c[8] = color(69, 1, 148);
      popStyle();
      return this.getPalette(c);
    } else if (n==3) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[9];    
      c[0] = color(50,36,41);
      c[1] = color(246,172, 213);
      c[2] = color(248, 0, 106 );
      c[3] = color(121, 21, 145);
      c[4] = color(96, 16, 185);
      c[5] = color(72, 47, 174);
      c[6] = color(234, 0, 169);
      c[7] = color(1, 0, 0);
      c[8] = color(97, 11, 200);
      popStyle();
      return this.getPalette(c);
    } else if (n==4) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[5];    
      c[0] = color(253,0,255);
      c[1] = color(253,255,0);
      c[2] = color(0,255,56);
      c[3] = color(0,249,255);
      c[4] = color(60,0,255);
      popStyle();
      return this.getPalette(c);
    } else if (n==5) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[5];   
      c[0] = color(0, 255, 255);
      c[1] = color(255,155,141);
      c[2] = color(255,0,243);
      c[3] = color(170,0,255);
      c[4] = color(0,46,255);
      popStyle();
      return this.getPalette(c);
    } else if (n==6) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[5];
      c[0] = color(1, 0, 0);
      c[1] = color(0,255,210);
      c[2] = color(0,186,163);
      c[3] = color(86,255,182);
      c[4] = color(81,81,81);
      popStyle();
      return this.getPalette(c);
    } else if (n==7) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[9];
      c[0] = color(180, 77, 202);
      c[1] = color(248, 180, 250);
      c[2] = color(100,0,151);
      c[3] = color(78, 169, 246);
      c[4] = color(223, 239, 253);
      c[5] = color(11, 106, 186);
      c[6] = color(108, 186, 129);
      c[7] = color(190, 255, 227);
      c[8] = color(0, 202, 96);
      popStyle();
      return this.getPalette(c);
    } else if (n==8) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[5];
      c[0] = color(166,124,0);
      c[1] = color(191,155,48);
      c[2] = color(255,191,0);
      c[3] = color(255,207,64);
      c[4] = color(255,220,115);
      popStyle();
      return this.getPalette(c);
    } else if (n==9) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[6];
      c[0] = color(255, 247, 103);
      c[1] = color(146, 234, 176);
      c[2] = color(87, 214, 231);
      c[3] = color(146, 234, 176);
      c[4] = color(255, 247, 103);
      c[5] = color(247, 104, 168);
      popStyle();
      return this.getPalette(c);
    } else if (n==10) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[2];
      c[0] = color(255, 0, 255);
      c[1] = color(0, 255, 255);
      popStyle();
      return this.getPalette(c);
    } else if (n==11) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[8];
      c[0] = color(156, 213, 48);
      c[1] = color(85, 102, 53);
      c[2] = color(54, 64, 33);
      c[3] = color(3, 95, 87);
      c[4] = color(0, 176, 171);
      c[5] = color(147, 231, 224);
      c[6] = color(216, 231, 230);
      c[7] = color(222, 240, 202);
      //c[0] = color(156, 213, 48);
      //c[1] = color(0, 176, 171);
      //c[2] = color(0);
      popStyle();
      return this.getPalette(c);
    } else if (n==12) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[6];
      c[0] = color(126, 186, 186);
      c[1] = color(126, 186, 186);
      c[2] = color(76, 123, 139);
      c[3] = color(76, 123, 139);
      c[4] = color(178, 78,142);
      c[5] = color(178, 78,142);
      popStyle();
      return this.getPalette(c);
    } else if (n==13) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = color(43, 240, 252);
      c[1] = color(105, 10, 255);
      c[2] = color(0, 247, 222);
      c[3] = color(51, 2, 174);
      popStyle();
      return this.getPalette(c);
    } else if (n==14) {
      return this.rainbowBWPalette();
    } else if (n==15) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #08F7FE;
      c[1] = #09FBD3;
      c[2] = #FE53BB;
      c[3] = #F5D300;
      popStyle();
      return this.getPalette(c);
    } else if (n==16) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FFACFC;
      c[1] = #F148FB;
      c[2] = #7122FA;
      c[3] = #560A86;
      popStyle();
      return this.getPalette(c);
    } else if (n==17) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #75D5FD;
      c[1] = #B76CFD;
      c[2] = #FF2281;
      c[3] = #011FFD;
      popStyle();
      return this.getPalette(c);
    } else if (n==18) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FDC7D7;
      c[1] = #FF9DE6;
      c[2] = #A5D8F3;
      c[3] = #E8E500;
      popStyle();
      return this.getPalette(c);
    } else if (n==19) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #00FECA;
      c[1] = #FDF200;
      c[2] = #FF85EA;
      c[3] = #7B61F8;
      popStyle();
      return this.getPalette(c);
    } else if (n==20) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FFD300;
      c[1] = #DE38C8;
      c[2] = #652EC7;
      c[3] = #33135C;
      popStyle();
      return this.getPalette(c);
    } else if (n==21) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #3B27BA;
      c[1] = #E847AE;
      c[2] = #13CA91;
      c[3] = #FF9472;
      popStyle();
      return this.getPalette(c);
    } else if (n==22) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FFDEF3;
      c[1] = #FF61BE;
      c[2] = #3B55CE;
      c[3] = #35212A;
      popStyle();
      return this.getPalette(c);
    } else if (n==23) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FDD400;
      c[1] = #FDB232;
      c[2] = #02B8A2;
      c[3] = #01535F;
      popStyle();
      return this.getPalette(c);
    } else if (n==24) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FEC763;
      c[1] = #EA55B1;
      c[2] = #A992FA;
      c[3] = #00207F;
      popStyle();
      return this.getPalette(c);
    } else if (n==25) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #79FFFE;
      c[1] = #FEA0FE;
      c[2] = #FF8B8B;
      c[3] = #F85125;
      popStyle();
      return this.getPalette(c);
    } else if (n==26) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #CE96FB;
      c[1] = #FF8FCF;
      c[2] = #00C2BA;
      c[3] = #037A90;
      popStyle();
      return this.getPalette(c);
    } else if (n==27) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #01FFC3;
      c[1] = #01FFFF;
      c[2] = #FFB3FD;
      c[3] = #9D72FF;
      popStyle();
      return this.getPalette(c);
    } else if (n==28) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #A0EDFF;
      c[1] = #EBF875;
      c[2] = #28CF75;
      c[3] = #FE6B35;
      popStyle();
      return this.getPalette(c);
    } else if (n==29) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FFFF66;
      c[1] = #FC6E22;
      c[2] = #FF1493;
      c[3] = #C24CF6;
      popStyle();
      return this.getPalette(c);
    } else if (n==30) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #D9EB4B;
      c[1] = #00A9FE;
      c[2] = #FD6BB6;
      c[3] = #EF0888;
      popStyle();
      return this.getPalette(c);
    } else if (n==31) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FFE3F1;
      c[1] = #FE1C80;
      c[2] = #FF5F01;
      c[3] = #CE0000;
      popStyle();
      return this.getPalette(c);
    } else if (n==32) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FEF900;
      c[1] = #03DDDC;
      c[2] = #FF822E;
      c[3] = #F21A1D;
      popStyle();
      return this.getPalette(c);
    } else if (n==33) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #FCF340;
      c[1] = #7FFF00;
      c[2] = #FB33DB;
      c[3] = #0310EA;
      popStyle();
      return this.getPalette(c);
    } else if (n==34) {
      pushStyle();
      colorMode(RGB, 255, 255, 255, 255);
      color[] c = new color[4];
      c[0] = #E92EFB;
      c[1] = #FF2079;
      c[2] = #440BD4;
      c[3] = #04005E;
      popStyle();
      return this.getPalette(c);
    }
    return this.rainbowPalette();
  }
  
  
}


//////////////////////////////////////////////
//smootherStep biz
//////////////////////////////////////////////
//OK, well, the problem with lerpColor is that it doesn't travel 
//the shortest distance on the colour wheel, it always goes clockwise.
//So 2 colours that are next to each other if they are in 
//counter clockwise order will give a rainbow gradient.
//so we use the "smootherStep" algorithm instead. 
//As per https://medium.com/@behreajj/color-gradients-in-processing-v-2-0-e5c0b87cdfd2

int composeclr(float[] in) {
  return composeclr(in[0], in[1], in[2], in[3]);
}

// Assumes that RGBA are in range 0 .. 1.
int composeclr(float red, float green, float blue, float alpha) {
  return round(alpha * 255.0) << 24
    | round(red * 255.0) << 16
    | round(green * 255.0) << 8
    | round(blue * 255.0);
}

// Assumes that out has 4 elements.
// 1.0 / 255.0 = 0.003921569
float[] decomposeclr(int clr) {
  float[] out = new float[] { 0.0, 0.0, 0.0, 1.0 };
  out[3] = (clr >> 24 & 0xff) * 0.003921569;
  out[0] = (clr >> 16 & 0xff) * 0.003921569;
  out[1] = (clr >> 8 & 0xff) * 0.003921569;
  out[2] = (clr & 0xff) * 0.003921569;
  return out;
}

float smootherStep(float st) {
  return st * st * st * (st * (st * 6.0 - 15.0) + 10.0);
}

float[] smootherStepRgb(float[] a, float[] b, float st) {
  float[] out = new float[4];
  float eval = smootherStep(st);
  out[0] = a[0] + eval * (b[0] - a[0]);
  out[1] = a[1] + eval * (b[1] - a[1]);
  out[2] = a[2] + eval * (b[2] - a[2]);
  out[3] = a[3] + eval * (b[3] - a[3]);
  return out;
}

color smootherStepC(color c1, color c2, float frac) {
  float[] c1f, c2f = new float[4];
  c1f = decomposeclr(c1);
  c2f = decomposeclr(c2);
  return composeclr(smootherStepRgb(c1f, c2f, frac));
}
//////////////////////////////////////////////
//end smootherStep biz
//////////////////////////////////////////////

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

void tfRoutine() {  
  if (tf < 0.1) {
    tf += 0.0001;
  } else if (tf < 0.5) {
    tf += 0.001;
  } else if (tf < 3) {
    tf += 0.0014;
  } else if (tf < 6) {
    tf += 0.0021;
  } else if (tf < 7.5) {
    tf += 0.0038;
  } else if (tf < 8.5) {
    tf += 0.0022;
  } else if (tf < 15) {
    tf += 0.0044;
  } else if (tf < 18) {
    tf += 0.003;
  } else if (tf < 20) {
    tf += 0.002;
  } else if (tf < 25) {
    tf += 0.0026;
  } else if (tf < 30) {
    tf += 0.003;
  } else if (tf < 32) {
    tf += 0.006;
  } else if (tf < 40) {
    tf += 0.014;
  } else if (tf < 50) {
    tf += 0.024;
  } else if (tf < 60) {
    tf += 0.034;
  } else if (tf < 70) {
    tf += 0.043;
  } else if (tf < 75) {
    tf += 0.026;
  }else if (tf < 80) { //slow down in 70s
    tf += 0.018;
  } else if (tf < 90) {
    tf += 0.01;
  } else if (tf < 100) {
    tf += 0.024;
  } else if (tf < 120) {
    tf += 0.033;
  } else if (tf < 140) {
    tf += 0.046;
  } else if (tf < 180) {
    tf += 0.052;
  } else if (tf < 200) {
    tf += 0.036;
  } else if (tf < 220) {
    tf += 0.028;
  }  else if (tf < 240) {
    tf += 0.021;
  }  else if (tf < 250) {
    tf += 0.018;
  }  else if (tf < 253) {
    tf += 0.011;
  } else if (tf < 255) {
    tf += 0.006;
  }
}

void segRoutine() {
  if (frameCount % 100 == 0) {
    segments++;
  }
}

void symmetryRoutine() {
  //if (symmetry > 100) {
  //  symmetry *= 0.9996;
  //} else if (symmetry > 50) {
  //  symmetry *= 0.9997;
  //} else if (symmetry > 20) {
  //  symmetry *= 0.9998;
  //} else if (symmetry > 10) {
  //  symmetry *= 0.99981;
  //} else if (symmetry > 5) {
  //  symmetry *= 0.99981;
  //} else if (symmetry > 2) {
  //  symmetry *= 0.99981;
  //} else if (symmetry > 1) {
  //  symmetry *= 0.99981;
  //}  else if (symmetry > 0.5) {
  //  symmetry *= 0.999812;
  //}
  //symmetry = map((1 - frameCount/(60.0*60.0)), 1.0, 0.0, 200.0, 1.0);
  
  //float t = 1 - fTime/(60.0*60.0);
  //symmetry = pow(2.72, 5*t) - 1;
  
  float t = fTime/(60.0*60.0);
  symmetry = map(sin(6*PI/10 + t*PI*10), -1, 1, 0.5, 7);
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
