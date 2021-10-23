public class KernelPresets {
  static Kernel gaussianKernel() {
    float[][] mask = new float[50][50];
    float w = mask.length;
    float h = mask[0].length;
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        double offset = .2;
        double r = Math.hypot(w / 2. - x, h / 2. - y) / (Math.sqrt(w * w + h * h) / 2. + offset);
        double k = 4 * r * (1 - r);
        if (r - offset == 1 || r - offset == 0) {
          mask[x][y] = 0;
        } else {
          if (r > w / .2) {
            mask[x][y] = 0;
          } else {
            mask[x][y] = (float) Math.exp(25 * (1 - 1 / k));
          }
        }
      }
    }
    return new Kernel(mask);
  }
}
