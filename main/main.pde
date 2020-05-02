import java.nio.*;
import org.opencv.core.*;
import org.opencv.core.Mat;
import org.opencv.core.CvType;
import org.opencv.objdetect.QRCodeDetector;

import processing.video.*;

Capture video;
QRCodeDetector reader;

void setup() {
  size(640, 480, P3D);
  try {
    System.load("\\main\\libraries\\opencv_java420.dll");
  } 
  catch (UnsatisfiedLinkError e) {
    System.err.println("Native code library failed to load.\n" + e);
    System.exit(1);
  }
  video = new Capture(this, width, height);
  reader = new QRCodeDetector();
  video.start();
}

void captureEvent(Capture video) {
  
}

void draw() {
  background(0);
  video.read();
  image(video, 0, 0);
  println("Current txt = " + reader.detectAndDecode(toMat(video)));
}

// Convert PImage (ARGB) to Mat (CvType = CV_8UC4)
Mat toMat(PImage image) {
  int w = image.width;
  int h = image.height;

  Mat mat = new Mat(h, w, CvType.CV_8UC4);
  byte[] data8 = new byte[w*h*4];
  int[] data32 = new int[w*h];
  arrayCopy(image.pixels, data32);

  ByteBuffer bBuf = ByteBuffer.allocate(w*h*4);
  IntBuffer iBuf = bBuf.asIntBuffer();
  iBuf.put(data32);
  bBuf.get(data8);
  mat.put(0, 0, data8);

  return mat;
}

// Convert Mat (CvType=CV_8UC4) to PImage (ARGB)
PImage toPImage(Mat mat) {
  int w = mat.width();
  int h = mat.height();

  PImage image = createImage(w, h, ARGB);
  byte[] data8 = new byte[w*h*4];
  int[] data32 = new int[w*h];
  mat.get(0, 0, data8);
  ByteBuffer.wrap(data8).asIntBuffer().get(data32);
  arrayCopy(data32, image.pixels);

  return image;
}
