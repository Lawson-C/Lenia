class Cell {
  PVector pos;
  float val;
  float size;

  Cell(float x, float y, float val, float size) {
    this(new PVector(x, y), val, size);
  }

  Cell(PVector pos, float val, float size) {
    this.pos = pos;
    this.val = val;
    this.size = size;
  }

  void display() {
    noStroke();
    fill(rainbow(this.val));
    rect(this.pos.x, this.pos.y, size, size);
  }

  void setVal(float val) {
    if (val > 1) val = 1;
    if (val < 0) val = 0;
    this.val = val;
  }

  void addVal(float diff) {
    this.val += diff;
    if (this.val > 1) this.val = 1;
    if (this.val < 0) this.val = 0;
  }
  
  int[] getIndex() {
    return new int[] {(int) (this.pos.x / this.size), (int) (this.pos.y / this.size)};
  }
}
