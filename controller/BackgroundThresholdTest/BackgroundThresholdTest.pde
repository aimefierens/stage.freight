import controlP5.*;

/**
 * Loop. 
 * 
 * Shows how to load and play a QuickTime movie file.  
 *
 */

import processing.video.*;

Movie movie;
int[] backgroundPixels;
int numPixels;
PImage backgroundImage;
ControlP5 cp5;
int myThreshold = 100;

void setup() {
  size(1280, 720);
  // Load and play the video in a loop
  movie = new Movie(this, "tracking-example.mov");
  movie.loop();

  numPixels = 1280 * 720;
  backgroundPixels = new int[numPixels];
  backgroundImage = loadImage("tracking-base.jpg");
  backgroundPixels = backgroundImage.pixels;

  loadPixels();

  cp5 = new ControlP5(this);
  // name, minValue, maxValue, defaultValue, x, y, width, height
  cp5.addSlider("threshold", 0, 500, myThreshold, 10, 10, 100, 14);
}

public void threshold(int newValue) {
  myThreshold = newValue;
}

void draw() {
  if (movie.available()) {
    movie.read();
    movie.loadPixels();
    for (int i = 0; i < numPixels; i++) {
      color currColor = movie.pixels[i];
      color bkgdColor = backgroundPixels[i];
      // Extract the red, green, and blue components of the current pixel's color
      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract the red, green, and blue components of the background pixel's color
      int bkgdR = (bkgdColor >> 16) & 0xFF;
      int bkgdG = (bkgdColor >> 8) & 0xFF;
      int bkgdB = bkgdColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - bkgdR);
      int diffG = abs(currG - bkgdG);
      int diffB = abs(currB - bkgdB);

      if (diffR + diffG + diffB > myThreshold) {
        pixels[i] = color(255, 255, 255);
      } else {
        pixels[i] = color(0, 0, 0);
      }
      //pixels[i] = color(diffR, diffG, diffB);
    }
    updatePixels(); // Notify that the pixels[] array has changed
  }
}
