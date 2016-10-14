// NAME: Phuc (Zurie) Mai
// PLEASE PLACE YOUR CODE IN THIS TAB

void student_displayDancer(pt H, pt K, pt A, pt E, pt B, pt T) // displays dancer using dimensions
  {
  caplet(H,_rH,K,_rK);
  //caplet(K,_rK,A,_rA);
  //caplet(A,_rA,E,_rE);
  //caplet(E,_rE,B,_rB);
  //caplet(B,_rB,T,_rT);
  //caplet(A,_rA,B,_rB);
  noFill(); pen(magenta,2); edge(H,P(H,R(V(0,100),_hipAngle)));
  }

// Recompute global dancer points (_H,..._T) from Hip center, Ball center, leg dimensions, and angle a btweeen HB and HK
void student_computeDancerPoints
    (
    pt H,     // hip center
    pt B,     // ball center 
    float a   // angle between HB and HK
    )
  {
   _H.setTo(H);   
   _B.setTo(B); 
   _K=P.G[1]; 
   _A=P.G[2]; 
   _E=P.G[3]; 
   _T=P.G[5]; 
   }
   
void caplet(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  show(A,rA);
  show(B,rB);
  float a = 0.0;
  float b = 0.0;
  // replace the line below with your code to draw the proper caplet (cone) that the function displays th convex hull of the two disks
  if(rB > rA){ 
    a = rB - rA;
  }else{ 
    a = rA - rB;
  }
  b = sqrt(sq(n(V(A,B))) - sq(a));
  pt C = triangleTip(A,a, B, b);
  pt B1 = P(B, rB, V(B,C));
  pt A1 = P(A, rA, R(V(A,C)));
  cone(A1,a,B1,b); 
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
  pt C = P(x,y);
  vec AB = V(A,B);
  float l = n(AB);
  x = (sq(b)-sq(a)+sq(l))/(2*l);
  y = sqrt(sq(b)-sq(x));
  C = P(B, x, V(B,A), y, R(V(B,A)));
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