int rep, segments, fTime, fibPow, rainbowRate, revs;
float fib = 1.61803398875;
float symmetry, tf, scl, scaleInc;
color c1, c2;
boolean scalingOn, rotateOn; 

void setup() {
  //size(1700, 1100);
  fullScreen(P2D, SPAN);
  background(255, 255, 255);
  noCursor();
  symmetry = 6;
  segments = 13*6;
  rep = 6;
  fibPow = 6;
  scl = 1;
  rainbowRate = 1;
  tf = 0.3;
  scalingOn = false;
  rotateOn = true;
  scaleInc = 0.001;
  revs = 5;
  
  colorMode(HSB, 255);
  rectMode(CENTER);
}

void draw() {
  //background(170, 0, 255);
  if (scalingOn) {
    scl = scl + scaleInc;
    scale(scl);
  }
  fTime = millis()*60/1000;
  //float rfac = fTime*2;
  
  float rfac = 1000;
  pushMatrix();
  translate(width/2.0, height/2.0);
  //scale(scl);
  if (rotateOn) {
    rotate(-fTime*0.1*PI/360);
  }
  for (int n=0; n<rep; n++) {
  //for (int n=0; n<2; n++) {
    rotate(2*PI/rep);
    int hue = int((n*5+(fTime / rainbowRate)) % 255);
    for (int t=0;t<segments*revs;t++) {
      c1 = color((hue+(t*tf))%255, 252, 252, 250);
      c2 = color((hue+(t*tf)+(256/2))%255, 252, 252, 250);
      float theta = t * 2 * PI / (segments);
      float theta2 = 2 * PI - theta;
      float r =  rfac * pow(fib, (-1 * symmetry * t/float(segments)));
      float s = r/pow(fib, fibPow);
      //if (r<2500){
        fill(c1);
        stroke(c2);
        ellipse(r*sin(theta), r*cos(theta), s, s);
        //rect(r*sin(theta), r*cos(theta), s, s);
        fill(c2);
        stroke(c1);
        ellipse(r*sin(theta2), r*cos(theta2), s, s);
        //rect(r*sin(theta2), r*cos(theta2), s, s);
      //}
    }
  }
  popMatrix();
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
      revs = revs - 1;
      break;
    case('w'):
      symmetry = symmetry * 1.2;
      break;
    case('s'):
      symmetry = symmetry * 0.8;
      break;
    case('e'):
      segments = segments + 1;
      break;
    case('d'):
      segments = segments - 1;
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
      rep = rep - 1;
      break;
    case('y'):
      tf = tf * 1.1;
      break;
    case('h'):
      tf = tf * 0.9;
      break;
    case('u'):
      rainbowRate += 1;
      break;
    case('j'):
      rainbowRate -= 1;
      break;
  }
  
  
}
