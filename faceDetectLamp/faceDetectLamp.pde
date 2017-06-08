//import gohai.glvideo.*;
import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
Rectangle[] faces;

Capture video;
//GLCapture video;

void setup() {
  size(1920, 1080);
  /*
  String[] devices = GLCapture.list();
  println("Devices:");
  printArray(devices);
  if (0 < devices.length) {
    String[] configs = GLCapture.configs(devices[0]);
    println("Configs:");
    printArray(configs);
  }
  
  video = new GLCapture(this);
  video.start();
  */
  video = new Capture(this, 1080, 720);
  video.start();
  
  opencv = new OpenCV(this, video);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  background(0);
  
  /*
  if (video.available()) {
    video.read();
  }
  */
  
  image(video, 0, 0, width, height);
  
  
  image(opencv.getInput(), 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}