int tick = 0;

System system;
Kernel gaussianK;
GrowthFunction gaussianG;

void setup() {
  tick = 0;
  size(800, 800);
  
  kernel_functions();
  growth_functions();
  
  //system = new System(width, width/160., mainK, mainG);
  system = new System(multi(width, 4.), 4., gaussianK, gaussianG);
  system.display();
  frameRate(60);
}

void draw() {
  system.periodic();
  tick++;
}

void mousePressed() {
  setup();
}

int rainbow(float v) {
  float r = map(v, 0, 1, 0, 255);
  float g = map(v, 0, 1, 255, 0);
  float b = 255;
  if (v == 0) return #FFFFFF;
  return color(r, g, b);
}
