package functions;

class Kernel {
  double s;
  float[][] mask;

  Kernel(float[][] mask) {
    this.s = mask.length;
    this.mask = mask;
    ;
  }

  boolean inRange(float offx, float offy) {
    return Math.sqrt(offx*offx + offy*offy) <= half();
  }

  float half() {
    return (float) (this.s/2.);
  }

  float map(float x, float y, float range) {
    double mx = this.s * x / range;
    double my = this.s * y / range;
    return !inRange(x, y) ? 0 : mask[(int) (mx + half())][(int) (my + half())];
  }
}
