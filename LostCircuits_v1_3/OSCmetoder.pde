public static float pTimer;
String[] list;
public static boolean explodeB=false;
//connect, skickas i void setup(), skickar telefonens id till unity och ger den ett id där, player1id eller player2id

void connect(int bp, int oscp) {
  OscMessage myOscMessage = new OscMessage("/idConnect"); 
  myOscMessage.add(myIP);
  myOscMessage.add(bp);
  myOscMessage.add(oscp);
  myOscMessage.add(serial);
  oscP5.send(myOscMessage, myBroadcastLocation);
  oscP5 = new OscP5(this, oscp);//Port för inkommande meddelanden, måste stämma med den i unity
  myBroadcastLocation = new NetAddress(computerLAN, bp);
}
/*Tar emot ALLA  oscmeddelanden från unity och printar dem
 */
public synchronized void oscEvent(OscMessage theOscMessage) {
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
  list =split(theOscMessage.addrPattern(), '/');
  for (int i=0;i<list.length;i++) {
    println(i+" "+list[i]);
  }
  if (list[1].equals("prompt") && list[2].equals(serial) && list[3].equals("helpfriend")) {
    vibe.vibrate(200);
    prompt="FLIPP UITTTT11";
    accY = map(accelerometerY, -10, 10, 270, 90);  //Skicka detta
    moveAccelerometerY(accY);
  }
  if (list[1].equals("prompt") && list[2].equals(serial) && list[3].equals("helpfriend2")) {
    vibe.vibrate(200);
    prompt="FLIPP UITTTT11";
    accY = map(accelerometerY, -10, 10, 270, 90);  //Skicka detta
    moveAccelerometerY(accY);
  }

  if (list[1].equals("gravity") && list[2].equals(serial)) {
    vibe.vibrate(200);
    prompt="FLIPP UITTTT";
  }
 /* if (list[1].equals("explode") && list[2].equals(serial)) {
    vibe.vibrate(200);
    pTimer=millis() + 8000;
    changeButton=true;
    explodeB=true;
    prompt="Do you want to press the button?";
  }*/
}

// metoder för DIRECTIONS
void moveUp(int eventData) {
  OscMessage myOscMessage = new OscMessage("/player");
  myOscMessage.add(serial);
  myOscMessage.add("up");
  myOscMessage.add(eventData);
  myOscMessage.add(0);//Man måste tydligen skicka lika många värden varje gång när man skickar till /player, så fick lägga till några struntvärden för att
  //touchen skulle fungera
  oscP5.send(myOscMessage, myBroadcastLocation);
}
void moveDown(int eventData) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("down"); 
  myOscMessage.add(eventData);
  myOscMessage.add(0);
  oscP5.send(myOscMessage, myBroadcastLocation);
}
void moveRight(int eventData) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("right"); 
  myOscMessage.add(eventData);
  myOscMessage.add(0);
  oscP5.send(myOscMessage, myBroadcastLocation);
}
void moveLeft(int eventData) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("left"); 
  myOscMessage.add(eventData);
  myOscMessage.add(0);
  oscP5.send(myOscMessage, myBroadcastLocation);
}
// Metod för materialmanipulation
void manipulate(float x, float y) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("manipulate"); 
  myOscMessage.add(x);
  myOscMessage.add(y);
  //println(x+"    "+y);
  oscP5.send(myOscMessage, myBroadcastLocation);
}
//Lighgtworks
void moveSpotLight(float x, float y) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("spotlight"); 
  myOscMessage.add(x);
  myOscMessage.add(y);
  //println(x+"    "+y);
  oscP5.send(myOscMessage, myBroadcastLocation);
}
//Accelerometerevents
void moveAccelerometerY(float eventData) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("accY"); 
  myOscMessage.add(eventData);
  myOscMessage.add(0);
  oscP5.send(myOscMessage, myBroadcastLocation);
}
void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}
void explode(int eventData) {
  OscMessage myOscMessage = new OscMessage("/player");  
  myOscMessage.add(serial);
  myOscMessage.add("explode"); 
  myOscMessage.add(eventData);
  myOscMessage.add(0);
  oscP5.send(myOscMessage, myBroadcastLocation);
  println("exp "+eventData);
}

