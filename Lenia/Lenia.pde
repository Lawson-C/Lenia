int tick = 0;

System system;
Kernel mainK;
GrowthFunction mainG;

void setup() {
  tick = 0;
  size(800, 800);

  float[][] mask = new float [50][50];
  float w = mask.length;
  float h = mask[0].length;
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      float r = dist(w/2., h/2., x, y) / (sqrt(w*w + h*h) / 2.);
      float k = 4 * r * (1 - r);
      if (r > w / .2) {
        mask[x][y] = 0;
      } else {
        mask[x][y] = exp(10 * (1 - 1/k));
      }
    }
  }

  mainG = new GrowthFunction() {
    public float growth(float n) {
      float x = n + .3;
      if (x < 0 || x > 1) {
        return -1;
      } else {
        float k = 4 * x * (1 - x);
        n = 2 * exp(114.86 * (1 - 1/k)) - 1;
      }

      return n;
    }
  };

  mainK = new Kernel(mask);
  //system = new System(width, width/160., mainK, mainG);
  Cell[][] c = symmetric(width, 4.);
  system = new System(c, 4., mainK, mainG);
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
