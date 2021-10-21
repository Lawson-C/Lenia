Cell[][] small(float l, float s) {
  int cs5 = (int) (.2 * l / s); // 1/5th the size of the cells
  Cell[][] out = new Cell[5 * cs5][5 * cs5];
  for (int x = 0; x < out.length; x++) {
    for (int y = 0; y < out[x].length; y++) {
      if (x >= cs5 * 2 && x <= cs5 * 3 && y >= cs5 * 2 && y <= cs5 * 3) {
        out[x][y] = new Cell(x * s, y * s, (float) Math.random(), s);
      } else {
        out[x][y] = new Cell(x * s, y * s, 0, s);
      }
    }
  }
  return out;
}

Cell[][] multi(float l, float s) {
  Cell[][] out = new Cell[(int) (l / s)][(int) (l / s)];
  PVector[] starts = new PVector[5];
  for (int i = 0; i < starts.length; i++) {
    starts[i] = new PVector((int) random(0, l / s - 11), (int) random(0, l / s - 11));
  }
  for (int x = 0; x < out.length; x++) {
    for (int y = 0; y < out[x].length; y++) {
      for (int i = 0; i < starts.length; i++) {
        if ((out[x][y] == null || out[x][y].val == 0)) {
          if (x >= starts[i].x && x <= starts[i].x + 10
            && y >= starts[i].y && y <= starts[i].y + 10) {
            out[x][y] = new Cell(x * s, y * s, (float) Math.random(), s);
          } else {
            out[x][y] = new Cell(x * s, y * s, 0, s);
          }
        }
      }
    }
  }
  return out;
}

Cell[][] symmetric(float l, float s) {
  int cs5 = (int) (.2 * l / s);
  Cell[][] out = new Cell[5 * cs5][5 * cs5];
  for (int x = 0; x < out.length/2; x++) {
    for (int y = 0; y < out[x].length/2; y++) {
      int oppx = out.length - x - 1;
      int oppy = out[x].length - y - 1;
      if (x >= cs5 * 2 && x < out.length/2 && y >= cs5 * 2 && y <= out[x].length/2) {
        float rand = (float) Math.random();
        out[x][y] = new Cell(x * s, y * s, rand, s);
        out[oppx][y] = new Cell(oppx * s, y * s, rand, s);
        out[x][oppy] = new Cell(x * s, oppy * s, rand, s);
        out[oppx][oppy] = new Cell(oppx * s, oppy * s, rand, s);
      } else {
        out[x][y] = new Cell(x * s, y * s, 0, s);
        out[oppx][y] = new Cell(oppx * s, y * s, 0, s);
        out[x][oppy] = new Cell(x * s, oppy * s, 0, s);
        out[oppx][oppy] = new Cell(oppx * s, oppy * s, 0, s);
      }
    }
  }
  return out;
}
