PImage img;

int shadowAmt = 4;

ButtonRound btnRound;
ButtonSquare btnSquare;

PShape icon1, icon2;

PApplet app;
void setup() {
  img = loadImage("C:\\Users\\yahir\\Downloads\\user.png");
  img.resize(40, 40);
  size(800, 400);

  surface.setTitle("fhe");
  icon1 = loadShape("C:\\Users\\yahir\\Downloads\\user.svg");
  icon2 = loadShape("C:\\Users\\yahir\\Downloads\\userOff.svg");

  btnRound = new ButtonRound(400, 100, 60, icon1, icon2);
  btnSquare = new ButtonSquare(500, 100, 54, icon1, icon2);
}

void draw() {
  background(235);

  btnRound.display();
  btnSquare.display();



  //ROUND
  int x = 100;
  int y = 100;
  int w = 80;
  int h = 80;
  shadowAmt = 4;
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

  image(img, 100 - 20, 100 - 20);


  // SQUARE
  w = 72;
  h = 72;
  x = 200 - (w/2);
  y = 100 - (h/2);

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


  // DIAL

  x = 100;
  y = 300;
  w = 80 - 12;
  h = 80 -12;
  strokeWeight(12);
  noFill();
  // drop shadow

  // highlight upper left
  for (int i = 0; i < shadowAmt; i++) {
    stroke(255, map(i, 0, shadowAmt, 255, 0));
    //rect(x - i, y - i, 60 + i, 60 + i, 8);
    arc(x - i, y - i, w + i, h + i, radians(135), radians(405));
  }
  // shadow lower right
  stroke(0, 10);
  for (int i = 0; i < shadowAmt; i++) {
    //rect(x + i, y + i, 60 + i, 60 + i, 8);
    arc(x + i, y + i, w + i, h + i, radians(135), radians(405));
  }

  // actual button surface
  stroke(245);

  fill(245);
  noStroke();
  //arc(x, y, w, h, radians(135), radians(405));
  for (int i = 135; i <= 405; i+=5) {
    float newx = x + cos(radians(i)) * (w/2);
    float newy = y + sin(radians(i)) * (h/2);
    ellipse(newx, newy, 12, 12);
  }

  int position = (int)map(mouseX, 0, width, 135, 406);
  stroke(183, 110, 121);
  //arc(x, y, w, h, radians(135), radians(position));


  noStroke();
  fill(255, 201, 143);
  for (int i = 135; i <= position; i+=5) {
    float newx = x + cos(radians(i)) * (w/2);
    float newy = y + sin(radians(i)) * (h/2);
    ellipse(newx, newy, 12, 12);
  }

  // inset
  x = 300;
  y = 300;
  w = 80;
  h = 80;

  fill(243);
  noStroke();
  ellipse(x, y, w, h);
  noFill();
  stroke(255, 40);
  for (int i = 0; i < 8; i++) {
    strokeWeight(i);
    arc(x, y, w - i, h - i, radians(315 + (i * i)), radians(495 -(i * i)));
  }

  stroke(0, 4);
  for (int i = 0; i < 8; i++) {
    strokeWeight(i);
    arc(x, y, w - i, h - i, radians(115 + (i * i)), radians(335 -(i * i)));
  }

  x = 200;
  y = 200;
  w = 80 - 12;
  h = 80 - 12;

  noFill();
  stroke(243);
  strokeWeight(12);
  ellipse(x, y, w, h);

  // highlight
  w = 80;
  h = 80;
  stroke(255, 50);
  for (int i = 0; i < 8; i++) {
    strokeWeight(i/2);
    arc(x, y, w - i, h - i, radians(315 + (i * i)), radians(495 -(i * i)));
  }

  w = 80 - 24;
  h = 80 - 24;
  stroke(255, 50);
  for (int i = 0; i < 8; i++) {
    strokeWeight(i/2);
    arc(x, y, w + i, h + i, radians(115 + (i * i)), radians(335 -(i * i)));
  }

  w = 80;
  h = 80;
  stroke(0, 4);
  for (int i = 0; i < 8; i++) {
    strokeWeight(i);
    arc(x, y, w - i, h - i, radians(115 + (i * i)), radians(335 -(i * i)));
  }

  w = 80 - 24;
  h = 80 - 24;
  stroke(0, 4);
  for (int i = 0; i < 8; i++) {
    strokeWeight(i);
    arc(x, y, w + i, h + i, radians(315 + (i * i)), radians(495 -(i * i)));
  }

  w = 80 - 24;
  h = 80 - 24;
  noStroke();
  fill(243);
  ellipse(x, y, w, h);

  w = 80 - 12;
  h = 80 - 12;
  position = (int)map(mouseX, 0, width, 90, 450);
  noStroke();
  fill(255, 201, 143);
  for (int i = 90; i <= position; i+=5) {
    float newx = x + cos(radians(i)) * (w/2);
    float newy = y + sin(radians(i)) * (h/2);
    ellipse(newx, newy, 12, 12);
  }
}

void mouseClicked() {
  btnRound.update();
  btnSquare.update();
}
