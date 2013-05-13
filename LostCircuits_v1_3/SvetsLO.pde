/*
**svets that shit
 *
 */
//float accY;//Värdet som skickas för accelerometern 
// accY = map(accelerometerY, -10, 10, 270, 90);  //Skicka detta
//    moveAccelerometerY(accY);
boolean svetsRun=true;
int sID;
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
  pushMatrix();
  translate(mouseX, mouseY);
  if (mousePressed) {
    ps.addParticle();
    ps.run();
  }
  popMatrix();
  for (int i =0;i<object.size(); i++) {
    spots objectal = (spots) object.get(i);
    objectal.display();
    objectal.checkTouch();
    if (sum>sumOfIds) {
      background(#FF1CFC);
      println(sID);
      for (int j =0;j<100; j++) {
        svetsDone(sID);
      }
      svetsRun=false;
      sum=0;
      currentLayout=1;
    }
  }
  svetsDone(0);

  svetsRun=false;
}
ParticleSystem ps;

void svetsSetup() {
  //svetsRun=true;
  ps = new ParticleSystem(new PVector(0, 0));

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


class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(color(232, 216, 94), lifespan);
    ellipse(location.x, location.y, 2, 5);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}




// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext ()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
}

