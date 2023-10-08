/******************************************************************************
 * 
 * class for creating round button that has the effect of looking raised from
 * the surface. 
 * 
 *****************************************************************************/
class ButtonRound {
  int x, y;                   // x, y position (left corner);
  int xCenter, yCenter;       // x, y position (center)
  int w, h;                   // width and hight of button
  int shadowAmt;              // shadow amount when off
  int radius;                 // radius of the button
  boolean on;                 // track if button is on or off
 
  color colorBase;            // the color of the button itself
  color colorHover;           // the color on hover #FIX not in use at the moment
  color colorBckgrnd;         // the color of the background to clean edges
  
  PShape iconOn, iconOff;     // icon for on and off state
  PGraphics shadowsOff;       // shadows when off
  PGraphics shadowsOn;        // shadows when hover or on
  
  /******************************************************************************
   * 
   * constructor
   * 
   * @ param x    x position (center)
   * @ param y    y position (center)
   * @ param s    size of the button
   *****************************************************************************/
  ButtonRound(int x, int y, int s) {
    this.x = x;
    this.y = y;
    xCenter = x;
    yCenter = y;
    w = s;
    h = s;
    iconOn = null;
    iconOff = null;
    defaultValues();
  }
  
  /******************************************************************************
   * 
   * constructor
   * 
   * @ param x    x position (center)
   * @ param y    y position (center)
   * @ param s    size of the button
   * @ param ps1  the icon when off
   *****************************************************************************/
  ButtonRound(int x, int y, int s, PShape ps1) {
    this.x = x;
    this.y = y;
    xCenter = x;
    yCenter = y;
    w = s;
    h = s;
    iconOff = ps1;
    iconOn = null;
    defaultValues();
  }
  
  /******************************************************************************
   * 
   * constructor
   * 
   * @ param x    x position (center)
   * @ param y    y position (center)
   * @ param s    size of the button
   * @ param ps1  the icon when off
   * @ param ps2  the icon when on
   *****************************************************************************/
  ButtonRound(int x, int y, int s, PShape ps1, PShape ps2) {
    this.x = x;
    this.y = y;
    xCenter = x;
    yCenter = y;
    w = s;
    h = s;
    iconOff = ps1;
    iconOn = ps2;
    defaultValues();
  }
  
  /******************************************************************************
   * 
   * setup the default values
   * 
   *****************************************************************************/
  void defaultValues() {
    shadowAmt = 10;
    x -= (w/2) + shadowAmt;
    y -= (w/2) + shadowAmt;
    radius = w/2;   
    
    colorBase = color(237, 238, 243);
    colorHover = color(255, 201, 143);
    colorBckgrnd = color(237, 238, 243);

    shadowsOff = createGraphics(w + shadowAmt * 2, w + shadowAmt * 2);
    shadowsOn = createGraphics(w + shadowAmt * 2, w + shadowAmt * 2);
    generateShadow(shadowsOff, shadowAmt);
    generateShadow(shadowsOn, shadowAmt/2);
  }
  
  /******************************************************************************
   * 
   * create the necessary shadows and highlights and turn them into PGrahpic for
   * use in display. 
   * 
   * @ param pg         graphic to be updated with shadow/highlights
   * @ param shadowLen  the length of the shadow/highlights
   *****************************************************************************/
  void generateShadow(PGraphics pg, int shadowLen) {
    //center of graphics
    int pgCenterX = pg.width / 2;
    int pgCenterY = pg.height / 2;

    // begin drawing to graphic
    pg.beginDraw();

    // create shadows
    pg.strokeWeight(2);
    for (int i = 0; i < shadowLen; i++) {
      // define center position of offset shapes B and C
      int xposB = pgCenterX + i;
      int yposB = pgCenterY + i;
      int xposC = pgCenterX - i;
      int yposC = pgCenterY - i;

      // calcualte alpha value
      float a = map(i, 0, 10, 6, 0);
      float aHighlight = map(i, 0, 10, 30, 0);
      for (int y = 0; y < pg.height; y++) {
        for (int x = 0; x < pg.width; x++) {
          // calculate distance for x, y (loop pixel) to center of all shapes
          float distanceA = dist(x, y, pgCenterX, pgCenterY);
          float distanceB = dist(x, y, xposB, yposB);
          float distanceC = dist(x, y, xposC, yposC);

          // determine if x, y (loop pixel) is in each shape
          boolean inA = distanceA < radius;
          boolean inB = distanceB < radius;
          boolean inC = distanceC < radius;

          // create shadow
          if (inB && !inA) {
            pg.stroke(0, a);
            pg.point(x, y);
          }

          // create highlight
          if (inC && !inA) {
            pg.stroke(255, aHighlight);
            pg.point(x, y);
          }
        }
      }
    }

    // create shape and outline to clean edges
    pg.strokeWeight(1);
    pg.stroke(colorBase);
    pg.fill(colorBase);
    pg.ellipse(pgCenterX, pgCenterY, w, w);
    pg.endDraw();
  }
  
  /******************************************************************************
   * 
   * display the button
   * 
   *****************************************************************************/
  void display() {
    //shadowAmt = hover() ? shadow - 1 : shadow;

    if (hover() || on) {
      image(shadowsOn, x, y);
    } else {
      image(shadowsOff, x, y);
    }

    displayIcon();
  }
  
  /******************************************************************************
   * 
   * manage which icon to display
   * 
   *****************************************************************************/
  void displayIcon() {
    if (iconOn != null) {
      if (iconOff != null) {
        if (on) {
          shape(iconOn, xCenter - iconOn.height/2, yCenter - iconOn.height/2);
        } else {
          shape(iconOff, xCenter - iconOff.width/2, yCenter - iconOff.height/2);
        }
      } else {
        shape(iconOn, xCenter - iconOn.width/2, yCenter - iconOn.height/2);
      }
    }
  }
  
  /******************************************************************************
   * 
   * update the button value
   * 
   *****************************************************************************/
  void update() {
    if (hover()) on = !on;
  }
  
  /******************************************************************************
   * 
   * track if mouse is over bar
   * 
   * @return    true when mouse in button
   *****************************************************************************/
  boolean hover() {
    float distance = dist(xCenter, yCenter, mouseX, mouseY);
    return distance < radius ?  true :  false;
  }
}
