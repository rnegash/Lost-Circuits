/*
**svets that shit
 *
 */
float accY;//Värdet som skickas för accelerometern 
// accY = map(accelerometerY, -10, 10, 270, 90);  //Skicka detta
boolean svetsRun=true;

int nur;
int counter=1;
ArrayList object;
public int sumOfIds; //Räknar ihop summan av id´na som har assignats till spotsen
public int sum; //Räknar ihop summan av id´na som har assignats till spotsen

public synchronized void svetsTask() {
  //Loopa igenom spotsen och kör funktionerna för att visa och kolla touch
  if (svetsRun) {
    svetsSetup();
  }

  for (int i =0;i<object.size(); i++) {
    spots objectal = (spots) object.get(i);
    objectal.display();
    objectal.checkTouch();
    if (sum>sumOfIds) {
      background(#FF1CFC);
      svetsDone(1);
  
      currentLayout=1;
    }
  }
        svetsDone(0);

  svetsRun=false;
}
void svetsSetup() {
  //svetsRun=true;
  object = new ArrayList();
  //lägg till alla spots
  for (float x=displayWidth/2.28;x<displayWidth/2;x+=displayWidth/16) {
    for (float y=displayHeight/9.6;y<displayHeight/1.06;y+=displayHeight/4.8) {
      object.add(new spots(x+random(-displayWidth/16, displayWidth/16), y, displayWidth/16, counter++));
      sumOfIds+=counter;
    }
  }
  sumOfIds-=counter;
}

