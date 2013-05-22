//Uppdaterar skärmen efter var man rör på skärmen
boolean lightB=false;
boolean lightMan=true;
/*Nedan skickas knapptryckningarna
 istället för att kolla mousepressed får man kolla massa jävla events istället, konstanterna som står i siffror
 println("left "+rectLeft.pressed()+"   "+" right "+rectRight.pressed()+"   "+" jump "+rectJump.pressed());
 */
public synchronized void update() {
  /*****************SETUP*********************/
  if (currentLayout==0) {//setupscreen, besäm om man ska vara spelare 1 elr 2
    if (rectPlayer1.pressed()) {
      introText="You chose blue, please wait...";  
      bg=color(#020036);
      pc=color(#3E87EA);      
      if (!textField.getText().equals("")) {
        computerLAN=textField.getText();
      }
      playerID=8001;
      oscP5 = new OscP5(this, oscP5Port);//Port för inkommande meddelanden, måste stämma med den i unity
      myBroadcastLocation = new NetAddress(computerLAN, playerID);
      connect(broadcastPort, oscP5Port);

      println(textField.getText());
      pTimer=millis()+8000;
      widgetContainer.hide(); 
      currentLayout=1;
      println(computerLAN);
    }
    else if (rectPlayer2.pressed()) {
      introText="You chose red, please wait...";  
      bg=color(#360001);
      pc=color(#DB3C41);  
      if (!textField.getText().equals("")) {
        computerLAN=textField.getText();
      }    
      playerID=8002;
      oscP5 = new OscP5(this, oscP5Port);//Port för inkommande meddelanden, måste stämma med den i unity
      myBroadcastLocation = new NetAddress(computerLAN, playerID);
      connect(broadcastPort, oscP5Port);

      println(textField.getText());
      pTimer=millis()+8000;
      widgetContainer.hide(); 
      currentLayout=1;
    }
  }
  /*****************DEFAULT*********************/

  else if (currentLayout==1) {//aktivera knappar för default()
    if (rectLeft.pressed()) {//left
      moveLeft(-1);
    }
    else {
      moveLeft(0);
    }

    if (rectRight.pressed()) {//right
      moveRight(1);
    }
    else {
      moveRight(0);
    }

    if (rectJump.pressed()) {//right
      moveUp(1);
    }
    else {
      moveUp(0);
    }
    if (rectManipulate.pressed()) {//manip
      pushStyle();
      ellipseMode(CENTER);
      fill(100);
      ellipse(gxVal, gyVal, 20, 20);
      popStyle();
      manipulate(gxVal-displayWidth/1.88, (gyVal-displayHeight/1.65)*-1);//Flyttar 0,0 till mitten av knappen/ytan
      //manipulate(gxVal-400, (gyVal-350)*-1);//Flyttar 0,0 till mitten av knappen/ytan
      //println(gxVal-displayWidth/1.88+"   "+ (gyVal-displayHeight/1.65)*-1);
    }
    else {
      manipulate(0, 0);//Flyttar 0,0 till mitten av knappen/ytan
    }
  }
  /*****************FÖRSTA ACCEN*********************/

  else if (currentLayout==2) {//aktivera knappar för task1()
    if (rectBack.pressed()) {  
      currentLayout=1;
      changeButton=false;
    }
  }
}

