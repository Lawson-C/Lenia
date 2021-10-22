void kernel_functions() {
  
  // gaussian bump
  
  float[][] mask = new float [50][50];
  float w = mask.length;
  float h = mask[0].length;
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      float offset = .2;
      float r = dist(w/2., h/2., x, y) / (sqrt(w*w + h*h) / 2. + offset);
      float k = 4 * r * (1 - r);
      if (r - offset == 1 || r - offset == 0) {
        mask[x][y] = 0;
      } else {
        if (r > w / .2) {
          mask[x][y] = 0;
        } else {
          mask[x][y] = exp(25 * (1 - 1/k));
        }
      }
    }
  }
  gaussianK = new Kernel(mask);
}
