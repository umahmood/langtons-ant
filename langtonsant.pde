int interval          = 100;
int currentIterations = 0;
int lastRecordedTime  = 0;

color alive = color(0, 200, 0);
color dead  = color(0);
color ant   = color(255, 0, 0);
color text  = color(255, 0, 0);

PFont f;

// which direction is the ant facing 0 = N, 1 = E, 2 = S, 3 = W
int facing;

// ant coords
int antx = 0;
int anty = 0;
 
int cellSize = 5;

int[][] cells;

void setup() {
    size(640, 360, P2D);
    
    // create and set font
    f = createFont("Arial",14,true);
    textFont(f);
    
    // init. array
    cells = new int[width/cellSize][height/cellSize];
    
    // draw background of grid
    stroke(48);
    noSmooth();
   
    for(int x=0; x < width/cellSize; x++) {
        for(int y=0; y< height/cellSize; y++) {
            cells[x][y] = 0;
        }
    }
    
    // set starting position of ant
    antx = (width / cellSize) / 2;
    anty = (height / cellSize) / 2;
    // ant is initially facing north
    facing = 0;
    
    cells[antx][anty] = 1;

    background(0);
}

void draw() {    
    // draw grid    
    for (int x=0; x < width/cellSize; x++) {
        for (int y=0; y < height/cellSize; y++) {
            if(cells[x][y] == 1) {
                fill(alive); // if alive
            }
            else {
                fill(dead); // if dead
            }
            rect(x*cellSize, y*cellSize, cellSize, cellSize);
        } 
    }
    
    // draw text
    fill(text);
    text("Direction: " + Facing() + " iterations: " + parseInt(currentIterations), 5, 15);  
    noFill();
    
    // draw ant
    fill(ant);
    rect(antx*cellSize, anty*cellSize, cellSize, cellSize);
    noFill();
   
    // iterate if timer ticks
    if(millis()-lastRecordedTime>interval) {
         // when the clock ticks
         iteration();
         currentIterations++;
         lastRecordedTime = millis();
    }
}

String Facing() {
    if (facing == 0) {
        return "N";
    } else if (facing == 1) {
        return "E";
    } else if (facing == 2) {
        return "S";
    } else if (facing == 3) {
        return "W";
    }
    return "???";
}

void iteration() {   
    /*
       Rules:
   
       An ant sits on a particular square of the grid. 
   
       If the square it is currently sitting on is set, it turns right (a quarter turn) 
   
       Then move one space forward (unsetting the state of the cell as it leaves)
   
       If the square it is currently sitting on is unset, it turns left and moves forward one space (setting the state of the cell as it leaves)
    */   
    if (cells[antx][anty] == 1) {
        cells[antx][anty] = 0; // unset cell state
        turnRightAndMoveForward();
    } else {
        cells[antx][anty] = 1; // set cell state
        turnLeftAndMoveForward();
    }   
}

void turnLeftAndMoveForward() {
    switch (facing) {
        case 0: // north
           antx -= 1;
           facing = 3; // west
           break;
        case 1: // east
            anty -= 1;
            facing = 0; // north
            break;
        case 2: // south
           antx += 1;
           facing = 1; // east
           break;
        case 3: // west
           anty += 1;
           facing = 2; // south
           break;
     }
}

void turnRightAndMoveForward() {
    switch (facing) {
        case 0: // north
           antx += 1;
           facing = 1; // east
           break;
        case 1: // east
           anty += 1;
           facing = 2; // south
           break;
        case 2: // south
           antx -= 1;
           facing = 3; // west
           break;
        case 3: // west
           anty -= 1; 
           facing = 0; // north
           break;
    }
}
