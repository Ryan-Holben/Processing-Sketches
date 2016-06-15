
int WIDTH = 1024;
int HEIGHT = 768;
float SCALE = 1;
color ALIVE = 0;
color DEAD = 0;
int current_generation = 0;

boolean[] data = new boolean[WIDTH];
boolean[] temp = new boolean[WIDTH];

void settings() {
  size(int(WIDTH*SCALE), int(HEIGHT*SCALE), P3D);
}


void setup() {
  surface.setResizable(false);
  noSmooth();
  //frameRate(24);
  colorMode(RGB, 100, 100, 100, 1.0);
  ALIVE = color(0, 0, 0, 0.2);
  DEAD = color(100, 100, 100, 0.2);
  for (int x = 0; x < WIDTH; x++) data[x] = false;
  data[WIDTH/2] = true;
}

void draw() {
  if (current_generation < HEIGHT-1 && data[1] == false)
  {
    computeGeneration();
    renderLine(data, current_generation);
    current_generation++;
  }
}

int countNeighbors(boolean[] dat, int x) {
  return int(dat[x-1]) + int(dat[x+1]);
}

void renderLine(boolean[] dat, int y) {
  loadPixels();
  for (int x = 0; x < WIDTH; x++) {
    if (dat[x] == true) pixels[x + y*WIDTH] = ALIVE;
    else pixels[x + y*WIDTH] = DEAD;
  }
  updatePixels();
}

void computeGeneration() {
  int n;
  for (int x = 1; x < WIDTH-1; x++) {
    n = countNeighbors(data, x);
    if (data[x] == false)
    {
      if (n == 1) temp[x] = true;
      else temp[x] = false;
    }
    else if(data[x] == true)
    {
      if (n == 0) temp[x] = false;
      else if (n == 1) temp[x] = true;
      else if (n == 2) temp[x] = false;
    }
  }
  temp[0] = temp[WIDTH-1] = false;
  for (int x = 0; x < WIDTH; x++)
    data[x] = temp[x];
}

void keyPressed() {

}