void growth_functions() {
  
  // gaussian bump
  
  gaussianG = new GrowthFunction() {
    public float growth(float n) {
      float x = n + .2;
      if (x < 0 || x > 1) {
        return -1;
      } else {
        float k = 4 * x * (1 - x);
        n = 2 * exp(10.5 * (1 - 1/k)) - 1;
      }

      return n;
    }
  };
}
