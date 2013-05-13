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
      if (textField.getText()!=null) {
        computerLAN=textField.getText();
      }
      playerID=8001;
      oscP5 = new OscP5(this, oscP5Port);//Port för inkommande meddelanden, måste stämma med den i unity
      myBroadcastLocation = new NetAddress(computerLAN, playerID);
      connect(broadcastPort, oscP5Port);

      rectLight = new Button("light", displayWidth/11.4, displayHeight/2.5, displayWidth/8.5, #22BAE3, #22BAE3);//light
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
      playerID=8002;
      oscP5 = new OscP5(this, oscP5Port);//Port för inkommande meddelanden, måste stämma med den i unity
      myBroadcastLocation = new NetAddress(computerLAN, playerID);
      connect(broadcastPort, oscP5Port);

      rectLight = new Button("light", displayWidth/11.4, displayHeight/2.5, displayWidth/8.5, #E82560, #E82560);//light
      println(textField.getText());
      widgetContainer.hide(); 
      pTimer=millis()+8000;
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
    if (rectLight.pressed()) {//right
      lightB=true;
      if (playerID==8001) {
        rectLight.setColor( #22BAE3, #22BAE3);//MAIPULATEBUTTON
      }
      if (playerID==8002) {
        rectLight.setColor( #E82560, #E82560);//MAIPULATEBUTTON
      }
    }
    else {
      lightB=false;
      rectLight.setColor(#FAF447, #FAF447);//light
    }
    if (rectManipulate.pressed()) {//manip
      pushStyle();
      ellipseMode(CENTER);
      fill(100);
      ellipse(gxVal, gyVal, 20, 20);
      popStyle();
      if (lightB) {
        moveSpotLight(gxVal-displayWidth/1.88, (gyVal-displayHeight/1.65)*-1);//Flyttar 0,0 till mitten av knappen/ytan
        //println("manioperkp");
      }
      else {
        manipulate(gxVal-displayWidth/1.88, (gyVal-displayHeight/1.65)*-1);//Flyttar 0,0 till mitten av knappen/ytan
        //println("lajjt");
      }
      //println(gxVal-displayWidth/1.88+"   "+ (gyVal-displayHeight/1.65)*-1);
    }
    else {
      manipulate(0, 0);//Flyttar 0,0 till mitten av knappen/ytan
    }
    if (rectChange.pressed()) {//manip
      if (changeButton) {
        if (changeTo==2) {
          moveRight(0);
          moveUp(0);
          moveLeft(0);
          currentLayout=2;
        }
        else if (changeTo==3) {
          moveRight(0);
          moveUp(0);
          moveLeft(0);
          currentLayout=3;
        }
      }
      if (explodeB) {
        currentLayout=1;
        //explode(1);
        prompt="   :)";
        vibe.vibrate(1000);
        explodeB=false;
      }
      else {
        //explode(0);
      }
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

