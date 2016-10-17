// STUDENT'S NAME: PHUC (ZURIE) MAI
// PLEASE PLACE YOUR CODE IN THIS TAB

void student_displayDancer(pt H, pt K, pt A, pt E, pt B, pt T) // displays dancer using dimensions
  {
  caplet(H,_rH,K,_rK);
  caplet(K,_rK,A,_rA);
  caplet(A,_rA,E,_rE);
  caplet(E,_rE,B,_rB);
  caplet(B,_rB,T,_rT);
  caplet(A,_rA,B,_rB);
  noFill(); pen(magenta,2); edge(H,P(H,R(V(0,100),_hipAngle)));
  }

// Recompute global dancer points (_H,..._T) from Hip center, Ball center, leg dimensions, and angle a btweeen HB and HK
void student_computeDancerPoints
    (
    pt H,     // hip center
    pt B,     // ball center 
    pt T,     // knee center 
    pt E,     // ankle center 
    pt A,     // heel center 
    pt K,     // toe center 
    float a,   // angle between HB and HK
    float floor // the ground line
    
    )
  {
    _H.setTo(H);
    _B.setTo(B); 
    _T.setTo(P.G[5]);
    _E.setTo(P.G[3]);
    _K.setTo(P.G[1]); 
    _A.setTo(P.G[2]); 
    
    floor = height - 50;
    _B.y = floor -_rB; // verticle distance of _rB above ground
    _T.x = _B.x + _bt;
    _T.y = floor;     // toe is on the ground 
    _E.y = floor- (_eb * sin(_heelAngle));
    _E.x = _B.x - (_eb * cos(_heelAngle));
    _A = triangleTip(_B,_ab,_E,_ae);
    _K = triangleTip(_A, _ka, _H, _hk);
    
    H.setTo(_H); 
    B.setTo(_B); 
    T.setTo(_T); 
    K.setTo(_K); 
    A.setTo(_A); 
    E.setTo(_E);
   }
   
void caplet(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  show(A,rA);
  show(B,rB);
  float a = 0.0;
  float b = 0.0;
  float cb = 0.0;
  // replace the line below with your code to draw the proper caplet (cone) that the function displays th convex hull of the two disks
  //if(rB > rA){ 
  //  a = rB - rA;
  //  b = rB;
  //}else{ 
  //  a = rA - rB;
  //  b = rA;
  //}
  //float cd = sqrt(sq(n(V(A,B)))-sq(a));
  //if(rB > rA){
  //  cb = sqrt(sq(cd)+sq(rA));
  //}else{
  //  cb = sqrt(sq(cd)+sq(rB));
  //}
  
  //b = sqrt(sq(n(V(A,B))) - sq(a));
  //pt C = triangleTip(A,cb,B,b);
  //vec AC = U(A,C);
  //vec BC = U(B,C);
  //vec AC_rot = R(AC);
  //pt A1 = P(A,rA,AC_rot);
  //pt B1 = P(B,rB,BC);
  //pt A2 = P(A,-rA,AC_rot);
  //pt B2 = P(B,-rB,BC);
  //beginShape(); v(B1); v(B2); v(A2); v(A1); endShape(CLOSE);
  
  cone(A,rA,B,rB); 
  }
  
void cone(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  vec T = U(A,B);
  vec N = R(T);
  pt LA = P(A,-rA,N);
  pt LB = P(B,-rB,N);
  pt RA = P(A,rA,N);
  pt RB = P(B,rB,N);
  beginShape(); v(LB); v(RB); v(RA); v(LA); endShape(CLOSE);
  }
  
pt triangleTip(pt A, float a, pt B, float b){
  float x = 0.0;
  float y = 0.0;
  pt C = P();
  //vec AB = V(A,B);
  float l = sqrt(sq(B.x-A.x)+sq(B.y-A.y));
  x = (sq(b)-sq(a)-sq(l))/(-2*l);
  y = sqrt(sq(a)-sq(x));
  C = P(A, x, U(A,B), y, R(U(A,B)));
  return C;
}

    //(
    //pt H,     // hip center
    //float hk, // distance from to 
    //pt K,     // knee center 
    //float ka, // distance from to 
    //pt A,     // ankle center 
    //float ae, // distance from to 
    //pt E,     // heel center
    //float eb, // distance from to 
    //float ab, // distance from to 
    //pt B,     // ball center 
    //float bt, // distance from to 
    //pt T,     // toe center
    //float a   // angle between HB and HK
    //)