/*
*välj spelare
 */

static String introText="Please choose your character, blue or red?\nGood luck!";

void setupScreen() {
  rectPlayer1.display();
  rectPlayer2.display();
  if (rectPlayer1.pressed()) {
    introText="You chose blue, please wait...";
  }
  else if (rectPlayer2.pressed()) {
    introText="You chose red, please wait...";
  }
  pushStyle();
  fill(0);
  rect(displayWidth/4.1, displayHeight/6.65, displayWidth/1.6, displayHeight/6);
  textSize(displayWidth/32);
  fill(200);
  if (int(millis())/1000%2==0) {
    usBlink=" _";
  }
  else {
    usBlink=" ";
  }
  text(introText+usBlink, displayWidth/4, displayHeight/4.8);
  text("Please enter host IP below:", displayWidth/40, displayHeight/1.26);
  popStyle();
}
