 // Rubiks Cube 3
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/142.3-rubiks-cube.html
// https://youtu.be/8U2gsbNe1Uo


void keyPressed() {
  if (key == ' ') {
    currentMove.start();
    counter = 0;
  }
  applyMove(key);
}

void applyMove(char move) {
  switch (move) {
  case 'd': 
    //turnZ(1, 1);
    currentMove = allMoves[0];
    currentMove.start();
    break;
  case 'D': 
    //turnZ(1, -1);
    currentMove = allMoves[1];
    currentMove.start();
    break;  
  case 'u': 
    //turnZ(-1, 1);
    currentMove = allMoves[2];
    currentMove.start();
    break;
  case 'U': 
    //turnZ(-1, -1);
    currentMove = allMoves[3];
    currentMove.start();
    break;
  case 'r': 
    //turnY(1, 1);
    currentMove = allMoves[4];
    currentMove.start();
    break;
  case 'R': 
    //turnY(1, -1);
    currentMove = allMoves[5];
    currentMove.start();
    break;
  case 'l': 
    //turnY(-1, 1);
    currentMove = allMoves[6];
    currentMove.start();
    break;
  case 'L': 
    //turnY(-1, -1);
    currentMove = allMoves[7];
    currentMove.start();
    break;
  case 'f': 
    //turnX(-1, 1);
    currentMove = allMoves[8];
    currentMove.start();
    break;
  case 'F': 
    //turnX(-1, -1);
    currentMove = allMoves[9];
    currentMove.start();
    break;
  case 'b': 
    //turnX(1, 1);
    currentMove = allMoves[10];
    currentMove.start();
    break;
  case 'B': 
    //turnX(1, -1);
    currentMove = allMoves[11];
    currentMove.start();
    break;
  }
}
