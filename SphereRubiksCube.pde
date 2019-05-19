// Rubiks Cube 3
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/142.3-rubiks-cube.html
// https://youtu.be/8U2gsbNe1Uo
// Dieter Jagutis 2018-05-19

import peasy.*;

PeasyCam cam;

float speed = 0.2;
int dim = 3;
//Cubie[] cube = new Cubie[dim*dim*dim];
SphereTexture[] sphereTexture = new SphereTexture[dim*dim*dim];

Move[] allMoves = new Move[] {
  new Move(0, 1, 0, 1), 
  new Move(0, 1, 0, -1), 
  new Move(0, -1, 0, 1), 
  new Move(0, -1, 0, -1), 
  new Move(1, 0, 0, 1), 
  new Move(1, 0, 0, -1), 
  new Move(-1, 0, 0, 1), 
  new Move(-1, 0, 0, -1), 
  new Move(0, 0, 1, 1), 
  new Move(0, 0, 1, -1), 
  new Move(0, 0, -1, 1), 
  new Move(0, 0, -1, -1) 
};

ArrayList<Move> sequence = new ArrayList<Move>();
int counter = 0;

boolean started = false;

Move currentMove;

int ptsW, ptsH;

PImage img;

int numPointsW;
int numPointsH_2pi; 
int numPointsH;

float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;
float[] limits;
float epsilon = 0.008;
int countFr = 0;

void setup() {
  size(640, 640, P3D);
  //fullScreen(P3D);
  limits = new float[4];
  limits[0] = -1;
  limits[1] = -1.0/3.0;
  limits[2] = 1.0/3.0;
  limits[3] = 1;
  cam = new PeasyCam(this, 400);

  img = loadImage("sphere.jpg");
  int index = 0;
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        sphereTexture[index] = new SphereTexture(matrix, new PVector(x, y, z), img, 180, index);
        index++;
      }
    }
  }

  ptsW=480;
  ptsH=480;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);

  for (int i = 0; i < 25; i++) {
    int r = int(random(allMoves.length));
    Move m = allMoves[r];
    sequence.add(m);
  }

  currentMove = sequence.get(counter);
//  currentMove = allMoves[11];

  for (int i = sequence.size()-1; i >= 0; i--) {
    Move nextMove = sequence.get(i).copy();
    nextMove.reverse();
    sequence.add(nextMove);
  }

  currentMove.start();
}

float rotx = 0;
float roty = 0;
float rotz = 0;

void draw() {
  background(51); 

  cam.beginHUD();
  fill(255);
  textSize(32);
  text(counter, 50, 50);
  cam.endHUD();

  rotateX(-0.5);
  rotateY(0.4);
  rotateZ(0.1);
  int step =(frameCount/100)%3;
  if (step == 0) rotx += 0.002;
  if (step == 1) roty += 0.002;
  if (step == 2) rotz += 0.002;
  rotateX(rotx * HALF_PI);
  rotateY(roty * HALF_PI);
  rotateZ(rotz * HALF_PI);

  noStroke();
  if (currentMove != null) currentMove.update();
  else  for (int i = 0; i < sphereTexture.length; i++) {
    sphereTexture[i].show();
  }

  if (currentMove.finished()) {
    if (counter < sequence.size()-1) {
      counter++;
      currentMove = sequence.get(counter);
      currentMove.start();
    }
  }

  if (currentMove != null) for (int i = 0; i < sphereTexture.length; i++) {
    push();
    if (abs(sphereTexture[i].normal.z) > 0 && sphereTexture[i].normal.z == currentMove.z) {
      rotateZ(currentMove.angle);
    } else if (abs(sphereTexture[i].normal.x) > 0 && sphereTexture[i].normal.x == currentMove.x) {
      rotateX(currentMove.angle);
    } else if (abs(sphereTexture[i].normal.y) > 0 && sphereTexture[i].normal.y == currentMove.y) {
      rotateY(-currentMove.angle);
    }   
    sphereTexture[i].show();
    pop();
  }
}

void initializeSphere(int numPtsW, int numPtsH_2pi) {

  // The number of points around the width and height
  numPointsW=numPtsW+1;
  numPointsH_2pi=numPtsH_2pi;  // How many actual pts around the sphere (not just from top to bottom)
  numPointsH=ceil((float)numPointsH_2pi/2)+1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)

  coorX=new float[numPointsW];   // All the x-coor in a horizontal circle radius 1
  coorY=new float[numPointsH];   // All the y-coor in a vertical circle radius 1
  coorZ=new float[numPointsW];   // All the z-coor in a horizontal circle radius 1
  multXZ=new float[numPointsH];  // The radius of each horizontal circle (that you will multiply with coorX and coorZ)

  for (int i=0; i<numPointsW ;i++) {  // For all the points around the width
    float thetaW=i*2*PI/(numPointsW-1);
    coorX[i]=sin(thetaW);
    coorZ[i]=cos(thetaW);
  }
  
  for (int i=0; i<numPointsH; i++) {  // For all points from top to bottom
    if (int(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {  // If the numPointsH_2pi is odd and it is at the last pt
      float thetaH=(i-1)*2*PI/(numPointsH_2pi);
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=0;
    } 
    else {
      //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
      float thetaH=i*2*PI/(numPointsH_2pi);

      //PI+ below makes the top always the point instead of the bottom.
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=sin(thetaH);
    }
  }
}
