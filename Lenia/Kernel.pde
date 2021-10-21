class Kernel {
  float s;
  float[][] mask;

  Kernel(float[][] mask) {
    this.s = mask.length;
    this.mask = mask;
    ;
  }

  boolean inRange(float offx, float offy) {
    return sqrt(sq(offx) + sq(offy)) <= half();
  }

  float half() {
    return this.s/2.;
  }

  float map(float x, float y, float range) {
    float mx = PApplet.map(x, 0, range, 0, this.s);
    float my = PApplet.map(y, 0, range, 0, this.s);
    return !inRange(x, y) ? 0 : mask[(int) (mx + half())][(int) (my + half())];
  }
}
