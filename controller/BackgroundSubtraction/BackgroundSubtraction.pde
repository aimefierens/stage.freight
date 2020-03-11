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
}


//void movieEvent(Movie m) {
//  m.read();
//}

void draw() {
  if (movie.available()) {
    movie.read();
    movie.loadPixels();
    int presenceSum = 0;
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
      // Add these differences to the running tally
      presenceSum += diffR + diffG + diffB;
      // Render the difference image to the screen
      pixels[i] = color(diffR, diffG, diffB);
      // The following line does the same thing much faster, but is more technical
      //pixels[i] = 0xFF000000 | (diffR << 16) | (diffG << 8) | diffB;
    }
    updatePixels(); // Notify that the pixels[] array has changed
  }
  
}
