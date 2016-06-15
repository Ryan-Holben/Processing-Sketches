PGraphics buffer;
int WIDTH = 640;
int HEIGHT = 480;
float SCALE = 1.5;
color ALIVE = 0;
color DEAD = 0;
int DENSITY = 25;

boolean[][] data = new boolean[WIDTH][HEIGHT];
boolean[][] temp = new boolean[WIDTH][HEIGHT];

void settings() {
  size(int(WIDTH*SCALE), int(HEIGHT*SCALE), P3D);
}

void renderData(PGraphics buf, boolean[][] dat) {
  buf.beginDraw();
  for (int y = 0; y < HEIGHT; y++) {
    for (int x = 0; x < WIDTH; x++) {
      if (dat[x][y] == false)
        buf.set(x, y, DEAD);
      else if (dat[x][y] != false)
        buf.set(x, y, ALIVE);
    }
  }
  buf.endDraw();
}

void resetData(boolean[][] dat, int density) {
  for (int y = 0; y < HEIGHT; y++) {
    for (int x = 0; x < WIDTH; x++) {
      if (int(random(density)) == 0)
        dat[x][y] = true;
      else
        dat[x][y] = false;
    }
  }
}

void setup() {
  surface.setResizable(false);
  noSmooth();
  //frameRate(24);
  colorMode(RGB, 100, 100, 100, 1.0);
  ALIVE = color(0, 0, 0, 0.2);
  DEAD = color(100, 100, 100, 0.2);
  randomSeed(100);
  buffer = createGraphics(WIDTH, HEIGHT, P3D);
  resetData(data, DENSITY);
}

void draw() {  
  for (int i = 0; i < 5; i++)
    processData(data);
  renderData(buffer, data);
  image(buffer, 0, 0, int(WIDTH*SCALE), int(HEIGHT*SCALE));
  println(frameRate);
}

int countNeighbors(boolean[][] dat, int x, int y) {
 
 int cells = 0;
 if (x > 0)
 {
   if (y > 0) { if (dat[x-1][y-1] == true) cells++; }
   if (dat[x-1][y] == true) cells++;
   if (y < HEIGHT - 1) { if (dat[x-1][y+1] == true) cells++; }
 }
 if (x < WIDTH-1)
 {
   if (y > 0)  { if (dat[x+1][y-1] == true) cells++; }
   if (dat[x+1][y] == true) cells++;
   if (y < HEIGHT - 1) { if (dat[x+1][y+1] == true) cells++; }
 }
 if (y > 0) { if (dat[x][y-1] == true) cells++; }
 if (y < HEIGHT - 1) { if (dat[x][y+1] == true) cells++; }
 
 return cells;
}

void processData(boolean[][] dat) {
 int neighbors = 0;
 for (int y = 0; y < HEIGHT; y++) {
   for (int x = 0; x < WIDTH; x++) {
     neighbors = countNeighbors(dat, x, y);
     if (dat[x][y] == true) {
       if (neighbors < 2)
         temp[x][y] = false;
       else if (neighbors == 2 || neighbors == 3)
         temp[x][y] = true;
       else if (neighbors > 3)
         temp[x][y] = false;
     } else if (dat[x][y] == false)
     {
       if (neighbors == 3)
         temp[x][y] = true;
       else
         temp[x][y] = false;
     }
   }
 }
 arrayCopy(temp, dat);
}

void keyPressed() {
 if (key=='a')
   resetData(data, DENSITY);
}

void mouseDragged() {
 data[int(mouseX/SCALE)][int(mouseY/SCALE)] = true;
}