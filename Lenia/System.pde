class System {
  final float dt = .5;

  Kernel k;
  GrowthFunction g;
  Cell[][] cells;
  float[][] mask;

  ArrayList<Cell> updates;

  System(Cell[][] c, float size, Kernel k, GrowthFunction g) {
    this.cells = c;
    if (c[0][0] == null) {
      for (int x = 0; x < c.length; x++) {
        for (int y = 0; y < c.length; y++) {
          float v = (float) Math.random() * .9;
          this.cells[x][y] = new Cell(x * size, y * size, 
            v, size);
        }
      }
    }
    this.k = k;
    this.g = g;
    this.updates = new ArrayList<Cell>();
  }

  // width and height are stored in units of pixels
  System(float l, float size, Kernel k, GrowthFunction g) {
    this(new Cell[(int) (l / size)][(int) (l / size)], size, k, g);
  }

  void periodic() {
    if ((float) tick % 1./dt == 0) {
      this.mask = this.getMask();
    }
    for (int x = 0; x < this.cells.length; x++) {
      for (int y = 0; y < this.cells[x].length; y++) {
        this.cells[x][y].addVal(this.mask[x][y] * dt);
      }
    }
    this.display();
  }

  float[][] getMask() {
    float[][] mask = new float[cells.length][cells[0].length];
    for (int x = 0; x < mask.length; x++) {
      for (int y = 0; y < mask[x].length; y++) {
        float N = 0;
        float sigKF = 0;
        float rad = 8; // radius of neighborhood

        for (int ox = (int) -rad; ox < rad; ox++) {
          for (int oy = (int) -rad; oy < rad; oy++) {
            if (!k.inRange(ox, oy)) continue;

            int tx = x + ox;
            int ty = y + oy;

            while (tx < 0) tx += mask.length;
            while (tx >= mask.length) tx -= mask.length;
            while (ty < 0) ty += mask[x].length;
            while (ty >= mask[x].length) ty -= mask[x].length;

            N += this.k.map(ox, oy, 2*rad);
            sigKF += this.k.map(ox, oy, 2*rad) * this.cells[tx][ty].val;
          }
        }
        mask[x][y] = g.growth(sigKF / N);
      }
    }
    return mask;
  }

  void display() {
    for (int x = 0; x < this.cells.length; x++) {
      for (int y = 0; y < this.cells[x].length; y++) {
        this.cells[x][y].display();
      }
    }
  }

  ArrayList<ArrayList<Cell>> getOrganism() {
    ArrayList<ArrayList<Cell>> out = new ArrayList<ArrayList<Cell>>();
    return out;
  }
}
