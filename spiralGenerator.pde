int symmetry, rep, segments, fTime, fibPow, rainbowRate;
float fib = 1.61803398875;
float tf, scl;
color c1, c2;

void setup() {
  //size(1700, 1100);
  fullScreen(P2D, SPAN);
  background(255, 255, 255);
  noCursor();
  symmetry = 6;
  segments = 6;
  rep = 1;
  fibPow = 3;
  scl = 1;
  rainbowRate = 1;
  tf = 1;
  
  colorMode(HSB, 255);
  rectMode(CENTER);
}

void draw() {
//   scl = scl + 0.00004;
//   scale(scl);
  fTime = millis()*60/1000;
  float rfac = fTime*2;
  pushMatrix();
  translate(width/2.0, height/2.0);
  //scale(scl);
  //rotate(-fTime*0.1*PI/360);
  for (int n=0; n<rep; n++) {
  //for (int n=0; n<2; n++) {
    // rotate(2*PI/rep);
    int hue = int((n*5+(fTime / rainbowRate)) % 255);
    for (int t=0;t<symmetry*segments*3;t++) {
      c1 = color((hue+(t*tf))%255, 252, 252, 50);
      c2 = color((hue+(t*tf)+(256/2))%255, 252, 252, 0);
      float theta = t * 2 * PI / (symmetry * segments);
      float theta2 = 2 * PI - theta;
      float r =  rfac * pow(fib, (-1 * t/float(segments)));
      float s = r/pow(fib, fibPow);
      //if (r<2500){
        fill(c1);
        stroke(c2);
        ellipse(r*sin(theta), r*cos(theta), s, s);
        //rect(r*sin(theta), r*cos(theta), s, s);
        //fill(c2);
        //stroke(c1);
        //ellipse(r*sin(theta2), r*cos(theta2), s, s);
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
  }
}
