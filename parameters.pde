void flipIt(int n) {
  if (n == 0) {
    // tfRtn.easer.setEaseMode(1);
    // tfRtn.easer.setEaseByTarget(89.6, fTime, loopEvery/4.);
  } else if (n == 1) {
    // rShiftRtn.easer.setEaseMode(0);
    // rShiftRtn.easer.setEaseByTarget(256, fTime, loopEvery/2.);
    // tfRtn.easer.setEaseByTarget(0, fTime, loopEvery/2.);

    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
  } else if (n == 2) {
    // tfRtn.easer.setEaseMode(1);
    // tfRtn.easer.setEaseByTarget(256/3.333, fTime, loopEvery/4.);
  }
  // rf1 = rf2;
  // if (n==0){
  //   loopGrowths = 2;
  // } else if (n==1) {
  //   loopGrowths = 3;
  // } else if (n==2) {
  //   loopGrowths = 5;
  // } else if (n==3) {
  //   loopGrowths = 9;
  // } else if (n==4) {
  //   loopGrowths = 15;
  // }
  rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
  // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/6.);

    tfRtn.easer.setEaseMode(3); 
    tfRtn.easer.setEaseByTarget(0, fTime, 30*10);
    rShiftRtn.easer.setEaseMode(3); 
    rShiftRtn.easer.setEaseByTarget(0, fTime, 30*10);
}

void loadParameters(int n) {
  //eep what a mess. These should all be saved in some file format...
  //if (mode == "record") {
  //  restart = 0;
  //} else if (mode == "live") {
  //  restart = millis();
  //}
  
  if (n == 342) { //greenLightProject
    revs = 22;//?
    symmetry = 5;//0.74;
    segments = 24;
    fibPow = 2;
    rep = 6;
    scl = 1;
    //loops every 300 frames
    loopEvery = 60*30;
    rainbowRate = 1.3;//0.0024?
    tf = 5.333;
    repShift = 0.00163;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 3;
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
    alphas1 = 0;
    alphaf2 = 255;
    alphas2 = 0;
    cShifts1 = 256/7;
    cShifts2 = 256/8;
    cShiftf2 = (256/7) - (256/8);

    symRtn = new ParamRoutine(true, 342, 59*30);
    segRtn = new ParamRoutine(true, 342, 97);
    sizeRtn = new ParamRoutine(true, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(true, 342, 1);
    tfRtn = new ParamRoutine(true, 342, 150);
    rShiftRtn = new ParamRoutine(true, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = true;
    frameOn = true;
    parameterDisplayOn = true;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    
  
  } else if (n==2000) { //heartless machine Clip
    revs = 3;
    symmetry = 4;//0.74;
    segments = 10;
    fibPow = 6.287;
    rep = 6;
    scl = 1;
    //loops every 300 frames
    loopEvery = 34*30;
    rainbowRate = 1;//0.0024?
    fRate = 1;
    tf = 11.333;
    repShift = 9.740001;
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
    myBrush = 6;
    strWeight = 1;
    growthOn = true;
    nVids = 6;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 0;
    alphaf2 = 255;
    alphas2 = 0;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(true, 1, 11.872);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(false, 3, 85);
    rShiftRtn = new ParamRoutine(false, 2, 31);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);

    rfacRtn.easer.setValue(rfacInit);
    rrxRtn.easer.setValue(0);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    withAlpha = true;
    parameterDisplayOn = false;

    // blendMode(SCREEN);
  } else if (n==3000) { //halloween
    revs = 12;
    symmetry = 4;//0.74;
    segments = 10;
    fibPow = 6.287;
    rep = 1;
    scl = 1;
    //loops every 300 frames
    loopEvery = 34*30;
    rainbowRate = 1;//0.0024?
    fRate = 1;
    tf = 11.333;
    repShift = 9.740001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 800;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;
    growthOn = true;
    nVids = 6;


    loopGrowths = 1;
    int nTurns = 1;
    loopEvery = 300;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 0;
    alphaf2 = 255;
    alphas2 = 0;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(true, 1, 11.872);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(false, 3, 85);
    rShiftRtn = new ParamRoutine(false, 2, 31);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);

    rf1 = rfacInit;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    // rrxRtn.easer.setValue(2*PI);
    rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(99); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    withAlpha = true;
    parameterDisplayOn = false;
    loopEvery = 35*30;

    playVideo2 = true;
    loadImagesHal();
  } else if (n==3001) { //halloween bats
    revs = 5;
    symmetry = 1.6;//0.74;
    segments = 20;
    fibPow = 5.6;
    rep = 2;
    scl = 1;
    //loops every 300 frames
    loopEvery = 34*30;
    rainbowRate = 3.6;//0.0024?
    fRate = 1;
    tf = 16.6;
    repShift = 126.740001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 3;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;
    growthOn = true;
    nVids = 6;


    loopGrowths = 1;
    int nTurns = 1;
    loopEvery = 160;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 0;
    alphaf2 = 255;
    alphas2 = 0;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 1, 11.872);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(false, 3, 85);
    rShiftRtn = new ParamRoutine(false, 2, 31);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);

    rf1 = rfacInit;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, 2*60*30);
    rrxRtn.easer.setValue(2*PI);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(99); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    withAlpha = true;
    parameterDisplayOn = false;
    
    playVideo2 = true;
    loadImagesHal();
  } else if (n==3002) { //halloween death
    revs = 12;
    symmetry = 2.13;//0.74;
    segments = 3;
    fibPow = 3.1;
    rep = 2;
    scl = 1;
    //loops every 300 frames
    loopEvery = 34*30;
    rainbowRate = 3.6;//0.0024?
    fRate = 1;
    tf = 16.6;
    repShift = 126.740001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 300;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;
    growthOn = true;
    nVids = 6;


    loopGrowths = 1;
    int nTurns = 1;
    loopEvery = 660;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 0;
    alphaf2 = 255;
    alphas2 = 0;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(false, 1, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 1, 11.872);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 342, 85);
    rShiftRtn = new ParamRoutine(true, 342, 31);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);

    rf1 = rfacInit;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, 2*60*30);
    rrxRtn.easer.setValue(2*PI);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(99); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(3); 
    tfRtn.easer.setEaseByTarget(tf, fTime, 30*10);
    rShiftRtn.easer.setValue(0);
    rShiftRtn.easer.setEaseMode(3); 
    rShiftRtn.easer.setEaseByTarget(repShift, fTime, 30*10);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    withAlpha = true;
    parameterDisplayOn = false;
    
    playVideo2 = true;
    loadImagesHal();
  } else if (n==3003) { //halloween final
    revs = 16;
    symmetry = 2.13;//0.74;
    segments = 7;
    fibPow = 3.1;
    rep = 4;
    scl = 1;
    //loops every 300 frames
    loopEvery = 34*30;
    rainbowRate = 3.6;//0.0024?
    fRate = 1;
    tf = 16.6;
    repShift = 126.740001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 3;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;
    growthOn = true;
    nVids = 6;
    frameRate(30);


    loopGrowths = 1;
    int nTurns = 3;
    loopEvery = 160;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 0;
    alphaf2 = 255;
    alphas2 = 0;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(true, 342, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 1, 11.872);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 342, 85);
    rShiftRtn = new ParamRoutine(true, 342, 31);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);

    rf1 = rfacInit;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    symRtn.easer.setValue(9.63); 
    symRtn.easer.setEaseMode(2); 
    symRtn.easer.setEaseByTarget(1, fTime, 2*60*30);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, 2*60*30);
    rrxRtn.easer.setValue(2*PI);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(99); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    tfRtn.easer.setValue(15);
    tfRtn.easer.setEaseMode(3); 
    tfRtn.easer.setEaseByTarget(27, fTime, 2*60*30);
    rShiftRtn.easer.setValue(10);
    rShiftRtn.easer.setEaseMode(3); 
    rShiftRtn.easer.setEaseByTarget(30, fTime, 2*60*30);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    withAlpha = true;
    parameterDisplayOn = false;
    
    playVideo2 = true;
    // loadImagesHal();
  } else if (n==3004) { //halloween final insta
    revs = 5;
    symmetry = 2.13;//0.74;
    segments = 7;
    fibPow = 2.8;
    rep = 4;
    scl = 1;
    //loops every 300 frames
    loopEvery = 36*30;
    rainbowRate = 3.6;//0.0024?
    fRate = 1;
    tf = 16.6;
    repShift = 126.740001;
    scalingOn = false;
    rotateZOn = true;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,12);
    rfacInit = 90;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;
    growthOn = true;
    nVids = 6;
    frameRate(30);


    loopGrowths = 1;
    int nTurns = 3;
    int rfacLoops = 160;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 255;
    alphas1 = 0;
    alphaf2 = 255;
    alphas2 = 0;
    cShifts1 = 256/12;
    cShifts2 = 3*256/12;
    cShiftf2 = 256/6;

    symRtn = new ParamRoutine(true, 342, 32.775);
    segRtn = new ParamRoutine(false, 0, 1);
    sizeRtn = new ParamRoutine(false, 1, 11.872);
    repRtn = new ParamRoutine(false, 0, 1);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 342, 85);
    rShiftRtn = new ParamRoutine(true, 342, 31);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);

    rf1 = rfacInit;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    symRtn.easer.setValue(6); 
    symRtn.easer.setEaseMode(2); 
    symRtn.easer.setEaseByTarget(1.7, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery*3);
    rrxRtn.easer.setValue(2*PI);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(300);
    rfacRtn.easer.setEaseMode(1); 
    rfacRtn.easer.setEaseByTarget(36000, fTime, loopEvery);
    tfRtn.easer.setValue(32);
    tfRtn.easer.setEaseMode(3); 
    tfRtn.easer.setEaseByTarget(37, fTime, loopEvery);
    rShiftRtn.easer.setValue(25);
    rShiftRtn.easer.setEaseMode(3); 
    rShiftRtn.easer.setEaseByTarget(30, fTime, loopEvery);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    withAlpha = true;
    parameterDisplayOn = false;
    
    playVideo2 = true;
    // loadImagesHal();
  } else if (n == 1349) { //...
    revs = 7;//?
    symmetry = 4;//0.74;
    segments = 16;
    fibPow = 6.6;
    rep = 4;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 2;
    int nTurns = 1;
    loopEvery = 245;
    tf = 2.5;
    repShift = 255/2;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    fRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = false;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 12;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =254;
    alphas1 = 60;
    alphaf2 = 254;
    alphas2 = 0;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(true, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    // loopGrowths = 1;
    rf1 = 400;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    rrxRtn.easer.setValue(0);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    // rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(3); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    symRtn.easer.setValue(4);
    symRtn.easer.setEaseMode(3); 
    symRtn.easer.setEaseByTarget(4, fTime, loopEvery);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(30);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 1348) { //...
    revs = 6;//?
    symmetry = 4.4;//0.74;
    segments = 45;
    fibPow = 9.6;
    rep = 9;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 2;
    int nTurns = 1;
    loopEvery = 256;
    tf = 17.8;
    repShift = 29.001;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    fRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = false;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 12;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =254;
    alphas1 = 0;
    alphaf2 = 254;
    alphas2 = 0;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    // loopGrowths = 1;
    rf1 = 590;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    rrxRtn.easer.setValue(0);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    // rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(3); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    symRtn.easer.setValue(4);
    symRtn.easer.setEaseMode(3); 
    symRtn.easer.setEaseByTarget(4, fTime, loopEvery);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(0);
    blendMode(SCREEN);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 1347) { //...
    revs = 2;//?
    symmetry = 4;//0.74;
    segments = 16;
    fibPow = 6.6;
    rep = 4;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 2;
    int nTurns = 1;
    loopEvery = 256;
    tf = 1.9;
    repShift = 255/2;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    fRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = false;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 12;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =254;
    alphas1 = 60;
    alphaf2 = 254;
    alphas2 = 0;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(true, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    // loopGrowths = 1;
    rf1 = 300;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    rrxRtn.easer.setValue(0);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    // rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setValue(10);
    rfacRtn.easer.setEaseMode(3); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    symRtn.easer.setValue(4);
    symRtn.easer.setEaseMode(3); 
    symRtn.easer.setEaseByTarget(4, fTime, loopEvery);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(30);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 1346) { //...
    revs = 16;//?
    symmetry = 1.74;//0.74;
    segments = 19;
    fibPow = 6.;
    rep = 4;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 1;
    int nTurns = 1;
    loopEvery = 256;
    tf = 1.9;
    repShift = 255/2;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    fRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = false;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 12;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =254;
    alphas1 = 60;
    alphaf2 = 254;
    alphas2 = 0;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    loopGrowths = 1;
    rf1 = 400;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setValue(0);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(0); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(15);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 1345) { //...
    revs = 16;//?
    symmetry = 1.74;//0.74;
    segments = 7;
    fibPow = 3.6;
    rep = 9;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 1;
    int nTurns = 1;
    loopEvery = 256;
    tf = 256/5.5;
    repShift = (55.69*9/15.)/1.1;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (7.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    fRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = false;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =254;
    alphas1 = 60;
    alphaf2 = 254;
    alphas2 = 254;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    loopGrowths = 1;
    rf1 = 400;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    rrxRtn.easer.setValue(0);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(0); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(30);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 343) { //monegros
    revs = 40;//?
    symmetry = 6;//0.74;
    segments = 20;
    fibPow = 4.6;
    rep = 7;
    scl = 1;
    //loops every 300 frames
    loopEvery = 1091;
    rainbowRate = loopEvery / (20 * 256.0);;//0.0024?
    tf = 17;
    repShift = 0.001;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = false;
    growthOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 = 90;
    alphas1 = 40;
    alphaf2 = 90;
    alphas2 = 40;
    cShifts1 = 256/7;
    cShifts2 = 256/8;
    cShiftf2 = (256/7) - (256/8);

    symRtn = new ParamRoutine(true, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(true, 342, 150);
    rShiftRtn = new ParamRoutine(true, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);


    symRtn.easer.setValue(0.383); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rrxRtn.easer.setValue(0);
    rfacRtn.easer.setValue(320);
    // rfacRtn.easer.setEaseMode(2); 
    // rfacRtn.easer.setEaseByTarget(1000, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);
    
    myPalette.setPalette(14);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 344) { //twist, zoom, repeat
    revs = 40;//?
    symmetry = 0.5;//0.74;
    segments = 35;
    fibPow = 9;
    rep = 17;
    scl = 1;
    //loops every 300 frames
    int loopGrowths = 1;
    int nTurns = 1;
    loopEvery = 113;
    tf = 134.639;
    repShift = 0.867;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =190;
    alphas1 = 60;
    alphaf2 = 190;
    alphas2 = 60;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);

    rf2 = 9240.0;
    rf1 = rf2 * pow(fib, -1* loopGrowths *symmetry);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(3);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery/2.);
    rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(3); 
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256/2., fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 8847) { //...
    revs = 12;//?
    symmetry = 4;//0.74;
    segments = 120;
    fibPow = 5.6;
    rep = 12;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 1;
    int nTurns = 3;
    loopEvery = 300;
    // tf = 256/5.5;
    tf = 34.55;
    repShift = 0.001;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (6.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 10;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =90;
    alphas1 = 60;
    alphaf2 = 90;
    alphas2 = 60;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    // loopGrowths = 1;
    // int realrfInit = 90;
    // float realrf2 = realrfInit / pow(fib, -1* loopGrowths *symmetry);
    // rf1 = realrfInit * pow(fib, -1* loopGrowths *symmetry);
    // rfacInit = int(rf1);
    rf1 = rfacInit;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    rf3 = rf2 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    rrxRtn.easer.setValue(2*PI);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(99); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(1);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
  } else if (n == 8848) { //constant grow
    revs = 12;//?
    symmetry = 4;//0.74;
    segments = 120;
    fibPow = 5.6;
    rep = 12;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 1;
    int nTurns = 1;
    loopEvery = 300;
    // tf = 256/5.5;
    tf = 1.8;
    repShift = 7.1;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (2.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 10;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =90;
    alphas1 = 60;
    alphaf2 = 90;
    alphas2 = 60;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    // loopGrowths = 1;
    // int realrfInit = 90;
    // float realrf2 = realrfInit / pow(fib, -1* loopGrowths *symmetry);
    // rf1 = realrfInit * pow(fib, -1* loopGrowths *symmetry);
    // rfacInit = int(rf1);
    rf1 = rfacInit;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    rf3 = rf2 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    // rrxRtn.easer.setValue(2*PI);
    rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(99); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(10);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
  } else if (n == 345) { //...
    revs = 160;//?
    symmetry = 0.74;//0.74;
    segments = 20;
    fibPow = 4.6;
    rep = 14;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 1+2+3+5+9+15;
    int nTurns = 6*3;
    loopEvery = 122*6;
    tf = 256/5.5;
    repShift = 55.69;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (7.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = false;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =90;
    alphas1 = 60;
    alphaf2 = 90;
    alphas2 = 60;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    loopGrowths = 1;
    rf1 = 400;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    rrxRtn.easer.setValue(2*PI - PI/6.);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(rf1);
    rfacRtn.easer.setEaseMode(3); 
    rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/6.);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(16);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n == 346) { //...
    revs = 160;//?
    // symmetry = 0.84;//0.74;
    symmetry = 0.392;//0.74;
    segments = 16;
    fibPow = 5.6;
    rep = 9;
    scl = 1;
    //loops every 300 frames
    loopGrowths = 1+2+3+5+9+15;
    int nTurns = 6*3;
    loopEvery = 122*6;
    tf = 114.701;
    repShift = 0.001;
    // rainbowRate = float(loopEvery) / (5.*256.0);;//0.0024?
    println((loopGrowths * segments * tf) % 256);
    rainbowRate = loopEvery / (7.0 * 256 - (loopGrowths * segments * tf + nTurns * repShift) % 256);
    // tf = (6)*256.0/segments;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 300;
    rfac = rfacInit;
    rotRateZ = 0.12;
    rotRateX = 0.318;
    clockwiseOn = true;
    counterClockwiseOn = true;
    growthOn = false;
    bgOn = true;
    myBrush = 6;
    strWeight = 1;

    satf1 = 252;
    sats1 = 252;
    satf2 = 252;
    sats2 = 252;
    brif1 = 252;
    bris1 = 252;
    brif2 = 252;
    bris2 = 252;
    alphaf1 =140;
    alphas1 = 140;
    alphaf2 = 140;
    alphas2 = 140;
    cShifts1 = 0;
    cShifts2 = 0;
    cShiftf2 = 0;

    symRtn = new ParamRoutine(false, 342, 59*30);
    segRtn = new ParamRoutine(false, 342, 97);
    sizeRtn = new ParamRoutine(false, 342, 14.872);
    repRtn = new ParamRoutine(false, 342, 156);
    rainbowRtn = new ParamRoutine(false, 342, 1);
    tfRtn = new ParamRoutine(false, 342, 150);
    rShiftRtn = new ParamRoutine(false, 342, 11);
    rrzRtn = new ParamRoutine(true, 342, 1);
    rrxRtn = new ParamRoutine(true, 342, 20);
    rfacRtn = new ParamRoutine(true, 342, 20);
    loopGrowths = 1;
    rf1 = 400;
    rf2 = rf1 / pow(fib, -1* loopGrowths *symmetry);
    // println(rf2);


    // symRtn.easer.setValue(0.63); 
    // symRtn.easer.setEaseMode(2); 
    // symRtn.easer.setEaseByTarget(0.033, fTime, loopEvery);
    rrzRtn.easer.setValue(0);
    // rrzRtn.easer.setEaseMode(0);
    // rrzRtn.easer.setEaseByTarget(nTurns*2*PI/rep, fTime, loopEvery);
    // rrxRtn.easer.setValue(2*PI - PI/6.);
    rrxRtn.easer.setValue(0);
    // rrxRtn.easer.setEaseMode(0);
    // rrxRtn.easer.setEaseByTarget(2*PI, fTime, loopEvery);
    rfacRtn.easer.setValue(4700);
    // rfacRtn.easer.setEaseMode(3); 
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/6.);
    // rShiftRtn.easer.setValue(256/3.3333);
    rShiftRtn.easer.setValue(256);
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(0, fTime, loopEvery);
    // rShiftRtn.easer.setEaseByTarget(2*256/3., fTime, loopEvery/2.);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256, fTime, loopEvery);
    // tfRtn.easer.setEaseByTarget(256/6., fTime, loopEvery/2.);

    //flipIt n==2
    // rfacRtn.easer.setEaseByTarget(rf2, fTime, loopEvery/2.);
    
    myPalette.setPalette(0);
    
    mode = "record";
    goTime = false;
    frameOn = false;
    parameterDisplayOn = false;
    showSpiral = true;
    playVideo1 = false;
    playVideo2 = false;
    frameIncrement = false;
    restart = 0;
    
  } else if (n==0) {
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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
    
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
    rfacInit = 200;
    rfac = rfacInit;
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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    // rfacRtn.easer.setValue(rfacInit);
    
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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
    
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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
    
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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);

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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
    
    
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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
  
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
    rfacDt = pow(((rfacInit*(pow(fib, symmetry) -1))/(pow(fr1+loopEvery, segments)-(pow(fib, symmetry)*pow(fr1, segments)))), 1/float(segments));
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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
    
    
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
    growthOn = true;

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
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
    
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
    tfRtn = new ParamRoutine(true, 55, 328);
    rShiftRtn = new ParamRoutine(false, 2, 11);
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    rfacRtn = new ParamRoutine(true, 14, rfacDt);
    rfacRtn.easer.setValue(rfacInit);
    
    myPalette.setPalette(14);
    
    mode = "live";
    goTime = false;
    
  }  else if (n==981) { //why do you ask
    revs = 33;//?
    symmetry = 5;//0.74;
    segments = 84;
    fibPow = 6.287;
    rep = 6;
    scl = 1;
    //loops every 300 frames
    loopEvery = 60*30;
    rainbowRate = 12;//0.0024?
    tf = 5.333;
    repShift = 0.00163;
    scalingOn = false;
    rotateZOn = false;
    rotateXOn = false;
    scaleInc = 0.001;
    rfacDt = 1/pow(fib,7);
    rfacInit = 1;
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

    symRtn = new ParamRoutine(true, 5, 59*30);
    segRtn = new ParamRoutine(false, 2, 97);
    sizeRtn = new ParamRoutine(false, 1, 14.872);
    repRtn = new ParamRoutine(false, 1, 156);
    rainbowRtn = new ParamRoutine(false, 0, 1);
    tfRtn = new ParamRoutine(true, 10, 60);
    rShiftRtn = new ParamRoutine(false, 2, 11);
    rrzRtn = new ParamRoutine(false, 0, 1);
    rrxRtn = new ParamRoutine(false, 1, 20);
    
    myPalette.setPalette(1);
    
    //mode = "live";
    goTime = false;
    
  }
  setInits();
  
}

void setInits(){

    symRtn.initialFloat = symmetry;
    segRtn.initialInt = segments;
    sizeRtn.initialFloat = fibPow;
    repRtn.initialInt = rep; 
    rainbowRtn.initialFloat = rainbowRate;
    tfRtn.initialFloat = tf;
    rShiftRtn.initialFloat = repShift;
    rrzRtn.initialFloat = 0;
    rrxRtn.initialFloat = 0;
    rfacRtn.initialFloat = rfacInit;

}

public class ParamRoutine {
  boolean enabled;
  int mode;
  float speed, prevVal;
  int nModes;
  Easer easer;
  int initialInt;
  float initialFloat;
    ParamRoutine (boolean on, int m, float s) {
      this.enabled = on;
      this.mode = m;
      this.speed = s;
      this.nModes = 13;
      this.prevVal = -99;
      this.easer = new Easer(1.1,  1);
    }
    
    public void setEaserValue(float val) {
      easer.setValue(val);
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
      } else if (mode == 342) { //Green Light Project
        valOut = int(easer.getValue(fTime));
      } else if (mode == 13) { //easer
        valOut = int(easer.getValue(fTime));
      } else if (mode == 14) { //old rfac growth
        valOut = int(easer.getValue(fTime));
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
      } else if (mode == 55) { //0 - 255/16 every [speed] seconds
        float t = fTime/(60*2*this.speed);
        valOut = map(sin(3*PI/2 + t*PI*2), -1, 1, 0, 3);
      } else if (mode == 56) {
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
      } else if (mode == 5) { //mousex
        valOut = map((fTime), 0, this.speed, 9, 0.08);
        valOut = pow(valOut, 1/3.0);
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
        float th = (fTime/(30.0 * this.speed)) * 2 * PI ;
        float r = 0.2;
        float x = r * cos(th);
        float y = r * sin(th);
        //println(x);
        valOut = map((float)osNoise.eval(x, y), -1, 1, (256/2), (256*1.5));
        //println(valOut);
      } else if (mode == 11) {
        float th = (fTime/(30 * this.speed)) * 2 * PI ;
        float r = 3;
        float x = r * cos(th);
        float y = r * sin(th);
        valOut = map((float)osNoise.eval(x, y), -1, 1, -4, 8);
      } else if (mode == 12) {
        float th = (fTime/(30 * this.speed)) * 2 * PI ;
        float r = 2;
        float x = 4 + r * cos(th);
        float y = 4 + r * sin(th);
        valOut = map((float)osNoise.eval(x, y), -1, 1, 0, 4);
      } else if (mode == 342) { //Green Light Project
        valOut = easer.getValue(fTime);
      } else if (mode == 343) { //Green Light size Oscillator
        // use the speed as stsart time
        float t = (fTime - this.speed)/(60*2*3.0);
        valOut = map(sin(t*PI*2), -1, 1, 0, 4);
        //println("t = " + t + ", val = " + valOut);
        //exit();
      } else if (mode == 13) { //easer
        valOut = easer.getValue(fTime);
      }  else if (mode == 14) { //old rfac growth
        // valOut = this.initialFloat + pow(fTime*this.speed, 2);
        valOut = this.initialFloat + pow(fTime*rfacDt, 2);
      }  else if (mode == 15) { //mouseY
        valOut = map(mouseY, 0, height, 0, 4*height);;
      }
      //if (prevVal == -99) {
      //  prevVal = valOut;
      //}
      //float v = lerp(prevVal, valOut, 0.001);
      //prevVal = v;
      return valOut;
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
  
    //   loadEvents();
  
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
  fRate = rainbowRate;
  if (tfRtn.enabled) {
    tf = tfRtn.getFloat(tf);
  }
  if (rShiftRtn.enabled) {
    repShift = rShiftRtn.getFloat(repShift);
  }
  if (rrzRtn.enabled) {
    xmag = rrzRtn.getFloat(xmag);
  }
  if (rrxRtn.enabled) {
    ymag = rrxRtn.getFloat(ymag);
  }
  if (rfacRtn.enabled) {
    // float old = rfac;
    rfac = rfacRtn.getFloat(rfac);
    // println(rfac-old);
  }
}

void blerp(){
  rrzRtn.easer.setEaseByTarget(rrzRtn.easer.val + 2*PI/rep, fTime, loopEvery);

  myRecorder.startRecording();
}
