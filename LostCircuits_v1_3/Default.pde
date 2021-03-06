/*
**den vanliga layouten, som man får när man startar appen.
 *använd .display och .update för att visa dom knapparna vi vill för denna layouten
 */
String prompt="Hello!";
int g=255;
boolean s=false;
boolean v=false;
void defaultLayout() {
  if (gravB) {
    accY = map(accelerometerY, -10, 10, 270, 90);  //Skicka detta
    moveAccelerometerY(accY);
    //println(accY);
  }
  rectJump.display();
  rectLeft.display();
  rectRight.display();
  rectManipulate.display();

  if (rectLeft.pressed()||rectRight.pressed()) {
    moveSound.start();
  }
  else {
    moveSound.pause();
    moveSound.seekTo(0);
  }

  if (rectJump.pressed()) {
    jumpSound.start();
  }
  else {
    jumpSound.pause();
    jumpSound.seekTo(0);
  }

  if (rectManipulate.pressed()) {
    manipulateSound.start();
  }
  else {
    manipulateSound.pause();
    manipulateSound.seekTo(0);
  }

  /*
  *pilar för styrknapparna
   */
  pushStyle();
  strokeWeight(displayWidth/200);
  stroke(pc);
  //Left
  //line(70, 65, 10, 100);
  line(displayWidth/11.4, displayHeight/7.3, displayWidth/80, displayHeight/4.8);

  //line(10, 100, 70, 135);
  line(displayWidth/80, displayHeight/4.8, displayWidth/11.4, displayHeight/3.5);

  //Right
  //line(130, 65, 190, 100);
  line(displayWidth/6.1, displayHeight/7.3, displayWidth/4.2, displayHeight/4.8);

  //line(190, 100, 130, 135);
  line(displayWidth/4.2, displayHeight/4.8, displayWidth/6.1, displayHeight/3.5);

  //Jump
  //line(690, 120, 720, 60);
  line(displayWidth/1.15, displayHeight/4, displayWidth/1.11, displayHeight/8);

  //line(720, 60, 750, 120);
  line(displayWidth/1.11, displayHeight/8, displayWidth/1.06, displayHeight/4);

  popStyle();
  promptMeth();
}
/*
  Prompten
 */
String usBlink;

void promptMeth() {
  if (int(millis())/1000%2==0) {
    usBlink=" _";
  }
  else {
    usBlink=" ";
  }

  pushStyle();
  fill(200);
  if (!prompt.equals("")&&millis()>=pTimer) {
    prompt="";
    changeButton=false;
  }
  fill(0);
  rect(displayWidth/3.5, displayHeight/6.8, displayWidth/2.42, displayHeight/9.6);
  fill(200);
  textSize(displayWidth/40);
  text(prompt+usBlink, displayWidth/3.4, displayHeight/4.9);
  popStyle();
}

