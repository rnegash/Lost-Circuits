/*
Layout för det andra accpusslet, med flera blocks
 */


boolean blockPicker1=false, blockPicker2=false, blockPicker3=false;
void multiAccPuzzle() {
  /*
  Visa knapparna där man väljer vilket block man vill kontorllera
   */
  rectPF1.display();
  rectPF2.display();
  rectPF3.display();
  rectBack.display();
  pushStyle();
  stroke(100);
  strokeWeight(3);
  line(displayWidth/1.09, displayHeight/9.6, displayWidth/1.02, displayHeight/4.8);//kryss
  line(displayWidth/1.02, displayHeight/9.6, displayWidth/1.09, displayHeight/4.8);//kryss
  popStyle();
  accY = map(accelerometerY, -10, 10, 270, 90);  

  //Skicka rätt värde för rätt block
  if (blockPicker1) {
    moveAccelerometerY(accY, 1);
  }
  if (blockPicker2) {      
    moveAccelerometerY(accY, 2);
  }
  if (blockPicker3) {      
    moveAccelerometerY(accY, 3);
  }
  pushStyle();
  accY = map(accelerometerY, -10, 10, 0, width);//Mappa om igen för att rektangeln ska synas på rätt pos på skärmen
  fill(30);
  rectMode(CENTER);
  rect(accY, displayHeight/2.2, displayWidth/5, displayWidth/5);//Visar en rect, ungefär som ett vattenpass på skärmen
  popStyle();
  prompt="Help your friend!";

 // promptMeth(g);
}
void moveAccelerometerY(float eventData, int id) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("accY2"); 
  myOscMessage.add(eventData);
  myOscMessage.add(id);
  oscP5.send(myOscMessage, myBroadcastLocation);
  //println(eventData+" "+id);
}

