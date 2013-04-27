/*
**Layout för det första accpusslet
 *
 */
float accY;//Värdet som skickas för accelerometern 

public synchronized void task1() {
  rectBack.display();//gå tillbaka till default
  pushStyle();
  stroke(100);
  strokeWeight(3);
  line(displayWidth/1.09, displayHeight/9.6, displayWidth/1.02, displayHeight/4.8);//kryss
  line(displayWidth/1.02, displayHeight/9.6, displayWidth/1.09, displayHeight/4.8);//kryss
  popStyle();
  accY = map(accelerometerY, -10, 10, 270, 90);  //Skicka detta
  moveAccelerometerY(accY);

  pushStyle();
  accY = map(accelerometerY, -10, 10, 0, width);//Mappa om igen för att rektangeln ska synas på rätt pos på skärmen
  fill(30);
  rectMode(CENTER);
  rect(accY, displayHeight/2, displayWidth/5, displayWidth/5);//Visar en rect, ungefär som ett vattenpass på skärmen
  popStyle();

  changeButton=false;
  prompt="Help your friend!";
  /*
  Prompten
   */

  //promptMeth();
}

