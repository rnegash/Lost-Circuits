class spots {
  float _x, _y, _s;
  public int id;
  int _pid;
  //Konstruktor; xpos, ypos, storlek och id för spotsen
  spots(float x, float y, int s, int id) {
    _x=x;
    _y=y;
    _s=s;
    // this._pid=id;
    this.id=id;
  }
  color  f=100;//färg
  void display(float sw) {
    stroke(255);
    fill(f);
    ellipse(_x+sw, _y, _s, _s);
  }

  /*
   kolla om något id är nertryckt. Vill fortsätta lägga till id'n till sum sålänge mousPressed==true och
   id't inte redan har blivit tillagt under denna mousepressed
   
   när sum sedan blir samma som sumOfPoints, kan man säga att man har klarat tasken
   */
  int pid=0;//senaste nertryckta id't
  boolean added=false;//kolla om id't har blivit tillagt

  boolean checkTouch() {
    if (mousePressed) {
      if (mousePressed&&dist(_x, _y, mouseX, mouseY)<_s/2) {
        if (added==false) {
          sum+=id;
          added=true;
          f=255;
        }
        else {
          //added=false;
          //f=100;
          //sum+=0;
        }
      }
    }
    else {
      f=100;
      added=false;
      //pid=0;
      sum=0;
    }

    if (added) {
      return true;
    }
    else {
      return false;
    }
  }
}
