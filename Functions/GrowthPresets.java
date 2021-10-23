public class GrowthPresets {
  static GrowthFunction gaussian() {
    return new GrowthFunction() {
      public float growth(float n) {
        double x = n + .2;
        if (x < 0 || x > 1) {
          return -1;
        } else {
          double k = 4 * x * (1 - x);
          n = 2 * (float) Math.exp(10.5 * (1 - 1 / k)) - 1;
        }

        return n;
      }
    };
  }
}
