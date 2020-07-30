
float tEnd1 = 1*63*60;
float ts = 2*282;
float t0 = ts + 60;
float t1 = ts + 273;
float t2 = ts + 473;
float t3 = ts + 765;
float t4 = ts + 1054;
float t5 = ts + 1339;
float t6 = ts + 1523;
float t7 = ts + 43 * 60;
float t8 = ts +  46 * 60;
float t8p5 = ts + 3176;
float tStart2 = ts + tEnd1;
float t9 =  tStart2 + 10 * 60;
float t10 =  t9 + 5 * 60;
float t11 = t10 + 20 * 60;
float t12 = t11 + 5 * 60;
float t13 = t12 + 5 * 60;
float t14 = t13 + 5 * 60;
float t15 = t14 + 5 * 60;
float t16 = t15 + 5 * 60;
float t17 = t16 + 5 * 60;
float t18 = t17 + 5 * 60;
float t19 = t18 + 5 * 60;
float t20 = t19 + 5 * 60;
float t20p5 = t20 + 10 * 60;
float t21 = t20 + 25 * 60;
float tStart3 = t21 + 10 * 60;
float t22 = tStart3 + 5 * 60;
float t23 = t22 + 15 * 60;
float t24 = t23 + 5 * 60;
float t25 = t24 + 5 * 60;
float t26 = t25 + 5 * 60;
float t27 = t26 + 25 * 60;
float t28 = t27 + 15 * 60;
float t29 = t28 + 15 * 60;
float t30 = t29 + 150;
float tStartTunnel = t29 + 25 * 60;
float tEndTunnel = t30 + 2445;
float t31 = tEndTunnel - 4 * 60;
float t32 = t31 + 2 * 60;
float t33 = t32 + 1.6 * 60;
float t34 = t33 + 6 * 60;
float t35 = t34 + 4 * 60;
float t36 = t35 + 5 * 60;
float t37 = t36 + 10 * 60;
float t38 = t37 + 10 * 60;
float t39 = t38 + 20 * 60;
float t40 = t39 + 10 * 60;
float t41 = t40 + 10 * 60;
float t42 = t41 + 10 * 60;
float t43 = t42 + 10 * 60;
float t44 = t43 + 10 * 60;
float t45 = t44 + 10 * 60;
float t46 = t45 + 10 * 60;
float t47 = t44 + magicNumber;
float t48 = t47 + 10 * 60;
float t49 = t48 + 10 * 60;

boolean tsHit = false;
boolean t1Hit = false;
boolean t2Hit = false;
boolean t3Hit = false;
boolean t4Hit = false;
boolean t5Hit = false;
boolean t6Hit = false;
boolean t7Hit = false;
boolean t8Hit = false;
boolean t8p5Hit = false;
boolean t9Hit = false;
boolean t10Hit = false;
boolean tStart2Hit = false;
boolean t11Hit = false;
boolean t12Hit = false;
boolean t13Hit = false;
boolean t14Hit = false;
boolean t15Hit = false;
boolean t16Hit = false;
boolean t17Hit = false;
boolean t18Hit = false;
boolean t19Hit = false;
boolean t20Hit = false;
boolean t20p5Hit = false;
boolean t21Hit = false;
boolean tStart3Hit = false;
boolean t22Hit = false;
boolean t23Hit = false;
boolean t24Hit = false;
boolean t25Hit = false;
boolean t26Hit = false;
boolean t27Hit = false;
boolean t28Hit = false;
boolean t29Hit = false;
boolean t30Hit = false;
boolean tunnelHit = false;
boolean t31Hit = false;
boolean t32Hit = false;
boolean t33Hit = false;
boolean t34Hit = false;
boolean t35Hit = false;
boolean t36Hit = false;
boolean t37Hit = false;
boolean t38Hit = false;
boolean t39Hit = false;
boolean t40Hit = false;
boolean t41Hit = false;
boolean t42Hit = false;
boolean t43Hit = false;
boolean t44Hit = false;
boolean t45Hit = false;
boolean t46Hit = false;
boolean t47Hit = false;
boolean t48Hit = false;
boolean t49Hit = false;

void loadEvents() {
  if (starting){
    starting = false;
    //println(millis()/1000.);
    
    //println(fTime);
    //println(restart);
    //println(mode);
    
    
    //revs = 22;//?
    //symmetry = 5;//0.74;
    //segments = 24;
    //fibPow = 2;
    //rep = 6;
    //scl = 1;
    ////loops every 300 frames
    //loopEvery = 60*30;
    //rainbowRate = 1.3;//0.0024?
    //tf = 5.333;
    //repShift = 0.00163;
    //scalingOn = false;
    //rotateZOn = false;
    //rotateXOn = false;
    //scaleInc = 0.001;
    //rfacDt = 1/pow(fib,7);
    //rfacInit = 300;
    //rfac = rfacInit;
    //rotRateZ = 0.12;
    //rotRateX = 0.318;
    //clockwiseOn = true;
    //counterClockwiseOn = true;
    //growthOn = false;
    //bgOn = true;
    //myBrush = 3;
    //strWeight = 1;
    
    
    //symRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //segRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //sizeRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //repRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //rainbowRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //tfRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //rShiftRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //rfacRtn.easer.setEaseByTarget(0, fTime, t47-46);
    //rrzRtn.easer.setEaseByTarget(0, fTime, t47-46);
    

    symRtn.easer.setValue(0); 
    symRtn.easer.setEaseByTarget(90, fTime, ts);
    segRtn.easer.setValue(0);
    segRtn.easer.setEaseByTarget(24, fTime, ts);
    sizeRtn.easer.setValue(0);
    sizeRtn.easer.setEaseByTarget(2, fTime, ts);
    rep = 0;
    clockwiseOn = false;
    rainbowRtn.easer.setValue(0);
    rainbowRtn.easer.setEaseByTarget(1.1, fTime, ts);
    tfRtn.easer.setValue(0);
    tfRtn.easer.setEaseByTarget(17, fTime, ts);
    rShiftRtn.easer.setValue(0);
    rShiftRtn.easer.setEaseByTarget(0.00163, fTime, t47-46);
    rrzRtn.easer.setValue(0);
    rrxRtn.easer.setValue(0);
    revs = 33;
    
    rfacRtn.easer.setValue(0);
    showSpiral = false;
    withAlpha = true;
    playVideo2 = true;
    oFrame = magicNumber;
    //restart = millis();
    //fTime = 0;
  }
  if (fTime >= ts && !tsHit) {
    tn++;
    println(fTime);
    tsHit = true;
    println("ts");
    starting = false;

    //segRtn.easer.setValue(segments);
    //sizeRtn.easer.setValue(fibPow);
    rep = 1;
    repRtn.easer.setValue(rep);
    clockwiseOn = false;
    rainbowRtn.easer.setValue(1.1);
    tfRtn.easer.setValue(17);
    //rShiftRtn.easer.setValue(repShift);
    rrzRtn.easer.setValue(0);
    rrxRtn.easer.setValue(0);
    revs = 33;
    
    symRtn.easer.setValue(90); 
    rfacRtn.easer.setValue(1);
    rfacRtn.easer.setEaseMode(1);
    rfacRtn.easer.setEaseByTarget(1200000, fTime, tEnd1);    
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget(6*PI, fTime, tEnd1);
    showSpiral = true;
    withAlpha = true;
    //restart = millis();
    //fTime = 0;
  }
  
  if (fTime >= t1 && !t1Hit) {//"human"
    tn++;
    println(fTime);
    t1Hit = true;
    println("t1");
    
    //symRtn.easer.setEaseMode(8);
    //symRtn.easer.setEaseByTarget(5, fTime, t2 - t1);  
    //rfacRtn.easer.setEaseByTarget(3000*6, fTime, tEnd1);    
  }
  
  if (fTime >= t2 && !t2Hit) {//"IS"
    tn++;
    t2Hit = true;
    println("t2");
    rep += 1;
    symRtn.easer.setEaseMode(3);  
    symRtn.easer.setEaseByTarget(5, fTime, t7 - t2);  
  } 
    
  
  if (fTime >= t3 && !t3Hit) {//"Right" 
    tn++;
    t3Hit = true;
    println("t3");
  } 
  
  
  if (fTime >= t4 && !t4Hit) {
    tn++;
    t4Hit = true;
    println("t4");
    rep += 1;
  } 
  
  
  if (fTime >= t5 && !t5Hit) {
    tn++;
    t5Hit = true;
    println("t5");
    rep += 1;
    rShiftRtn.easer.setEaseMode(1);
    rShiftRtn.easer.setEaseByTarget(22, fTime, ts + tEnd1 - t5);
  } 
  
  if (fTime >= t6 && !t6Hit) {
    tn++;
    t6Hit = true;
    println("t6");
    rep += 2;
  } 
  
  if (fTime >= t7 && !t7Hit) {
    tn++;
    t7Hit = true;
    println("t7");
    symRtn.easer.setEaseMode(3);
    symRtn.easer.setEaseByTarget(0.2, fTime, ts + tEnd1 - t7);  
    sizeRtn = new ParamRoutine(true, 343, t7);
    revs += 10;
    withAlpha = false;
    
  } 
  
  if (fTime >= t8 && !t8Hit) {
    tn++;
    t8Hit = true;
    println("t8");
    //clockwiseOn = true;
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(255, fTime, ts + tEnd1 - t8);
  } 
  
  if (fTime >= t8p5 && !t8p5Hit) {
    tn++;
    t8p5Hit = true;
    println("t8p5");
    playVideo2 = false;
    
  } 
  
  if (fTime >= tEnd1){
    //exit();
  }
  
  if (fTime >= tStart2 && !tStart2Hit){
    tn++;
    tStart2Hit = true;
    println("tStart2");
    doStart2();
  }
  
  
  if (fTime >= t9 && !t9Hit) {
    tn++;
    t9Hit = true;
    println("t9");
    sizeRtn = new ParamRoutine(true, 342, t7);
    sizeRtn.easer.setEaseMode(8);
    sizeRtn.easer.setValue(fibPow);
    sizeRtn.easer.setEaseByTarget(2, fTime, t10 - t9);
    
  }
  
  if (fTime >= t10 && !t10Hit) {
    tn++;
    t10Hit = true;
    println("t10");
    
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(122, fTime, tEnd1);
  }
    
  if (fTime >= t11 && !t11Hit) {
    tn++;
    t11Hit = true;
    println("t11");
    //for later
    //segRtn = new ParamRoutine(true, 342, 1);
    //segRtn.easer.setEaseMode(0);
    //segRtn.easer.setValue(segments);
    //segRtn.easer.setEaseByTarget(84, fTime, t12 - t11);
    //sizeRtn.easer.setEaseByTarget(5, fTime, t13 - t11);
    rrzRtn.easer.setEaseMode(3);
    rrzRtn.easer.setEaseByTarget(3*PI, fTime, t20-t11);
    
    
  }
  
  if (fTime >= t12 && !t12Hit) {
    tn++;
    t12Hit = true;
    println("t12");
  }
  
  
  if (fTime >= t13 && !t13Hit) {
    tn++;
    t13Hit = true;
    println("t13");
  }
  
  if (fTime >= t14 && !t14Hit) {
    tn++;
    t14Hit = true;
    println("t14");
  }
  
  if (fTime >= t15 && !t15Hit) {
    tn++;
    t15Hit = true;
    println("t15");
  }
  
  if (fTime >= t16 && !t16Hit) {
    tn++;
    t16Hit = true;
    println("t16");
    segRtn = new ParamRoutine(true, 342, 1);
    segRtn.easer.setEaseMode(3);
    segRtn.easer.setValue(segments);
    segRtn.easer.setEaseByTarget(4, fTime, t17 - t16);
  }
  
  if (fTime >= t17 && !t17Hit) {
    tn++;
    t17Hit = true;
    println("t17");
    rep = 8;
    sizeRtn.easer.setEaseByTarget(1, fTime, t19 - t17);
  }
  
  if (fTime >= t18 && !t18Hit) {
    tn++;
    t18Hit = true;
    println("t18");
  }
  
  if (fTime >= t19 && !t19Hit) {
    tn++;
    t19Hit = true;
    println("t19");
    rfacRtn = new ParamRoutine(true, 342, 1);
    rfacRtn.easer.setValue(rfac);
    rfacRtn.easer.setEaseMode(3);
    rfacRtn.easer.setEaseByTarget(3000*6*4, fTime, t20 - t15);
  }
  
  if (fTime >= t20 && !t20Hit) {
    tn++;
    t20Hit = true;
    println("t20");
    symRtn.easer.setEaseMode(3);
    symRtn.easer.setEaseByTarget(13, fTime, t21 - t20);
    rrzRtn.easer.setEaseByTarget(-6*PI, fTime, tEnd1);
  }
  
  if (fTime >= t20p5 && !t20p5Hit) {
    tn++;
    t20p5Hit = true;
    println("t20p5");
  }
  
  if (fTime >= t21 && !t21Hit) {
    tn++;
    t21Hit = true;
    println("t21");
    symRtn.easer.setEaseMode(3);
    symRtn.easer.setEaseByTarget(79, fTime, (tStart3 - t21) + 3*60);
  }
  
  if (fTime >= tStart3 && !tStart3Hit) {
    tn++;
    tStart3Hit = true;
    println("tStart3");
    doStart3();
    rfacRtn.easer.setEaseMode(1);
    rfacRtn.easer.setEaseByTarget(3000*6, fTime-150, tEnd1);  
  }
  
  if (fTime >= t22 && !t22Hit) {
    tn++;
    t22Hit = true;
    println("t22");
    symRtn.easer.setEaseMode(3);
    symRtn.easer.setEaseByTarget(11.14, fTime, (tStart3 - t21) + 12*60);
  }
  
  if (fTime >= t23 && !t23Hit) {
    tn++;
    t23Hit = true;
    println("t23");
    rShiftRtn.easer.setEaseMode(2);
    rShiftRtn.easer.setEaseByTarget(256/9, fTime, t25 - t23);
  }
  
  
  if (fTime >= t24 && !t24Hit) {
    tn++;
    t24Hit = true;
    println("t24");
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256/9., fTime, tEnd1);
    rShiftRtn.easer.setEaseMode(1);
    rShiftRtn.easer.setEaseByTarget(13.14, fTime, tEnd1/3.);
  }
  
  if (fTime >= t25 && !t25Hit) {
    tn++;
    t25Hit = true;
    println("t25");
    symRtn.easer.setEaseMode(3);
    symRtn.easer.setEaseByTarget(4.00, fTime, 12*60);
    rShiftRtn.easer.setEaseByTarget(0.0001, fTime, 12*60);
  }
  
  if (fTime >= t26 && !t26Hit) {
    tn++;
    t26Hit = true;
    println("t26");
    rrzRtn.easer.setEaseMode(3);
    rrzRtn.easer.setEaseByTarget(6*PI, fTime, tEnd1/2.0);
  }
  
  if (fTime >= t27 && !t27Hit) {
    tn++;
    t27Hit = true;
    println("t27");
    symRtn.easer.setEaseMode(3);
    symRtn.easer.setEaseByTarget(0.3, fTime, t28 - t27);
    revs = 69;
  }
  
  
  if (fTime >= t28 && !t28Hit) {
    tn++;
    t28Hit = true;
    println("t28");
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(2*256/9., fTime, tEnd1);
  }
  
  if (fTime >= t29 && !t29Hit) {
    tn++;
    t29Hit = true;
    println("t29");
    symRtn.easer.setEaseByTarget(0.1, fTime, 25*60);
  }
  
  
  if (fTime >= t30 && !t30Hit) {
    tn++;
    t30Hit = true;
    println("t30");
    playVideo1 = true;
    tScaleEaser.setEaseMode(0);
    tScaleEaser.setValue(1);
    println(t37 - (fTime + 2440));
    tScaleEaser.setEaseByTarget(0.01, tEndTunnel, t36 - tEndTunnel);
  }
  
  if (fTime >= tStartTunnel && !tunnelHit) {
    tn++;
    tunnelHit = true;
    println("tunnel");
    showSpiral = false;
    frameIncrement = true;
    goTime = true;
    doTunnel();
    //tFrameEaser.setEaseByTarget(1223, fTime, 1223 - tFrame);
    //println(1223 - tFrame);
    //println(tFrameEaser.getValue(fTime));
    //println(tFrameEaser.getValue(fTime+1));
    //println(tFrameEaser.getValue(fTime+2));//open submissions //call for submissions
  }  
  
  if (fTime >= t31 && !t31Hit) {
    tn++;
    t31Hit = true;
    println("t31");
    
    symRtn = new ParamRoutine(true, 342, 59*30);
    symRtn.easer.setValue(symmetry);
    symRtn.easer.setEaseByTarget(200, fTime, t32 - t31);
    segRtn = new ParamRoutine(true, 342, 97);
    segRtn.easer.setValue(segments);
    segRtn.easer.setEaseByTarget(300, fTime, t32 - t31);
    sizeRtn = new ParamRoutine(true, 342, 14.872);
    sizeRtn.easer.setValue(fibPow);
    sizeRtn.easer.setEaseByTarget(fib, fTime, t32 - t31);
    repRtn = new ParamRoutine(true, 342, 156);
    repRtn.easer.setValue(rep);
    repRtn.easer.setEaseByTarget(4, fTime, t32 - t31);
    rainbowRtn = new ParamRoutine(true, 342, 1);
    rainbowRtn.easer.setValue(rainbowRate);
    rainbowRtn.easer.setEaseByTarget(3.1, fTime, t32 - t31);
    tfRtn = new ParamRoutine(true, 342, 150);
    tfRtn.easer.setValue(tf);
    tfRtn.easer.setEaseByTarget(11, fTime, t32 - t31);
    rShiftRtn = new ParamRoutine(true, 342, 11);
    rShiftRtn.easer.setValue(repShift);
    rShiftRtn.easer.setEaseByTarget(256/11.0, fTime, t32 - t31);
    rfacRtn = new ParamRoutine(true, 342, 20);
    rfacRtn.easer.setValue(rfac);
    rfacRtn.easer.setEaseByTarget(1, fTime, t32 - t31);
    rrzRtn = new ParamRoutine(true, 342, 20);
    rrzRtn.easer.setValue(PI/8);
    rrzRtn.easer.setEaseByTarget((2*PI/8)+(0*PI/40), fTime, t32 - t31);
    
    //playVideo1 = false;
  }
  
  if (fTime >= t32 && !t32Hit) {
    tn++;
    t32Hit = true;
    println("t32");
    showSpiral = true;
    withAlpha = false;
    clockwiseOn = false;
    myPalette.setPalette(0);
    rfacRtn.easer.setEaseMode(0);
    rfacRtn.easer.setEaseByTarget(240, fTime, tEndTunnel - t32);
  }
  
  if (fTime >= t33 && !t33Hit) {
    tn++;
    t33Hit = true;
    println("t33");
    symRtn.easer.setEaseMode(2);
    symRtn.easer.setEaseByTarget(16, fTime, t34 - t33);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget((2*PI/8)+(PI/2.0), fTime, t34 - t33);
    segRtn.easer.setEaseMode(3);
    segRtn.easer.setEaseByTarget(30, fTime, t35 - t33);
  }
  
  if (fTime >= t34 && !t34Hit) {
    tn++;
    t34Hit = true;
    println("t34");
    symRtn.easer.setEaseMode(2);
    symRtn.easer.setEaseByTarget(7.4, fTime, t35 - t34);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget((2*PI/8)+(PI/2.0)+PI, fTime, t35 - t34);
  }
  
  if (fTime >= t35 && !t35Hit) {
    tn++;
    t35Hit = true;
    println("t35");
    symRtn.easer.setEaseMode(2);
    symRtn.easer.setEaseByTarget(4.0, fTime, t36 - t35);
    rrzRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseByTarget((2*PI/8)+(PI/2.0)+PI+2*PI, fTime, t36 - t35);
    sizeRtn.easer.setEaseMode(3);
    sizeRtn.easer.setEaseByTarget(0.918, fTime, t36 - t35);
    rfacRtn.easer.setEaseMode(1);
    rfacRtn.easer.setEaseByTarget(2400, fTime, 60*60);
  }
  
  if (fTime >= t36 && !t36Hit) {
    tn++;
    t36Hit = true;
    println("t36");
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(0.1, fTime, t37 - t36);
    rrzRtn.easer.setEaseByTarget(4*((2*PI/8)+(PI/2.0)+PI+2*PI), fTime, t41 - t36);
  }
  
  if (fTime >= t37 && !t37Hit) {
    tn++;
    t37Hit = true;
    println("t37");
    rShiftRtn.easer.setEaseMode(0);
    rShiftRtn.easer.setEaseByTarget(255, fTime, t40 - t37);
    playVideo1 = false;
  }
  
  if (fTime >= t38 && !t38Hit) {
    tn++;
    t38Hit = true;
    println("t38");
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(255/8.0, fTime, t39 - t38 - (5 * 60));
  }
  
  if (fTime >= t39 && !t39Hit) {
    tn++;
    t39Hit = true;
    println("t39");
    tfRtn.easer.setEaseMode(0);
    tfRtn.easer.setEaseByTarget(256+256/16.0, fTime, t43 - t39);
  }
  
  if (fTime >= t40 && !t40Hit) {
    tn++;
    t40Hit = true;
    println("t40");
    symRtn.easer.setEaseMode(2);
    symRtn.easer.setEaseByTarget(0.05, fTime, t46 - t40);
    rShiftRtn.easer.setEaseMode(3);
    rShiftRtn.easer.setEaseByTarget(108, t42, t44 - t42);
  }
  
  if (fTime >= t44 && !t44Hit) {
    tn++;
    t44Hit = true;
    println("t44");
    playVideo2 = true;
    oFrame = 1;
  }
  
  if (fTime >= t46 && !t46Hit) {
    tn++;
    t46Hit = true;
    println("t46");
    showSpiral = false;
    oFrame = int(1 + t46 - t44);
    goTime = true;
    
    
    symRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    segRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    sizeRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    repRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    rainbowRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    tfRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    rShiftRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    rfacRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    rrzRtn.easer.setEaseByTarget(0, fTime, (t47-t46)-(3*60));
    
  }
  
  if (fTime >= t47){
    println("exiting");
    exit();
  }
}

void doStart1() {
  loadParameters(342);
  starting = false;
  //println(millis()/1000.);
  
  //println(fTime);
  //println(restart);
  //println(mode);
  

  segRtn.easer.setValue(segments);
  sizeRtn.easer.setValue(fibPow);
  repRtn.easer.setValue(1);
  rep = 1;
  clockwiseOn = false;
  rainbowRtn.easer.setValue(1.1);
  tfRtn.easer.setValue(17);
  rShiftRtn.easer.setValue(repShift);
  rrzRtn.easer.setValue(0);
  rrxRtn.easer.setValue(0);
  revs = 33;
  
  symRtn.easer.setValue(90); 
  rfacRtn.easer.setValue(1);
  rfacRtn.easer.setEaseMode(1);
  rfacRtn.easer.setEaseByTarget(1200000, fTime, tEnd1);    
  rrzRtn.easer.setEaseMode(0);
  rrzRtn.easer.setEaseByTarget(6*PI, fTime, tEnd1);
  //restart = millis();
  //fTime = 0;
}

void doStart2() {
  loadParameters(342);
  t1Hit = true;
  t2Hit = true;
  t3Hit = true;
  t4Hit = true;
  t5Hit = true;
  t6Hit = true;
  t7Hit = true;
  t8Hit = true;
  t9Hit = false;
  t10Hit = false;
  t11Hit = false;
  t12Hit = false;
  t13Hit = false;
  t14Hit = false;
  t15Hit = false;
  t16Hit = false;
  t17Hit = false;
  t18Hit = false;
  t19Hit = false;
  t20Hit = false;
  t20p5Hit = false;
  t21Hit = false;
  tStart3Hit = false;
  t22Hit = false;
  t23Hit = false;
  t24Hit = false;
  t25Hit = false;
  t26Hit = false;
  t27Hit = false;
  t28Hit = false;
  t29Hit = false;
  t30Hit = false;
  playVideo1 = false;
  tunnelHit = false;
  t31Hit = false;
  t32Hit = false;
  t33Hit = false;
  t34Hit = false;
  t35Hit = false;
  t36Hit = false;
  t37Hit = false;
  t38Hit = false;
  t39Hit = false;
  t40Hit = false;
  t41Hit = false;
  t42Hit = false;
  t43Hit = false;
  t44Hit = false;
  t45Hit = false;
  t46Hit = false;
  t47Hit = false;
  t48Hit = false;
  t49Hit = false;
  
  sizeRtn = new ParamRoutine(true, 343, t7);
  segRtn.easer.setValue(24);
  sizeRtn.easer.setValue(2);
  repRtn.easer.setValue(6);
  rep = 6;
  clockwiseOn = true;
  counterClockwiseOn = true;
  rainbowRtn.easer.setValue(1.5);
  tfRtn.easer.setValue(17);
  rShiftRtn.easer.setValue(repShift);
  rrzRtn.easer.setValue(0);
  rrxRtn.easer.setValue(0);
  revs = 33;
  symRtn.easer.setValue(0); 
  rfacRtn.easer.setValue(1200);
  
  
    rShiftRtn.easer.setEaseMode(0);
    symRtn.easer.setEaseMode(3);  
    rrzRtn.easer.setEaseMode(0);
    rfacRtn.easer.setEaseMode(1);
  
  symRtn.easer.setEaseMode(8);
  symRtn.easer.setEaseByTarget(5, fTime, t9 - tStart2);  
  rfacRtn.easer.setEaseByTarget(3000*6, fTime, tEnd1);  
}

void doStart3() {
  loadParameters(342);
  println("!!!!!!!!!!!!!!!!");
  t1Hit = true;
  t2Hit = true;
  t3Hit = true;
  t4Hit = true;
  t5Hit = true;
  t6Hit = true;
  t7Hit = true;
  t8Hit = true;
  t9Hit = true;
  tStart2Hit = true;
  t10Hit = true;
  t11Hit = true;
  t12Hit = true;
  t13Hit = true;
  t14Hit = true;
  t15Hit = true;
  t16Hit = true;
  t17Hit = true;
  t18Hit = true;
  t19Hit = true;
  t20Hit = true;
  t20p5Hit = true;
  t21Hit = true;
  t22Hit = false;
  t23Hit = false;
  t24Hit = false;
  t25Hit = false;
  t26Hit = false;
  t27Hit = false;
  t28Hit = false;
  t29Hit = false;
  t30Hit = false;
  playVideo1 = false;
  tunnelHit = false;
  t31Hit = false;
  t32Hit = false;
  t33Hit = false;
  t34Hit = false;
  t35Hit = false;
  t36Hit = false;
  t37Hit = false;
  t38Hit = false;
  t39Hit = false;
  t40Hit = false;
  t41Hit = false;
  t42Hit = false;
  t43Hit = false;
  t44Hit = false;
  t45Hit = false;
  t46Hit = false;
  t47Hit = false;
  t48Hit = false;
  t49Hit = false;
  
  sizeRtn = new ParamRoutine(true, 342, t7);
  segRtn.easer.setValue(58);
  sizeRtn.easer.setValue(3.14159);
  repRtn.easer.setValue(7);
  rep = 7;
  clockwiseOn = true;
  counterClockwiseOn = true;
  rainbowRtn.easer.setValue(1.5);
  tfRtn.easer.setValue(3);
  rShiftRtn.easer.setValue(256/4.0);
  rrzRtn.easer.setValue(0);
  rrxRtn.easer.setValue(0);
  revs = 33;
  symRtn.easer.setValue(0); 
  rfacRtn.easer.setValue(1);
  
  sizeRtn.easer.setEaseMode(8);
    rShiftRtn.easer.setEaseMode(0);
    rrzRtn.easer.setEaseMode(3);
    segRtn = new ParamRoutine(true, 342, 1);
    segRtn.easer.setValue(58);  
    segRtn.easer.setEaseMode(3);
    rfacRtn = new ParamRoutine(true, 342, 1);
    rfacRtn.easer.setValue(1);
    rfacRtn.easer.setEaseMode(3);
    symRtn.easer.setEaseMode(3);
    
}

void doT29() {
  loadParameters(342);
  t1Hit = true;
  t2Hit = true;
  t3Hit = true;
  t4Hit = true;
  t5Hit = true;
  t6Hit = true;
  t7Hit = true;
  t8Hit = true;
  t9Hit = true;
  tStart2Hit = true;
  t10Hit = true;
  t11Hit = true;
  t12Hit = true;
  t13Hit = true;
  t14Hit = true;
  t15Hit = true;
  t16Hit = true;
  t17Hit = true;
  t18Hit = true;
  t19Hit = true;
  t20Hit = true;
  t20p5Hit = true;
  t21Hit = true;
  tStart3Hit = true;
  t22Hit = true;
  t23Hit = true;
  t24Hit = true;
  t25Hit = true;
  t26Hit = true;
  t27Hit = true;
  t28Hit = true;
  t29Hit = false;
  t30Hit = false;
  playVideo1 = false;
  tunnelHit = false;
  t31Hit = false;
  t32Hit = false;
  t33Hit = false;
  t34Hit = false;
  t35Hit = false;
  t36Hit = false;
  t37Hit = false;
  t38Hit = false;
  t39Hit = false;
  t40Hit = false;
  t41Hit = false;
  t42Hit = false;
  t43Hit = false;
  t44Hit = false;
  t45Hit = false;
  t46Hit = false;
  t47Hit = false;
  t48Hit = false;
  t49Hit = false;
  
  sizeRtn = new ParamRoutine(true, 342, t7);
  segRtn.easer.setValue(58);
  sizeRtn.easer.setValue(3.14159);
  repRtn.easer.setValue(7);
  rep = 7;
  clockwiseOn = true;
  counterClockwiseOn = true;
  rainbowRtn.easer.setValue(1.5);
  tfRtn.easer.setValue(2*256/9.);
  rShiftRtn.easer.setValue(0.001);
  rrzRtn.easer.setValue(0);
  rrxRtn.easer.setValue(0);
  revs = 69;
  symRtn.easer.setEaseMode(3);
  symRtn.easer.setValue(0.3); 
  rfacRtn.easer.setValue(3000*6);
}

void doTunnel(){
  //loadParameters(342);
  playVideo1 = true;
  showSpiral = false;
  
  symRtn = new ParamRoutine(true, 3, 32.775);
  segRtn = new ParamRoutine(true, 2, 97);
  sizeRtn = new ParamRoutine(true, 11, 14.872);
  repRtn = new ParamRoutine(true, 10, 156);
  rainbowRtn = new ParamRoutine(true, 3, 1);
  tfRtn = new ParamRoutine(true, 10, 60);
  rShiftRtn = new ParamRoutine(true, 12, 110);  
}

void doT31(){
  playVideo1 = true;
  showSpiral = false;
  tFrame = int(t31 - t30);
  println(tFrame);
  //goTime = true;
  
}

int getImgNum(int dir, int repN) {
  
  if (t31Hit) {
      return 31 + repN % 4;
  } else if (tStart3Hit) {
    if (repN == 0) {
      return 12;//future
    } else if (repN == 3) {
      return 13;//belongs
    } else if (repN == 6) {
      return 17;//see
    } else if (repN < 3) {
      return 20 + repN;
    } else if (repN < 6) {
      return 19 + repN;
    }
      return 18 + repN;
  } else if (t20p5Hit) {
    if (repN == 0) {
      return 12;//future
    } else if (repN == 3) {
      return 13;//belongs
    } else if (repN == 6) {
      return 17;//see
    }
      return 20;
  } else if (t17Hit) {
    //if (repN == 1 || repN == 2 || repN == 6)  {
    //  return 11 + repN % 8;
    //}
    if (repN == 0) {
      return 16;//can
    } else if (repN == 3) {
      return 17;//see
    } else if (repN == 6) {
      return 18;//it
    }
      return 20;
  } else if (t16Hit) {
      return 11 + repN % 8;
  } else if (t15Hit) {
    if (repN % 7 < 5)  {
      return 11 + repN % 7;
    }
    return 5 + repN % 6;
  } else if (t14Hit) {
    if (repN % 7 < 4)  {
      return 11 + repN % 7;
    }
    return 5 + repN % 6;
  } else if (t13Hit) {
    if (repN % 7 < 3)  {
      return 11 + repN % 7;
    }
    return 5 + repN % 6;
  } else if (t12Hit) {
    if (repN % 7 < 2)  {
      return 11 + repN % 7;
    }
    return 5 + repN % 6;
  } else if (t11Hit) {
    if (repN % 7 < 1)  {
      return 11 + repN % 7;
    }
    return 5 + repN % 6;
  } else if (tStart2Hit) {
    return 5 + repN % 6;
  } else if (t5Hit) {
    return repN % 4;
  } else if (t3Hit) {
    return 3;
  } else if (t2Hit) {
    return 2;
  } else if (t1Hit) {
    return 1;
  }
  
  return 0;
}