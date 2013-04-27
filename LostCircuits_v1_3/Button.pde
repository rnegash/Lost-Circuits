/*
Knappklassen
 */

class Button {

  float x, y;
  float w, h;
  float rCorners;

  boolean pressed;

  int lastPointerId = -1;

  color basecolor, highlightcolor;
  color currentcolor;

  String tag = "";

  Button( String tag, float x, float y, float w, color icolor, color ihighlight) {
    this.tag = tag;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = w;

    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
  }

  Button( String tag, float x, float y, float w, float h, color icolor, color ihighlight, float rCorners) {
    this.tag = tag;

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.rCorners=rCorners;
    basecolor = icolor;
    highlightcolor = ihighlight;

    currentcolor = basecolor;
  }

  void display() {
    stroke(150);
    strokeWeight(1.5);
    fill(currentcolor);
    rect(x, y, w, h, rCorners);
  }
  //Sätt id på en knapp när ett funger trycker på den
  void set(int id, float _x, float _y) {
    if ( _x > x && _x < x + w ) {
      if ( _y > y && _y < y + h ) {
        lastPointerId = id;  
        pressed = true;
        currentcolor = highlightcolor;
      }
    }
  }
  //Uppdatera knappen

  void update(int id, float _x, float _y) {
    if ( lastPointerId == id ) {
      if ( _x > x && _x < x + w ) {
        if ( _y > y && _y < y + h ) {
          pressed = true;
          lastPointerId = id;
          currentcolor = highlightcolor;
          return;
        }
      }
      lastPointerId = -1;
      pressed = false;
      currentcolor = basecolor;
    }
  }
  //Glöm att knappen är nertryckt när man lyfter fingret
  void unset(int id, float _x, float _y) {
    if ( lastPointerId == id ) {
      if ( _x > x && _x < x + w ) {
        if ( _y > y && _y < y + h ) {      
          lastPointerId = -1;  
          pressed = false;
          currentcolor = basecolor;
        }
      }
    }
  }

  void setColor(color newBColor, color newHColor) {
    basecolor = newBColor;
    highlightcolor = newHColor;
  }
  void setColor(color newBColor) {
    basecolor = newBColor;
  }

  boolean pressed() {
    return pressed;
  }
}

