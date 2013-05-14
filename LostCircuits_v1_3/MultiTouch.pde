
public boolean surfaceTouchEvent(MotionEvent event) {
  int action = event.getActionMasked();
  final int numPointers = event.getPointerCount();
  final int action2 = event.getActionMasked();
  int actionIndex = event.getActionIndex();
  /*action2 kollar vilken typ av event som har hänt, typ om touchen har lämant eller precis börjat röra ytan 
   alla events finns här:
   http://developer.android.com/reference/android/view/MotionEvent.html#ACTION_CANCEL 
   */

  final int pointerIndex = (action & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;//håller reda på den senaste touchen+magic
  int pointerId = event.getPointerId(actionIndex);
  float xVal=event.getX(actionIndex);
  float yVal=event.getY(actionIndex);
  //Globala x och yvärden, använd helst inte
  gxVal=xVal;
  gyVal=yVal;

  if ( action2 == MotionEvent.ACTION_DOWN || action2 == MotionEvent.ACTION_POINTER_DOWN  ) {
    buttonsDown( pointerId, xVal, yVal );//Registrera finger när det har nått skärmens yta
  }
  else if ( action2 == MotionEvent.ACTION_MOVE || action2 == MotionEvent.ACTION_MOVE ) {
    buttonsDown( pointerId, xVal, yVal );//Registrera finger när det har nått en knapps yta
    buttonsMove( pointerId, xVal, yVal );//Uppdatera fingrets posititon om det är kvar inuti knappen
  }
  else if ( action2 == MotionEvent.ACTION_UP || action2 == MotionEvent.ACTION_POINTER_UP ) {
    buttonsUp( pointerId, xVal, yVal );//Glöm knappen om fingret lyfts
  }
  return super.surfaceTouchEvent(event);
}

void buttonsDown(int id, float x, float y) {
  rectLeft.set(id, x, y);
  rectRight.set(id, x, y);
  rectJump.set(id, x, y);
  rectPlayer1.set(id, x, y);
  rectPlayer2.set(id, x, y);
  rectManipulate.set(id, x, y);
}

void buttonsMove(int id, float x, float y) {
  rectLeft.update(id, x, y);
  rectRight.update(id, x, y);
  rectJump.update(id, x, y);
  rectPlayer1.update(id, x, y);
  rectPlayer2.update(id, x, y);
  rectManipulate.update(id, x, y);
}

void buttonsUp(int id, float x, float y) {
  rectLeft.unset(id, x, y);
  rectRight.unset(id, x, y);
  rectJump.unset(id, x, y);
  rectPlayer1.unset(id, x, y);
  rectPlayer2.unset(id, x, y);
  rectManipulate.unset(id, x, y);
}

