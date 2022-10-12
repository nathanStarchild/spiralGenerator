public class Recorder {
  PApplet app;
  boolean recording;
  int n;
  int count;
  String title;
  int startFrame;
  int snapCount;
  int loopFrames;
  int df;
  PGraphics theG;
    
  
  
  //Param(PApplet papp, float startVal, Oscillator osc, NoiseLoop nl) {
  Recorder(PApplet papp, PGraphics pg, int lf) {
    recording = false;
    n = 0;
    count = 0;
    app = papp;    
    title = "recorded";
    startFrame = 0;
    theG = pg;
    snapCount = 0;
    loopFrames = lf;
    df = 1;
  }
  
  public void startRecording() {
    count += 1;
    n = 0;
    recording = true;
    startFrame = app.frameCount;
    df = 0;
    println("start Recording " + title + "" + count + "/frame" + nf(n, 5) + ".jpg");
  }
  
  public void update() {    
    if (recording) {
      theG.save("" + title + "" + count + "/frame" + nf(n, 5) + ".jpg");
      n++;
    }
    if ( recording && app.frameCount >= startFrame + loopFrames + 1) {
      recording = false;
      println("done recording");
      exit();
    }
    // if ( recording && app.frameCount == startFrame + loopFrames - 15*30) {
    //   flipIt(1);
    //   println("bringitback");
    // }
    // if ( true && (app.frameCount - startFrame) % (loopFrames/4.0) == 0) {
    // if ( recording && (app.frameCount - startFrame) % (loopFrames/6.) == 0) {
      
    //   flipIt(df);
    //   df++;
    //   println("flipIt");
    // }
  }

  public void snapshot() {
    theG.save("snap" + nf(snapCount, 3) + ".png" );
    snapCount++;
  }
}
