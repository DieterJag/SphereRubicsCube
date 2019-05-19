// Rubiks Cube 3
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/142.3-rubiks-cube.html
// https://youtu.be/8U2gsbNe1Uo


void turnZ(int index, int dir) {
  //for (int i = 0; i < cube.length; i++) {
  //  Cubie qb = cube[i];
  //  if (qb.z == index) {
  //    PMatrix2D matrix = new PMatrix2D();
  //    matrix.rotate(dir*HALF_PI);
  //    matrix.translate(qb.x, qb.y);
  //    qb.update(round(matrix.m02), round(matrix.m12), round(qb.z));
  //    qb.turnFacesZ(dir);
  //  }
  //}
  //println("turnZ index="+index);
  for (int i = 0; i < sphereTexture.length; i++) {
    SphereTexture qb = sphereTexture[i];
    if (qb.normal.z == index) {
      //println("i="+i);
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.normal.x, qb.normal.y);
      qb.update(round(matrix.m02), round(matrix.m12), round(qb.normal.z));
      qb.turnZ(dir*HALF_PI);
    }
  }
}

void turnY(int index, int dir) {
  //for (int i = 0; i < cube.length; i++) {
  //  Cubie qb = cube[i];
  //  if (qb.y == index) {
  //    PMatrix2D matrix = new PMatrix2D();
  //    matrix.rotate(dir*HALF_PI);
  //    matrix.translate(qb.x, qb.z);
  //    qb.update(round(matrix.m02), qb.y, round(matrix.m12));
  //    qb.turnFacesY(dir);
  //  }
  //}
  //println("turnY index="+index);
  for (int i = 0; i < sphereTexture.length; i++) {
    SphereTexture qb = sphereTexture[i];
    if (qb.normal.y == index) {
      //println("i="+i);
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.normal.x, qb.normal.z);
      qb.update(round(matrix.m02), round(qb.normal.y), round(matrix.m12));
      qb.turnY(-dir*HALF_PI);
    }
  }
}

void turnX(int index, int dir) {
  //for (int i = 0; i < cube.length; i++) {
  //  Cubie qb = cube[i];
  //  if (qb.x == index) {
  //    PMatrix2D matrix = new PMatrix2D();
  //    matrix.rotate(dir*HALF_PI);
  //    matrix.translate(qb.y, qb.z);
  //    qb.update(qb.x, round(matrix.m02), round(matrix.m12));
  //    qb.turnFacesX(dir);
  //  }
  //}
  //println("turnX index="+index);
  for (int i = 0; i < sphereTexture.length; i++) {
    SphereTexture qb = sphereTexture[i];
    if (qb.normal.x == index) {
      //println("i="+i);
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.normal.y, qb.normal.z);
      qb.update(round(qb.normal.x), round(matrix.m02), round(matrix.m12));
      qb.turnX(dir*HALF_PI);
    }
  }
}
