import oscP5.*;
import netP5.*;
import java.awt.*;
import android.os.Build;
import android.os.Bundle;
import android.view.WindowManager;
import android.view.MotionEvent;
import ketai.sensors.*;
import ketai.ui.*;
import java.net.InetAddress;
import java.util.Enumeration;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.text.NumberFormat;
import apwidgets.*;
import java.util.Iterator;

APMediaPlayer moveSound, jumpSound, manipulateSound, switchSound;
KetaiVibrate vibe;
KetaiSensor sensor;
OscP5 oscP5, oscP5New;
NetAddress myBroadcastLocation; 
Button rectLeft, rectRight, rectJump, rectBack, rectChange, rectLight, rectPlayer1, rectPlayer2, rectPF1, rectPF2, rectPF3;
Button rectManipulate;

APWidgetContainer widgetContainer; 
APEditText textField;



/*
*Datorns lokala ip, KOLLA ATT DEN STÄMMEMERERETERERERERERER
 
 */
//String computerLAN="192.168.1.2";
//String computerLAN="192.168.1.120";
String computerLAN="10.2.7.242";
int playerID;
float accY;//Värdet som skickas för accelerometern 

String serial = null;
boolean locked = false;
float toggle = 0;
String nuv="";
int u=0, d=0, l=0, r=0;
public static int currentLayout;
//int action2, actionIndex;
int back=0;
float accelerometerX, accelerometerY, accelerometerZ;
float gxVal, gyVal;
int changeTo;
public static boolean changeButton;
int oscP5Port;
int broadcastPort;
String myIP = null;
color bg=5, pc;
static float screenX, screenY;
color buttoncolor = color(93);
color highlight = color(175);
color buttoncolor2 = color(80);

void setup() {
  orientation(LANDSCAPE);//håll telefonen som en hamburgare
  serial = Build.SERIAL;//telefonens serialkod, kommer att bli dess id
  /*
  *gör portarna """"random""""
   */
  int res = 0;
  for (int i=0; i < serial.length(); i++) {
    char c = serial.charAt(i);
    if (c < '0' || c > '9') continue;
    res = res + c;
  }
  oscP5Port=res*50;
  broadcastPort=res*60;

  screenX=displayWidth;
  screenY=displayHeight;

  sensor = new KetaiSensor(this);
  changeButton=false;//boolean för om man vill byta till acc-layout, blir true när spelaren går in i triggern
  vibe = new KetaiVibrate(this);//Starta vibratorn, mmmmm, kolla vibratorpermission om det inte fungerar. Används just nu i oscEvent()
  sensor.start();//ketai, starta för att få access till sensorerna
  //frameRate(15);

  loadMediaFiles();
  // Define and create buttons
  //Knappar för setupScreen();
  rectPlayer1 = new Button("p1", displayWidth/3, displayHeight/2, displayWidth/8, #152BE8, #17238E);//blueplayer
  rectPlayer2 = new Button("p2", displayWidth/2, displayHeight/2, displayWidth/8, #F51414, #6F1919);//redplayer
  //Knappar för default();
  rectLeft = new Button("left", displayWidth/800, displayHeight/9.6, displayWidth/8, buttoncolor, highlight);//left
  rectRight = new Button("right", displayWidth/7.8, displayHeight/9.6, displayWidth/8, buttoncolor, highlight);//right
  rectJump = new Button("jump", displayWidth/1.22, displayHeight/15, displayWidth/6, buttoncolor2, highlight);//up

  rectManipulate = new Button("manip", displayWidth/3.5, displayHeight/3.2, displayWidth/2, displayHeight/1.6, 50, 30, 7);//up
  rectChange = new Button("change", displayWidth/1.39, displayHeight/6.8, displayWidth/15, #4DAA43, #2F9B24);//change
  //Knappar för task1();
  rectBack = new Button("back", displayWidth/1.10, displayHeight/9.6, displayHeight/9, #B72929, #C92B2B);//bakknapp för taskscenen just nu

  /*
  *hämta telefonens ip
   */
  try {
    for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {
      NetworkInterface intf = en.nextElement();
      for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {
        InetAddress inetAddress = enumIpAddr.nextElement();
        if (!inetAddress.isLoopbackAddress()) {
          myIP = inetAddress.getHostAddress().toString();
        }
      }
    }
  } 
  catch (SocketException ex) {
  }

  widgetContainer = new APWidgetContainer(this); //create new container for widgets
  textField = new APEditText( displayWidth/40, int(displayHeight/1.24), int(displayWidth/3.2), displayHeight/6);
  widgetContainer.addWidget(textField); //place textField in container

  currentLayout=0;//vilken scen man börjar på, kolla switchen i draw()
} 

void draw() {
  update();//Hanterar allt som ska hända när vi trycker på knapparna, kolla Updatefliken
  background(bg);
  //Bakgrundsmönstret
  for (int x=0;x<width;x+=displayWidth/8) {
    for (int y=0;y<height;y+=displayHeight/2.4) {
      pattern(x, y);
    }
  }
  /*Denna switchen håller koll på vilken layout om visas på skärmen, 
   case 1=default layout, case 2= framtida speciallayout, som nu heter void task1()
   så defaultScene() är en layout som körs i draw(), task1() är en annan osv... 
   */
  switch(currentLayout) {
  case 0:
    setupScreen();
    break;
  case 1:
    defaultLayout();
    break;
  case 2: 
    svetsTask();
    break;
  }
}

//Bakgrundsmönstret

void pattern(int x, int y) {
  pushStyle();
  stroke(255, 100);
  line(x, y, x, y+displayHeight/4.8);
  line(x, y+displayHeight/4.8, x+displayWidth/8, y+displayHeight/2.4);
  fill(0);
  ellipseMode(CENTER);
  ellipse(x, y, 20, 20);
  popStyle();
}

void loadMediaFiles() {
  moveSound = new APMediaPlayer(this); //create new APMediaPlayer
  moveSound.setMediaFile("move.wav");//set the file (files are in data folder)
  moveSound.setLooping(true); 
  moveSound.setVolume(0.3, 0.3);

  jumpSound = new APMediaPlayer(this); //create new APMediaPlayer
  jumpSound.setMediaFile("jump.wav");//set the file (files are in data folder)
  jumpSound.setLooping(true); 
  jumpSound.setVolume(0.9, 0.9);

  manipulateSound = new APMediaPlayer(this); //create new APMediaPlayer
  manipulateSound.setMediaFile("manipulate.mp3");//set the file (files are in data folder)
  manipulateSound.setLooping(true); 
  manipulateSound.setVolume(0.5, 0.5);

  switchSound = new APMediaPlayer(this); //create new APMediaPlayer
  switchSound.setMediaFile("lightSwitch.wav");//set the file (files are in data folder)
  switchSound.setLooping(false); 
  switchSound.setVolume(0.05, 0.05);
}

void onCreate(Bundle bundle) {
  super.onCreate(bundle);
  getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}//Gör så att skärmen inte kan sleepa

public void onDestroy() {
  super.onDestroy(); //call onDestroy on super class
  if (moveSound!=null) { //must be checked because or else crash when return from landscape mode
    moveSound.release(); //release the player
  }
  if (jumpSound!=null) { //must be checked because or else crash when return from landscape mode
    jumpSound.release(); //release the player
  }
  if (manipulateSound!=null) { //must be checked because or else crash when return from landscape mode
    manipulateSound.release(); //release the player
  }
  if (switchSound!=null) { //must be checked because or else crash when return from landscape mode
    switchSound.release(); //release the player
  }
}
/*//Responsivitetetet
 public static float pX(float x) {
 float nX=0;
 nX=screenX/x;
 nX=screenX/nX;
 return nX;
 }
 public static float pY(float y) {
 float nY=0;
 nY=screenY/y;
 nY=screenY/nY;
 return nY;
 }
 */
