import java.util.Set;

class System {
  final float dt = .5;
  final float radius = 8;

  Kernel kernel;
  GrowthFunction growth;
  Cell[][] cells;
  float[][] mask;

  HashMap<Integer, Cell> updates;

  System(Cell[][] c, float size, Kernel kernel, GrowthFunction g) {
    this.cells = c;
    if (c[0][0] == null) {
      for (int x = 0; x < c.length; x++) {
        for (int y = 0; y < c[x].length; y++) {
          float v = (float) Math.random() * .9;
          this.cells[x][y] = new Cell(x * size, y * size, 
            v, size);
        }
      }
    }
    this.kernel = kernel;
    this.growth = g;
    this.updates = new HashMap<Integer, Cell>();
    for (int x = 0; x < this.cells.length; x++) {
      for (int y = 0; y < this.cells[x].length; y++) {
        if (this.cells[x][y].val != 0) {
          updates.put(x + y * this.cells.length, this.cells[x][y]);
        }
      }
    }
  }

  // width and height are stored in units of pixels
  System(float l, float size, Kernel k, GrowthFunction g) {
    this(new Cell[(int) (l / size)][(int) (l / size)], size, k, g);
  }

  void periodic() {
    this.checkUpdates();
    if ((float) tick % 1./dt == 0) {
      this.mask = this.getMask();
    }
    Set<Integer> keys = this.updates.keySet();
    for (int k : keys) {
      int[] i = this.updates.get(k).getIndex();
      this.cells[i[0]][i[1]].addVal(this.mask[i[0]][i[1]] * dt);
    }
    this.display();
  }

  void checkUpdates() {
    HashMap<Integer, Cell> nextUpdates = new HashMap<Integer, Cell>();
    Set<Integer> keys = this.updates.keySet();
    for (int k : keys) {
      Cell c = this.updates.get(k);
      int[] ind = c.getIndex();
      int x = ind[0];
      int y = ind[1];

      for (int ox = (int) -radius; ox < radius; ox++) {
        for (int oy = (int) -radius; oy < radius; oy++) {
          if (!this.kernel.inRange(ox, oy)) continue;

          int tx = x + ox;
          int ty = y + oy;

          while (tx < 0) tx += this.cells.length;
          while (tx >= this.cells.length) tx -= this.cells.length;
          while (ty < 0) ty += this.cells[x].length;
          while (ty >= this.cells[x].length) ty -= this.cells[x].length;

          if (c.val != 0) {
            nextUpdates.put(tx + ty * this.cells.length, this.cells[tx][ty]);
          }
          if (this.cells[tx][ty].val != 0) {
            nextUpdates.put(tx + ty * this.cells.length, this.cells[tx][ty]);
          }
        }
      }
    }
    this.updates = nextUpdates;
  }

  float[][] getMask() {
    float[][] mask = new float[cells.length][cells[0].length];
    Set<Integer> keys = this.updates.keySet();
    for (int k : keys) {
      Cell c = this.updates.get(k);
      int[] ind = c.getIndex();
      int x = ind[0];
      int y = ind[1];
      float N = 0;
      float sigKF = 0;

      for (int ox = (int) -radius; ox < radius; ox++) {
        for (int oy = (int) -radius; oy < radius; oy++) {
          if (!this.kernel.inRange(ox, oy)) continue;

          int tx = x + ox;
          int ty = y + oy;

          while (tx < 0) tx += mask.length;
          while (tx >= mask.length) tx -= mask.length;
          while (ty < 0) ty += mask[x].length;
          while (ty >= mask[x].length) ty -= mask[x].length;

          N += this.kernel.map(ox, oy, 2*radius);
          sigKF += this.kernel.map(ox, oy, 2*radius) * this.cells[tx][ty].val;
        }
      }

      mask[x][y] = growth.growth(sigKF / N);
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
