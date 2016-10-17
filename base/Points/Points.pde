// Template for 2D projects
// Author: Jarek ROSSIGNAC
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
pts P_onFloor = new pts(); // class containing array of 4 points on the floor
float t=0, f=0;
boolean animate=false, fill=false, timing=false;
boolean showLetters=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points
float bet2leg=0;// distance between the 2 legs (always maintain 1/3, 2/3 ratio)
float _hipAngle=-PI/6, _heelAngle=PI/5;
pt _H=P(), _K=P(), _A=P(), _E=P(), _B=P(), _T=P(); // centers of Hip, Knee, Ankle, hEel, Ball, Toe
float _rH=100, _rK=50, _rA=20, _rE=25, _rB=15, _rT=5; // radii of Hip, Knee, Ankle, hEel, Ball, Toe
//float _rH=200, _rK=20, _rA=20, _rE=25, _rB=15, _rT=5; // radii of Hip, Knee, Ankle, hEel, Ball, Toe
// leg measures (to update press '/' and copy print here):
float _hk=319.979, _ka=266.46463, _ae=28.718777, _eb=117.23831, _ab=113.9619, _bt=44.75581;
float _h=150; // height of _H
boolean SR=true; // right foot is the support foot
boolean SL=true; // left foot is the support foot
//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(700, 700);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare(); // declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
  P_onFloor.declare();  
  //P.resetOnCircle(6); // sets P to have 4 points and places them in a circle on the canvas
  P.loadPts("data/pts");  // loads points form file saved with this program
  P_onFloor.loadPts("data/floor_pts");
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(white); // clear screen and paints white background
    pen(grey,3); line(0,height-50,width,height-50);  // show ground line (floor)
    
    pt H=P.G[0], K=P.G[1], A=P.G[2], E=P.G[3], B=P.G[4], T=P.G[5]; // local copy of dancer left leg points from points of Polyloop P
    // Hip       Knee      Ankle    hEel       Ball      Toe
    pt K1=P.G[1], A1=P.G[2], E1=P.G[3], B1=P.G[6], T1=P.G[5]; // local copy of dancer right leg points from points of Polyloop P
    // rKnee      rAnkle     rhEel      rBall      rToe
    
    pt P0=P_onFloor.G[0], P1=P_onFloor.G[1], P2=P_onFloor.G[2], P3=P_onFloor.G[3];
    P0.y = height-50; P1.y = height-50; P2.y = height-50; P3.y = height-50; // set 4 points on the floor
    showId(P0,"P0"); showId(P1,"P1"); showId(P2,"P2"); showId(P3,"P3");
    
 //*****************************************************************************
// LEFT LEG
//*****************************************************************************   
    B.x = P1.x;
    student_computeDancerPoints(H,B,T,E,A,K,_hipAngle,_heelAngle); // computes _H,_K,_A,_E,_B,_T  from measures and _hipAngle
    noStroke(); fill(green);  student_displayDancer(H,K,A,E,B,T);
    //noFill(); pen(red,6); student_displayDancer(_H,_K,_A,_E,_B,_T);   // draw the cone() outline
    noFill(); pen(black,4); 
    //P.drawCurve(); 
    edge(A,B);  // add (foot top) edge from Ankle to Ball
    edge(A,E); 
    edge(E,B); 
    if(showLetters) 
      { 
      pen(black,2); 
      showId(K,"LK"); showId(A,"LA"); showId(E,"LE"); showId(B,"LB");showId(T,"LT");
      }
//*****************************************************************************
// RIGHT LEG
//***************************************************************************** 
    B1.x = P0.x;
    student_computeDancerPoints(H,B1,T1,E1,A1,K1,_hipAngle,_heelAngle); // computes _H,_K,_A,_E,_B,_T  from measures and _hipAngle
    noStroke(); fill(yellow);  student_displayDancer(H,K1,A1,E1,B1,T1);
    ////noFill(); pen(red,6); student_displayDancer(H,K,A,E,B,T); // draw the cone()
    noFill(); pen(red,4); 
    //P.drawCurve(); 
    //edge(A,B);   
    if(showLetters) 
      { 
      pen(blue,2); 
      showId(H,"H"); 
      pen(red,2); 
      showId(K1,"RK"); showId(A1,"RA"); showId(E1,"RE"); showId(B1,"RB");showId(T1,"RT");
      }
      
//*****************************************************************************
// POSITION OF LEGS ON FLOOR
//*****************************************************************************    
    bet2leg = d(P0,P1);
    if(P0.x<P1.x){
      H.x = P0.x + (bet2leg/3);
    }else{
      H.x = P1.x + (bet2leg/3);
    }

  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  