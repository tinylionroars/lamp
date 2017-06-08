/*
Source code from:
 * Which Face Is Which
 * Daniel Shiffman
 * http://shiffman.net/2011/04/26/opencv-matching-faces-over-time/
 * Modified by Jordi Tost (call the constructor specifying an ID)
 * @updated: 01/10/2014
 

*/

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

class Face {
  
  // A Rectangle
  Rectangle r;
  // Show me
  void display() {
    fill(0,0,255);
    stroke(0,0,255);
    rect(r.x,r.y,r.width, r.height);
    //rect(r.x*scl,r.y*scl,r.width*scl, r.height*scl);
    fill(255);
    //text(""+id,r.x+10,r.y+30);
    //text(""+id,r.x*scl+10,r.y*scl+30);
    //text(""+id,r.x*scl+10,r.y*scl+30);
  }

  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

}

// List of detected faces (every frame)
Rectangle[] faces;

// Scaling down the video
int scl = 2;

void setup() {
  size(640, 480);
  video = new Capture(this, width/scl, height/scl);
  opencv = new OpenCV(this, width/scl, height/scl);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  video.start();
}

void draw() {
  scale(scl);
  opencv.loadImage(video);

  image(video, 0, 0 );
  
  detectFaces();

  // Draw all the faces
  for (int i = 0; i < faces.length; i++) {
    noFill();
    strokeWeight(5);
    stroke(255,0,0);
    //rect(faces[i].x*scl,faces[i].y*scl,faces[i].width*scl,faces[i].height*scl);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

void detectFaces() {
  // Faces detected in this frame
  faces = opencv.detect();
}

void captureEvent(Capture c) {
  c.read();
}