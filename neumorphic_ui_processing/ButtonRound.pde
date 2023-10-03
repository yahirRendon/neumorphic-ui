


class ButtonRound {
  int x, y;
  int w, h;
  int shadowAmt;
  int shadow;
  int radius;
  boolean on;

  color colorBase;
  color colorHover;

  PShape iconOn, iconOff;

  ButtonRound(int x, int y, int s) {
    this.x = x;
    this.y = y;
    w = s;
    h = s;
    iconOn = null;
    iconOff = null;
    defaultValues();
  }

  ButtonRound(int x, int y, int s, PShape ps1) {
    this.x = x;
    this.y = y;
    w = s;
    h = s;
    iconOn = ps1;
    iconOff = null;
    defaultValues();
  }

  ButtonRound(int x, int y, int s, PShape ps1, PShape ps2) {
    this.x = x;
    this.y = y;
    w = s;
    h = s;
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
      ellipse(x - i, y - i, w + i, h + i);
    }
    // shadow lower right
    fill(0, 10);
    for (int i = 0; i < shadowAmt; i++) {
      ellipse(x + i, y + i, w + i, h + i);
    }

    // actual button surface
    fill(245);
    ellipse(x, y, w, h);

    displayIcon();
  }

  void displayIcon() {
    if (iconOn != null) {
      if (iconOff != null) {
        if (on) {
          shape(iconOn, x - iconOn.width/2, y - iconOn.height/2);
        } else {
          shape(iconOff, x - iconOff.width/2, y - iconOff.height/2);
        }
      } else {
        shape(iconOn, x - iconOn.width/2, y - iconOn.height/2);
      }
    }
  }

  void update() {
    if (hover()) on = !on;
  }

  boolean hover() {
    float distance = dist(x, y, mouseX, mouseY);
    return distance < radius ?  true :  false;
  }
}