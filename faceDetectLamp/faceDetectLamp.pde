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
import processing.serial.*;


Capture video;
OpenCV opencv;
Serial port;

class Face {
  
  // A Rectangle
  Rectangle r;
  // Show me
  void display() {
    stroke(0,0,255);
    rect(r.x,r.y,r.width, r.height);
  }

  // Give me a new location / size
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

}

// List of detected faces (every frame)
Rectangle[] faces;


void setup() {
  size(640, 480);
  video = new Capture(this, width/2, height/2);
  
  opencv = new OpenCV(this, width/2, height/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  video.start();
  
  String portName =Serial.list()[2];
  port = new Serial(this, portName, 9600);
}

void draw() {
  scale(2);
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
  if (faces.length > 0) {
   fill(100, 0, 150);
   noStroke();
   rect(0, 0, 50, 50);
    port.write(255);
  } else {
    port.write(100);
  }
}

void captureEvent(Capture c) {
  c.read();
}