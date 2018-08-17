int rep, segments, fTime, fibPow, revs, rfacInit, restart, myBrush;
float fib = 1.61803398875;
float symmetry, tf, scl, scaleInc, rfacDt, rainbowRate, rotRateZ, rotRateX, repShift;
float rfac, fullTime;
color c1, c2;
boolean scalingOn, rotateZOn, clockwiseOn, counterClockwiseOn, bgOn; 
boolean parameterDisplayOn, rotateXOn;
float xmag, ymag = 0;
float newXmag, newYmag = 0; 
float dxmag, dymag = 0;
float dnewXmag, dnewYmag = 0; 
PFont mono;
PFont schild, sg;
boolean drawControls;
color f1, s1, f2, s2;
int satf1, sats1, satf2, sats2, brif1, bris1, brif2, bris2;
int alphaf1, alphas1, alphaf2, alphas2, cShifts1, cShifts2, cShiftf2;

void setup() {
  // size(960, 840, P3D);
  fullScreen(P3D, SPAN);
  background(0, 0, 0);
  noCursor();
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(PI/3.0, float(width)/float(height), cameraZ/100.0, cameraZ*1000.0);
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
  restart = 0;
  fullTime = 6.1;
  clockwiseOn = false;
  counterClockwiseOn = true;
  bgOn = true;
  parameterDisplayOn = true;
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
  alphaf1 = 255;
  alphas1 = 252;
  alphaf2 = 255;
  alphas2 = 252;
  cShifts1 = 256/2;
  cShifts2 = 256/2;
  cShiftf2 = 0;

  colorMode(HSB, 255);
  rectMode(RADIUS);

  // String[] fontList = PFont.list();
  // for (int i=0; i<fontList.length; i++) {
  //   println(fontList[i]);
  // }
  mono = createFont("Ubuntu Mono Bold", 15);
  schild = createFont("Ubuntu Bold", 14);
  sg = createFont("Ubuntu", 14);
}

void draw() {
  //fTime = (millis() - restart)*60/1000;
  fTime = frameCount - restart;
  rfac = rfacInit + pow(fTime*rfacDt, 2);
  symmetryRoutine();
  // tfRoutine();
  // segRoutine();
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
  if (rotateXOn) {
    rotateX(fTime*rotRateX*PI/360 - PI/4);
  }
  if (rotateZOn) {
    rotateZ(-fTime*rotRateZ*PI/360);
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
      if (r<30000 && r > 0.001) {
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
  //saveFrame("out/frame#####.tga");
  // if (frameCount > 60*60*fullTime) {
  //   exit();
  // }
  
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
  if (!drawControls) {
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
      restart = frameCount;
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
      rotateZOn = !rotateZOn;
      break;
      case('.'):
      rotRateZ *= 1.1;
      break;
      case(','):
      rotRateZ *= 0.9;
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
  if (symmetry > 100) {
    symmetry *= 0.9996;
  } else if (symmetry > 50) {
    symmetry *= 0.9997;
  } else if (symmetry > 20) {
    symmetry *= 0.9998;
  } else if (symmetry > 10) {
    symmetry *= 0.99981;
  } else if (symmetry > 5) {
    symmetry *= 0.99981;
  } else if (symmetry > 2) {
    symmetry *= 0.99981;
  } else if (symmetry > 1) {
    symmetry *= 0.99981;
  }  else if (symmetry > 0.5) {
    symmetry *= 0.999812;
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

  if (action == 1) { //rotate
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

String padString(String x, int digits) { //<>//
  String stringOut = x;
  int l = stringOut.length();
  if (l < digits) {
    for (int i=0; i<digits - l; i++) {
      stringOut += " ";
    }
  }
  return stringOut;
}

void displayParameters() {
  int tab = 100;
  int x = tab;
  int y = height - 15;
  //int y = 10;
  int count = 0;  
  pushStyle();
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  textFont(schild);
  //fill(170, 0, 255);
  text("@starchildArt", width - tab - 8, y-10);
  textFont(sg);
  text("#spiralGenerator", width - tab - 8, y+10);  
  rectMode(CORNER);
  fill(170, 50, 180);
  noStroke();
  rect(x - 10, y-20, width -  2 * tab, 30);
  fill(170, 255, 0);
  textFont(mono);
  String params = "";
  //params += " " + int(frameRate);
  //params += "  fTime " + fTime;
  params += padString(fmtStr((fullTime) - (frameCount / (60.0 * 60.0)), 2), 7);
  params += " " + padString(str(int(rfac)), 7);
  params += " " + padString(str(revs), 7);
  params += " " + padString(fmtStr(symmetry, 3), 7);
  params += " " + padString(str(segments), 7);
  params += " " + padString(str(fibPow), 7);
  params += " " + padString(str(rep), 7);
  params += " " + padString(fmtStr(rainbowRate, 3), 7);
  params += " " + padString(fmtStr(tf, 3), 7);
  //params += " " + fmtStr(repShift, 3);
  //params += " " + rfacInit;
  params += " " + padString(fmtStr(rfacDt, 3), 7);
  params += " " + padString(fmtStr(rotRateZ, 3), 7);
  params += " " + padString(fmtStr(rotRateX, 3), 7);

  text(params, x, y); 

  hint(ENABLE_DEPTH_TEST);
  popStyle();
}
