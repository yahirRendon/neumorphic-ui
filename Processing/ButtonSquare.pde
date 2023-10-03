


class ButtonSquare {
  int x, y;
  int w, h;
  int shadowAmt;
  int shadow;
  int radius;
  boolean on;

  color colorBase;
  color colorHover;

  PShape iconOn, iconOff;

  ButtonSquare(int x, int y, int s) {
    w = s;
    h = s;
    this.x = x - s/2;
    this.y = y - s/2;

    iconOn = null;
    iconOff = null;
    defaultValues();
  }

  ButtonSquare(int x, int y, int s, PShape ps1) {
    w = s;
    h = s;
    this.x = x - s/2;
    this.y = y - s/2;

    iconOn = ps1;
    iconOff = null;
    defaultValues();
  }

  ButtonSquare(int x, int y, int s, PShape ps1, PShape ps2) {
    w = s;
    h = s;
    this.x = x - s/2;
    this.y = y - s/2;

    iconOn = ps1;
    iconOff = ps2;
    defaultValues();
  }


  void defaultValues() {
    shadow = 4;
    shadowAmt = shadow;
    radius = w/2;   
    colorBase = color(245);
    colorHover = color(255, 201, 143);
  }

  void display() {

    shadowAmt = hover() ? shadow - 1 : shadow;

    // drop shadow
    noStroke();
    // highlight upper left
    for (int i = 0; i < shadowAmt; i++) {
      fill(255, map(i, 0, shadowAmt, 255, 0));
      rect(x - i, y - i, w + i, h + i, 8);
    }
    // shadow lower right
    fill(0, 10);
    for (int i = 0; i < shadowAmt; i++) {
      rect(x + i, y + i, w + i, h + i, 8);
    }

    // actual button surface
    fill(245);
    rect(x, y, w, h, 8);

    displayIcon();
  }

  void displayIcon() {
    if (iconOn != null) {
      float xpos = x + radius - iconOn.width/2;
      float ypos = y + radius - iconOff.height/2;
      if (iconOff != null) {

        if (on) {
          shape(iconOn, xpos, ypos);
        } else {
          shape(iconOff, xpos, ypos);
        }
      } else {
        shape(iconOn, xpos, ypos);
      }
    }
  }

  void update() {
    if (hover()) on = !on;
  }

  boolean hover() {
    if (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h) {
      return true;
    } else {
      return false;
    }
  }
}
