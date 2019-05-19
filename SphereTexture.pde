class SphereTexture {
  PMatrix3D matrix;
  PVector normal;
  PVector original;
//  PVector[] kryptis = new PVector[6];
  PImage t;
  int r;
  int index;
  ArrayList arotate = new ArrayList();
  //int angleX;
  //int angleY;
  //int angleZ;

  SphereTexture(PMatrix3D matrix, PVector normal, PImage t, int r, int index) {
    this.matrix = matrix;
    this.normal = normal;
    this.original = new PVector(normal.x, normal.y, normal.z);
    this.original = new PVector(normal.x, normal.y, normal.z);
    //this.kryptis = new PVector(normal.x, -normal.y, normal.z);
    
    this.t = t;
    this.r = r;
    //this.angleX = 0;
    //this.angleY = 0;
    //this.angleZ = 0;
    this.index = index;
    
    //if (index==0) println("init index="+index+" x="+normal.x+" y="+normal.y+" z="+normal.z);
  }


  void turnZ(float angle) {
    //PVector v2 = new PVector();
    //v2.x = round(normal.x * cos(angle) - normal.y * sin(angle));
    //v2.y = round(normal.x * sin(angle) + normal.y * cos(angle));
    //v2.z = round(normal.z);
    //normal = v2;
    //angleZ += round(angle / HALF_PI);
    //angleZ %= 4;
    //if (index==0) println("turnZ index="+index+" angle="+angle+" angleX="+angleX+" angleY="+angleY+" angleZ="+angleZ+" x="+normal.x+" y="+normal.y+" z="+normal.z+" ox="+original.x+" oy="+original.y+" oz="+original.z);
    //if (index==0) println("turnZ index="+index+" angle="+angle+" x="+normal.x+" y="+normal.y+" z="+normal.z+" ox="+original.x+" oy="+original.y+" oz="+original.z);
    arotate.add(round(angle / HALF_PI)+9);
  }

  void turnY(float angle) {
    //PVector v2 = new PVector();
    //v2.x = round(normal.x * cos(angle) - normal.z * sin(angle));
    //v2.z = round(normal.x * sin(angle) + normal.z * cos(angle));
    //v2.y = round(normal.y);
    //normal = v2;
    //angleY += round(angle / HALF_PI);
    //angleY %= 4;
    //if (index==0) println("turnY index="+index+" angle="+angle+" x="+normal.x+" y="+normal.y+" z="+normal.z+" ox="+original.x+" oy="+original.y+" oz="+original.z);
    arotate.add(round(angle / HALF_PI)+5);
  }

  void turnX(float angle) {
    //PVector v2 = new PVector();
    //v2.y = round(normal.y * cos(angle) - normal.z * sin(angle));
    //v2.z = round(normal.y * sin(angle) + normal.z * cos(angle));
    //v2.x = round(normal.x);
    //normal = v2;
    //angleX += round(angle / HALF_PI);
    //angleX %= 4;
    //if (index==0) println("turnX index="+index+" angle="+angle+" angleX="+angleX+" angleY="+angleY+" angleZ="+angleZ+" x="+normal.x+" y="+normal.y+" z="+normal.z+" ox="+original.x+" oy="+original.y+" oz="+original.z);
    //if (index==0) println("turnX index="+index+" angle="+angle+" x="+normal.x+" y="+normal.y+" z="+normal.z+" ox="+original.x+" oy="+original.y+" oz="+original.z);
    arotate.add(round(angle / HALF_PI));
  }

  void update(int x, int y, int z) {
    matrix.reset(); 
    matrix.translate(x, y, z);
    this.normal.x = x;
    this.normal.y = y;
    this.normal.z = z;
  }

  void show() {
    float changeU=t.width/(float)(numPointsW-1); 
    float changeV=t.height/(float)(numPointsH-1); 
    float u=0;  // Width variable for the texture
    float v=0;  // Height variable for the texture
//    if(angleX != 0) println("angleX="+angleX);
//    if(angleY != 0) println("angleY="+angleY);
//    if(angleZ != 0) println("angleZ="+angleZ);
  
    //if (index==0) println("turnX index="+index+" angleX="+angleX+" x="+normal.x+" y="+normal.y+" z="+normal.z);
    push();
    //rotateX(angleX * HALF_PI);
    //rotateY(angleY * HALF_PI);
    //rotateZ(angleZ * HALF_PI);
    for(int i=arotate.size()-1; i >= 0 ; i--) {
      int angle = (int)arotate.get(i);
      //println("i="+i+" angle="+angle);
      if (angle>6) rotateZ((angle - 9) * HALF_PI);
      else if (angle>2) rotateY((angle - 5) * HALF_PI);
      else rotateX(angle * HALF_PI);
    }
    //if (index == 0) println(" angleX="+angleX+" angleY="+angleY+" angleZ="+angleZ);
    beginShape(TRIANGLE_STRIP);
    texture(t);
    for (int i=0; i<(numPointsH-1); i++) {  // For all the rings but top and bottom
      // Goes into the array here instead of loop to save time
      float coory=coorY[i];
      float cooryPlus=coorY[i+1];
  
      float multxz=multXZ[i];
      float multxzPlus=multXZ[i+1];
  
      for (int j=0; j<numPointsW; j++) { // For all the pts in the ring
        normal(-coorX[j]*multxz, -coory, -coorZ[j]*multxz);
        if (coorX[j]*multxz >= (limits[(int)original.x + 1] - epsilon) && coorX[j]*multxz < (limits[(int)original.x + 2] + epsilon) && 
            coorY[i] >= (limits[(int)original.y + 1] - epsilon) && coorY[i] < (limits[(int)original.y + 2] + epsilon) && 
            coorZ[j]*multxz >= (limits[(int)original.z + 1] - epsilon) && coorZ[j]*multxz < (limits[(int)original.z + 2] + epsilon) /*&& index == 0*/)
        {
          vertex(coorX[j]*multxz*r, coory*r, coorZ[j]*multxz*r, u, v);
          normal(-coorX[j]*multxzPlus, -cooryPlus, -coorZ[j]*multxzPlus);
          vertex(coorX[j]*multxzPlus*r, cooryPlus*r, coorZ[j]*multxzPlus*r, u, v+changeV);
        }
        u+=changeU;
      }
      v+=changeV;
      u=0;
    }
    endShape();
    pop();
  }
}
