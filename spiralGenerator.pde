int rep, segments, fTime, revs, rfacInit, restart, myBrush, goCount, loopEvery;
float fib = 1.61803398875;
float symmetry, tf, scl, scaleInc, rfacDt, rainbowRate, rotRateZ, rotRateX, repShift;
float rfac, fullTime, fibPow, fRate, fHue;
float rf1, rf2, rf3;
int loopGrowths;
int nVids;
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
ParamRoutine symRtn, segRtn, sizeRtn, repRtn, rainbowRtn, tfRtn, rShiftRtn, rrzRtn, rrxRtn, rfacRtn;
int nSaves = 0;
OpenSimplexNoise osNoise;
import AULib.*;
boolean starting = true;
PImage img;
ArrayList<PImage> images = new ArrayList<PImage>();
int im = 0;
boolean frameOn = false;
boolean playVideo1 = false;
boolean playVideo2 = false;
boolean first = false;
PImage vid1;
PImage vid2;
boolean showSpiral = true;
int tn = 0;
int tFrame = 1;
int oFrame = 255;
Easer tFrameEaser = new Easer(1, 1222);
boolean frameIncrement = false;
boolean withAlpha = false;
int magicNumber = 3760;
Easer tScaleEaser = new Easer(1, 1222);
Recorder myRecorder;


  PImage imggg;

void setup() {
  // fullScreen(P3D, SPAN);
  // fullScreen(P3D, 1);
  size(1280, 1010, P3D);
  // size(864, 864, P3D);
  // size(1920, 1080, P3D);
  // size(864, 864, P3D);
  noLoop();
  // smooth(3);
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
  growthOn = false;
  mSize = false;
  

  myPalette = new Palette();
  // delay(1000);
  loadParameters(1);
  myRecorder = new Recorder(this, g, loopEvery);
  // myRecorder = new Recorder(this, g, 2*30*60);
  // myRecorder.startRecording();
  // mode = "record";
  mode = "live";
  fftOn = false;
  // loadImages2();
  
  if (fftOn) {
    fftSetup();
  }
  
  osNoise = new OpenSimplexNoise((long)random(10));
  
  //img = loadImage("GRETA.jpg");
  // loadImages();
  //vid1 = loadImage("tunnel/tunnel2445.png");
  //vid1.resize(height * vid1.width/vid1.height, height);
  
  
  tScaleEaser.setValue(1);  // 

  loop();
  


}  

void draw() {
  
  // println("frame " + frameCount);
  if (first){
    first = false;

    loadImagesHal();
  }

  // println("frame " + frameCount);
  // PImage imggg = loadImage("recorded1/frame" + nf(myRecorder.n, 5) + ".jpg");
  
  //println(mode);
  
  if (fftOn) {
    //do fft analysis
    fftLoop();
  }
  if (mode == "live") {
    fTime = (millis() - restart)*60/1000;
  } else {
    fTime = frameCount - restart;
  }

  //if (growthOn) {
  //  rfac = rfacInit + pow(fTime*rfacDt, 2);
  //  //rfac = rfacInit + pow(fTime*rfacDt, segments);//for looping purposes
  //} else if (mSize) {
  //  rfac = map(mouseY, 0, height, 0, 4*height);
  //}
  if (mSize) {
   rfac = map(mouseY, 0, height, 0, 4*height);
  }
  // rotRateZ = 720 / float(loopEvery*rep);
  runParamRoutines();
  // println("rfac: " + rfac);

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
  
  
  if (playVideo1) {
    //vid1 = loadImage("tunnel/tunnel" + nf(1223 - (fTime % 1223), 4) + ".png");
    //if (frameIncrement) {
      tFrame++;
      tFrame = min(tFrame, 2445);
    //} else {
    //  tFrame = ceil(tFrameEaser.getValue(fTime));
    //}
    if (tFrame > 200){
      //println(tFrame);
      vid1 = loadImage("tunnel/tunnel" + nf(tFrame, 4) + ".png");
      tint(255);
      float sc = tScaleEaser.getValue(fTime);
      //println(sc);
      vid1.resize(int(sc * height * vid1.width/vid1.height), int(sc *  height));
      image(vid1, -vid1.width/2.0, -vid1.height/2.0);
      //tFrame--;
      //tFrame = 1224 - min(tFrame, 1223);
    }
  }
  
  if (playVideo2) {
      //println(tFrame);
      // oFrame++;

      // oFrame = min(oFrame, 7499);
      oFrame = (oFrame % 1741) + 1;
      // vid2 = loadImage("orb/orb" + nf(oFrame, 4) + ".png");
      vid2 = loadImage("mistyForest/frameN" + nf(oFrame,4) + ".jpg");
      //println("w: " + vid2.width + ", h: " + vid2.height);
      tint(255);
      // vid2.resize(height * vid2.width/vid2.height, height);
      //image(vid2, -640, -360);
      image(vid2, -vid2.width/2.0, -vid2.height/2.0);
  }

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
  ////for (int n=0; n<rep; n++) {
  //  rotateZ(2*PI/rep);
  //  //rotateX(2*PI/rep);
  //  hue = int((n*repShift+(fTime / rainbowRate)) % 256);
    //for (int t=0; t<segments*revs; t++) {
      // println(showSpiral);
  if (showSpiral){
    for (int t=segments*revs; t>=0; t--) {
      float r =  rfac * pow(fib, (-1 * symmetry * t/float(segments)));
      float s = (r)/pow((1.0*fib), fibPow);
      if ((r-s)/30>sqrt(pow(width/2, 2) + pow(height/2, 2))) {
        break;
      }
      if ((r-s)/30<sqrt(pow(width/2, 2) + pow(height/2, 2)) && r > 0.1 || myBrush == 3) {
        pushMatrix();
        translate(0, 0, r);
        for (int n=0; n<rep; n++) {
          if (fftOn) {
            // s = s * correctedSpectrum[t%usefulBands]; tsht
          }
          //if (r<0.01) {
          //  break;
          //}
          
          rotateZ(2*PI/rep);
          hue = int((n*repShift+(fTime / rainbowRate)) % 256);
          fHue = int(((n*repShift+(fTime / fRate)) % 256));
          f1 = myPalette.getColor(int((hue+(t*tf))%256), alphaf1);
          s1 = myPalette.getColor(int((hue+(t*tf)+cShifts1)%256), alphas1);
          f2 = myPalette.getColor(int((hue+(t*tf)+cShiftf2)%256), alphaf2);
          s2 = myPalette.getColor(int((hue+(t*tf)+cShifts2)%256), alphas2);
          float theta = t * 2 * PI / (segments);
          float theta2 = 2 * PI - theta;
          fill(f1);
          stroke(s1);
          if (alphaf1 == 0) {
            noFill();
          } else if (alphas1 == 0) {
            noStroke();
          }
          if (clockwiseOn) {
            brush(r*sin(theta), r*cos(theta), s);
            // im = getImgNum(1, n);
            // texnGon(myBrush, r*sin(theta), r*cos(theta), s, im, f1);
            // newTexnGon(myBrush, r*sin(theta), r*cos(theta), s, imggg, f1);
            // if (true){
              // brush(r*sin(theta), r*cos(theta), s);
            // if (s<2){
            //   brush(r*sin(theta), r*cos(theta), s);
            // } else {
            //   new2TexnGon(myBrush, r*sin(theta), r*cos(theta), 2*s, (t*n*11 + fTime)%325, f1);
            //   // texPhone(r*sin(theta), r*cos(theta), 2*s, int((n%nVids)*256 + (fHue+(t*tf))%256), f1);
            // }
          }
          if (counterClockwiseOn) {
            fill(f2);
            stroke(s2);
            if (alphaf2 == 0) {
              noFill();
            } else if (alphas2 == 0) {
              noStroke();
            }
            pushMatrix();
            translate(0, 0,  0.01);
            brush(r*sin(theta2), r*cos(theta2), s);
            // im = getImgNum(2, n);
            // texnGon(myBrush, r*sin(theta2), r*cos(theta2), s, im, f2);
            // if (true){
              // brush(r*sin(theta2), r*cos(theta2), s);
            // if (s<2){
            //   brush(r*sin(theta2), r*cos(theta2), s);
            // } else {
            //   // new2TexnGon(myBrush, r*sin(theta2), r*cos(theta2), 2*s, n*325 + (t*11 + (fTime))%325, f2);
            //   new2TexnGon(myBrush, r*sin(theta2), r*cos(theta2), 2*s, (t*11 + (fTime))%325, f2);
            //   // texPhone(r*sin(theta2), r*cos(theta2), 2*s, int((n%nVids)*256 + (fHue+(t*tf)+cShiftf2)%256), f2);
            // }
            popMatrix();
          }
        }
        popMatrix();
      }
    }
  }
  popMatrix();//pushMatrix() line 104
  

  if (parameterDisplayOn) {
    displayParameters();
  }

  // //Recording biz
  // //if (frameCount % 2 == 0) {
  //   //if (record && frameCount % 3 == 0) {
  //   if (record) {
  //   saveFrame("thisisfix" + goCount + "/frame" + nf(n, 5) + ".jpg");
  //   n++;
  // }
  // //if (frameCount > 60*30*0.5) {
  // //  if (record && fTime == recordStart + loopEvery) { // hue == 0) {
  // //  record = false;
  // //  parameterDisplayOn = true;
  // //}
  // if (goTime || fTime == fr1 - 1) {// && hue == 0) {
  //   parameterDisplayOn = true;
  //   record = true;
  //   goTime = false;
  //   goCount++;
  //   recordStart = fTime + 1;
  //   n = 1;
  // }

  // println("recording");
  myRecorder.update();
  //myRecorder.snapshot();
  //exit();
}

void fftSetup() {
  //switching to use minim instead...
}
  
void fftLoop() {
  //switching to use minim instead....
}

void loadImages() {
  images.add(loadImage("1.png"));//0
  images.add(loadImage("2.png"));//1
  images.add(loadImage("3.png"));//2
  images.add(loadImage("4.png"));//3
  images.add(loadImage("birth2.png"));//4
  images.add(loadImage("birth1.png"));//5
  images.add(loadImage("birth3.png"));//6
  images.add(loadImage("birth4.png"));//7
  images.add(loadImage("birth5.png"));//8
  images.add(loadImage("birth6.png"));//9
  images.add(loadImage("birth7.jpg"));//10
  images.add(loadImage("2the.png"));//11
  images.add(loadImage("2future.png"));//12
  images.add(loadImage("2belongs.png"));//13
  images.add(loadImage("2toThose.png"));//14
  images.add(loadImage("2who.png"));//15
  images.add(loadImage("2can.png"));//16
  images.add(loadImage("2see.png"));//17
  images.add(loadImage("2it.png"));//18
  images.add(loadImage("2allWords.png"));//19
  images.add(loadImage("2eyedrop.png"));//20
  images.add(loadImage("3Eye1.png"));//21
  images.add(loadImage("3Eye2.png"));//22
  images.add(loadImage("3Eye3.png"));//23
  images.add(loadImage("3Eye4.png"));//24
  images.add(loadImage("3Eye5.png"));//25
  images.add(loadImage("2eyedrop.png"));//26
  images.add(loadImage("1.png"));//27
  images.add(loadImage("BRAVE_WHITE.png"));//28
  images.add(loadImage("3.png"));//29
  images.add(loadImage("FEAR_WHITE.png"));//30
  images.add(loadImage("flower2bw.png"));//31
  images.add(loadImage("flower1bw.png"));//32
  images.add(loadImage("flower3bw.png"));//33
  images.add(loadImage("flower1bw.png"));//34
}

void loadImagesHal() {
  // for (int i=0; i<325; i++){
  //   println(i);
  //   images.add(loadImage("death/frame" + nf(i, 5) + ".jpg"));
  // }
  // for (int i=0; i<325; i++){
  //   println(i);
  //   images.add(loadImage("xylo/frame" + nf(i, 5) + ".jpg"));
  // }
  for (int i=0; i<325; i++){
    println(i);
    images.add(loadImage("house/frame" + nf(i, 5) + ".jpg"));
  }
  // for (int i=0; i<325; i++){
  //   println(i);
  //   images.add(loadImage("bats/frame" + nf(i, 5) + ".jpg"));
  // }
}

void loadImages2(){
  for (int n=0; n<nVids; n++){
    for (int i=0; i<256; i++){
      images.add(loadImage("" + n + "/frame" + nf(i, 5) + ".jpg"));
      println("loading " + n + "/frame" + nf(i, 5) + ".jpg");
    }
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
    //line(0, 0, 0, x, y, s);
    //        textSize(s);
    //textFont(mono);
    //text("@ starchildart", x, y);
    ellipse(x, y, s, s);
  } else if (myBrush <= 100) {
    nGon(myBrush, x, y, s);
  }
}

void nGon(int n, float x, float y, float r) {
  pushMatrix();
    translate(x, y);
    beginShape();
    for (int i=0; i<n; i++) {
      float theta = i * 2 * PI / float(n);
      vertex(r*sin(theta), r*cos(theta));
    }
    endShape(CLOSE);
  popMatrix();
}

void texnGon(int n, float x, float y, float r, int im, color f) {
  //pushMatrix();
    //translate(x, y);
    textureMode(NORMAL);
    //img.resize(int(r),int(r));
    beginShape();
    // if (withAlpha){
    //   tint(f, (f >> 16) & 0xFF);
    // } else {
    //   tint(f);
    // }
    texture(images.get(im));
    for (int i=0; i<n; i++) {
      float theta = i * 2 * PI / float(n);
      vertex(x+r*sin(theta), y+r*cos(theta), 0.5 + 1.5*sin(theta)/sqrt(3), 0.5 + 1.5*cos(theta)/sqrt(3));
      //0, 1; -0.5, -0.866
    }
    endShape(CLOSE);
  //popMatrix();
}

void newTexnGon(int n, float x, float y, float r, PImage imggg, color f) {
  //pushMatrix();
    //translate(x, y);
    textureMode(NORMAL);
    //img.resize(int(r),int(r));
    beginShape();
    // if (withAlpha){
    //   tint(f, (f >> 16) & 0xFF);
    // } else {
    //   tint(f);
    // }
    
    texture(imggg);
    for (int i=0; i<n; i++) {
      float theta = i * 2 * PI / float(n);
      vertex(x+r*sin(theta), y+r*cos(theta), 0.5 + sin(theta)/sqrt(3), 0.5 + cos(theta)/sqrt(3));
      //0, 1; -0.5, -0.866
    }
    endShape(CLOSE);
  //popMatrix();
}

void new2TexnGon(int n, float x, float y, float r, int im, color f) {
  // println(im);
  //pushMatrix();
    //translate(x, y);
    textureMode(NORMAL);
    //img.resize(int(r),int(r));
    beginShape();
    if (withAlpha){
      tint(f, (f >> 16) & 0xFF);
    } //else {
    //   tint(f);
    // }
    
    // println("loading image " + im);
    texture(images.get(im));
    for (int i=0; i<n; i++) {
      float theta = i * 2 * PI / float(n);
      vertex(x+r*sin(theta), y+r*cos(theta), 0.5 + sin(theta)/sqrt(3), 0.5 + cos(theta)/sqrt(3));
      //0, 1; -0.5, -0.866
    }
    endShape(CLOSE);
  //popMatrix();
}

void texPhone(float x, float y, float a, int im, color f) {
    float ratio = 3.0/5.0;
    float b = a / ratio;
    float gamma = asin(a/sqrt(a*a + b*b));
    float alpha = PI - 2*gamma;
    float beta = PI - alpha;
    float r = sqrt(a*a + b*b)/2.0;
    // pg.noStroke();
    if (withAlpha){
      tint(f, (f >> 16) & 0xFF);
    }

    float theta = alpha/2.0;

    // int n = (im / 256)%nVids + 2;
    // int m = im % 256;
    // PImage img = loadImage("heartless" + n + "/frame" + nf(m, 5) + ".jpg");
    // println("loading heartless" + n + "/frame" + nf(m, 5) + ".jpg");
    textureMode(NORMAL);
    beginShape();
    texture(images.get(im));
    // texture(img);
    vertex(x + r*cos(theta), y + r*sin(theta), 1-0.5*(1-ratio), 1);
    theta += beta;
    vertex(x + r*cos(theta), y + r*sin(theta), 0.5*(1-ratio), 1);
    theta += alpha;
    vertex(x + r*cos(theta), y + r*sin(theta), 0.5*(1-ratio), 0);
    theta += beta;
    vertex(x + r*cos(theta), y + r*sin(theta), 1-0.5*(1-ratio), 0);
    endShape(CLOSE); 
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
        // goTime = true;
        // restart = frameCount;
        //goCount++;
        myRecorder.startRecording();
      break;
      case('@'):
      record = false;
      break;
      case('#'):
        myRecorder.startRecording();
        restart = frameCount;
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
      symRtn.easer.setEaseByFactor(1.1, fTime, 100);
      break;
      case('s'):
      symmetry = symmetry / 1.1;
      symRtn.easer.setEaseByFactor(1/1.1, fTime, 100);
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
      sizeRtn.easer.setEaseByTarget(fibPow, fTime, 100);
      break;
      case('f'):
      fibPow = fibPow - 1;
      sizeRtn.easer.setEaseByTarget(fibPow, fTime, 100);
      break;
      case('t'):
      rep = rep + 1;
      break;
      case('g'):
      rep = max(1, rep - 1);
      break;
      case('y'):
      rainbowRate *= 1.1;
      rainbowRtn.easer.setEaseByTarget(rainbowRate, fTime, 100);
      break;
      case('h'):
      rainbowRate *= 0.9;
      rainbowRtn.easer.setEaseByTarget(rainbowRate, fTime, 100);
      break;
      case('u'):
      tf = tf * 1.1;
      tfRtn.easer.setEaseByTarget(tf, fTime, 100);
      break;
      case('j'):
      tf = tf / 1.1;
      tfRtn.easer.setEaseByTarget(tf, fTime, 100);
      break;
      case('i'):
      repShift = repShift * 1.1;
      rShiftRtn.easer.setEaseByTarget(repShift, fTime, 100);
      break;
      case('k'):
      repShift = repShift * 0.9;
      rShiftRtn.easer.setEaseByTarget(repShift, fTime, 100);
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
      // loadParameters(342);
      // t1Hit = false;
      // t2Hit = false;
      // t3Hit = false;
      // t4Hit = false;
      // t5Hit = false;
      // t6Hit = false;
      // t7Hit = false;
      // t8Hit = false;
      // t9Hit = false;
      // t10Hit = false;
      // tStart2Hit = false;
      // t11Hit = false;
      // t12Hit = false;
      // t13Hit = false;
      // t14Hit = false;
      // t15Hit = false;
      // starting = true;
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
        rfacRtn.setMode(15);
      break;  
      case('}'):
        growthOn = true;
        mSize = false;
        symRtn.enabled = false;
        symRtn.setMode(6);
        rfacRtn.setMode(14);
      break;    
      case('B'):
      myBrush = (myBrush + 1) % 11;
      break;
      case('+'):
        asEasers();
        break;
      case(' '):
        //fftOn = !fftOn;
        println("!!! " + (t46 - fTime));
        break;
      case('?'):
        if (mode == "live"){
            restart = millis() - int(tStart2 * 1000/60.0);
        } else {
          restart = frameCount - int(tStart2);
        }
        // tStart2Hit = false;
        // doStart2();
        break;
      case('/'):
        //tStart3Hit = false;
        //doStart3();
        //if (mode == "live"){
        //    restart = millis() - int(tStart3 * 1000/60.0);
        //} else {
        //  restart = frameCount - int(tStart3);
        //}
        //break;
        //tStart3Hit = false;
        // if (mode == "live"){
        //     restart = millis() - int(t29 * 1000/60.0);
        // } else {
        //   restart = frameCount - int(t29);
        // }
        // doT29();
        blerp();
        break;
      case('|'):
        if (mode == "live"){
            restart = millis() - int(t31 * 1000/60.0);
        } else {
          restart = frameCount - int(t46);
        }
        //t31Hit = false;
        //doT31();
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
  int tab = (width-605)/2;
  int x = tab;
  //int y = height - 150;
  int y = height - 30;
  int count = 0;
  pushStyle();  
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  
  
  if (frameOn) {
    pushStyle();
    fill(0,0,0);
    noStroke();
    float h = height/2.0;
    float r = 2 * h / sqrt(3);
    float yyy;
    float xxx;
    float th = 2*PI/6.0;
    beginShape();
    vertex(0,0,0);
    vertex(0, height, 0);
    for (int i=2; i<5; i++){
      yyy = (height/2.0) + r * sin(i*th);
      xxx = (width/2.0) + r * cos(i*th);
      vertex(xxx, yyy, 0);
    }
    endShape(CLOSE);
    beginShape();
    vertex(width, height, 0);
    vertex(width,0,0);
    for (int i=5; i<8; i++){
      yyy = (height/2.0) + r * sin(i*th);
      xxx = (width/2.0) + r * cos(i*th);
      vertex(xxx, yyy, 0);
    }
    endShape(CLOSE);
    popStyle();
  }
  
  
  
  textMode(MODEL);
  rectMode(CORNER);
  fill(170, 0, 0);
  noStroke();
  rect(x-15, y-15, 635, 20);
  fill(170, 0, 255);
  textFont(mono);
  String params = "  ";
  //params += " " + int(frameRate) + " ";
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
    params += "   " + padString(str(myPalette.current), 3);
    
  } else {
    params += " " + padString(str(int(rfac)), 7);
    //params += " " + padString(str(revs), 7);
    params += " " + padString(fmtStr(symmetry, 3), 7);
    params += " " + padString(str(segments), 7);
    params += " " + padString(fmtStr(fibPow, 3), 7);
    params += " " + padString(str(rep), 7);
    params += " " + padString(fmtStr(rainbowRate, 3), 7);
    params += " " + padString(fmtStr(tf, 3), 7);
    params += " " + padString(fmtStr(repShift, 3), 7);
    //params += " " + rfacInit;
    //params += " " + padString(fmtStr(rfacDt, 3), 7);
    params += " " + padString(fmtStr(rrzRtn.easer.getValue(fTime), 3), 7);
    params += " " + padString(fmtStr(rrxRtn.easer.getValue(fTime), 3), 7);
    params += " " + padString(str(tn), 7);
    //params += " " + padString(fmtStr(rotRateZ, 3), 7);
    //params += " " + padString(fmtStr(rotRateX, 3), 7);

  }
  text(params, x, y); 
  
  

  hint(ENABLE_DEPTH_TEST);
  popStyle();
}


//float tEnd = 2*60*60;
//float t0 = 0.25*tEnd;
//float t1 = t0 + 2*60;
//float t2 = t1 + 10*60;
//float t3 = 0.5 * tEnd;
//float t4 = 0.7 * tEnd;
//float t5 = 0.77 * tEnd;
//float t6 = 0.8 * tEnd;
//float t7 = 0.83 * tEnd;
//float t8 =  0.87 * tEnd;
//float t9 =  0.9 * tEnd;
//float t10 =  0.95 * tEnd;
//boolean t1Hit = false;
//boolean t2Hit = false;
//boolean t3Hit = false;
//boolean t4Hit = false;
//boolean t5Hit = false;
//boolean t6Hit = false;
//boolean t7Hit = false;
//boolean t8Hit = false;
//boolean t9Hit = false;
//boolean t10Hit = false;

//if (starting) {
//    starting = false;
//    println(millis()/1000.);
//    println(restart);
//    println(mode);
//    symRtn.easer.setValue(symmetry);
//    segRtn.easer.setValue(segments);
//    sizeRtn.easer.setValue(fibPow);
//    repRtn.easer.setValue(rep);
//    rainbowRtn.easer.setValue(rainbowRate);
//    tfRtn.easer.setValue(3);
//    rShiftRtn.easer.setValue(repShift);
//    rrzRtn.easer.setValue(-xmag);
//    rrxRtn.easer.setValue(-ymag);
//    rfacRtn.easer.setValue(1);
    
    
//    symRtn.easer.setValue(900);
//    symRtn.easer.setEaseMode(2);
//    symRtn.easer.setEaseByTarget(0, fTime, t0 - 1);    
//    rfacRtn.easer.setValue(1);
//    rfacRtn.easer.setEaseMode(0);
//    rfacRtn.easer.setEaseByTarget(1200, fTime, t0 - 1);    
//    rrzRtn.easer.setEaseMode(0);
//    rrzRtn.easer.setEaseByTarget(6*PI, fTime, tEnd);
//  }
  
//  if (fTime >= t1 && !t1Hit) {
//    t1Hit = true;
//    println("t1");
//    symRtn.easer.setEaseMode(8);
//    symRtn.easer.setEaseByTarget(5, fTime, t2 - t1);  
//    rfacRtn.easer.setEaseByTarget(3000*6, fTime, tEnd);    
//  }
  
//  if (fTime >= t2 && !t2Hit) {
//    t2Hit = true;
//    println("t2");
//    symRtn.easer.setEaseMode(3);
//    symRtn.easer.setEaseByTarget(1, fTime, t3 - t2);  
    
//    tfRtn.easer.setEaseMode(3);
//    tfRtn.easer.setEaseByTarget(17, fTime, t3 - t2);
//  }
  
//  if (fTime >= t3 && !t3Hit) {
//    t3Hit = true;
//    println("t3");
//    rShiftRtn.easer.setEaseMode(2);
//    rShiftRtn.easer.setEaseByTarget(255, fTime, tEnd - t3);
//  }
  
//  if (fTime >= t4 && !t4Hit) {
//    t4Hit = true;
//    println("t4");
//    symRtn.easer.setEaseMode(10);
//    symRtn.easer.setEaseByTarget(20, fTime, 0.07*tEnd);
//  }
  
//  if (fTime >= t5 && !t5Hit) {
//    t5Hit = true;
//    println("t5");
//    rfacRtn.easer.setEaseMode(3);
//    rfacRtn.easer.setEaseByTarget(100, fTime, t6 - t5);
//    symRtn.easer.setEaseMode(3);
//    symRtn.easer.setEaseByTarget(1, fTime, t6 - t5);
//  }
  
//  if (fTime >= t6 && !t6Hit) {
//    t6Hit = true;
//    println("t6");
//    rfacRtn.easer.setEaseMode(0);
//    rfacRtn.easer.setEaseByTarget(1000, fTime, t7 - t6);
//    symRtn.easer.setEaseMode(0);
//    symRtn.easer.setEaseByTarget(10, fTime, t7 - t6);
//  }
  
//  if (fTime >= t7 && !t7Hit) {
//    t7Hit = true;
//    println("t7");
//    rfacRtn.easer.setEaseMode(0);
//    rfacRtn.easer.setEaseByTarget(100, fTime, t8 - t7);
//    symRtn.easer.setEaseMode(0);
//    symRtn.easer.setEaseByTarget(40, fTime, t8 - t7);
//  }
  
//  if (fTime >= t8 && !t8Hit) {
//    t8Hit = true;
//    println("t8");
//    rrzRtn.easer.setEaseMode(1);
//    rrzRtn.easer.setEaseByTarget(12*PI, fTime, tEnd - t8);
//    tfRtn.easer.setEaseMode(0);
//    tfRtn.easer.setEaseByTarget(255, fTime, tEnd-t8);
//    rShiftRtn.easer.setEaseMode(3);
//    rShiftRtn.easer.setEaseByTarget(0.001, fTime, tEnd-t8);
//  }
  
//  if (fTime >= t9 && !t9Hit) {
//    t9Hit = true;
//    println("t9");
//    rfacRtn.easer.setEaseMode(1);
//    rfacRtn.easer.setEaseByTarget(2200, fTime, tEnd - t9);
//    symRtn.easer.setEaseMode(3);
//    symRtn.easer.setEaseByTarget(0, fTime, tEnd - t9);
//  }
  
    
  
//  if (fTime >= tEnd){
//    //exit();
//  }

//an artist statement is a self reflection
