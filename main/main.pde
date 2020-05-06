import java.nio.*;
import java.util.Map;
import java.util.HashMap;

import org.opencv.core.*;
import org.opencv.core.Mat;
import org.opencv.core.CvType;
import org.opencv.objdetect.QRCodeDetector;
import org.opencv.imgproc.Imgproc;
import org.opencv.calib3d.Calib3d;

import com.thomasdiewald.ps3eye.PS3EyeP5;

PS3EyeP5 ps3eye;
QRCodeDetector scanner;
PShape wigglytuff;

public void settings() {
  size(640, 480, P3D);
}

public void setup() {
  frameRate(15);
  try {
    System.load("E:\\Apuntes\\CIU\\processing-interactive-game\\main\\libraries\\opencv_java420.dll");
  } 
  catch (UnsatisfiedLinkError e) {
    System.err.println("Native code library failed to load.\n" + e);
    System.exit(1);
  }

  ps3eye = PS3EyeP5.getDevice(this);
  scanner = new QRCodeDetector();

  if (ps3eye == null) {
    System.err.println("No PS3Eye connected.");
    exit();
    return;
  } 

  ps3eye.start();
  wigglytuff = loadShape("Wigglytuff.obj");
  wigglytuff.rotateX(-PI/2);
  wigglytuff.scale(75);
}

public void draw() {
  background(0);
  image(ps3eye.getFrame(), 0, 0);


  Mat points = new Mat();  
  Mat frame = toMat(ps3eye.getFrame());
  Imgproc.cvtColor(frame, frame, Imgproc.COLOR_RGBA2GRAY);
  String content = scanner.detectAndDecode(frame, points);
  if (!content.equals("")) {
    double[] initialPoint = points.get(0, 0);
    float[] prevCoord = new float[points.rows()];
    double centerX = 0;
    double centerY = 0;
    for (int i = 0; i < points.rows(); i++) {
      for (int j = 0; j < points.cols(); j++) {
        if (i == 0) {
          prevCoord[0] = (float)initialPoint[0];
          prevCoord[1] = (float)initialPoint[1];
          centerX += initialPoint[0];
          centerY += initialPoint[1];
          continue;
        }
        double[] coord = points.get(i, j);
        centerX += coord[0];
        centerY += coord[1];
        stroke(255, 0, 0);
        strokeWeight(5);
        line(prevCoord[0], prevCoord[1], (float)coord[0], (float)coord[1]);
        prevCoord[0] = (float)coord[0];
        prevCoord[1] = (float)coord[1];
        if (i == points.rows() - 1)  line(prevCoord[0], prevCoord[1], (float)initialPoint[0], (float)initialPoint[1]);
      }
    }
    centerX /= 4;
    centerY /= 4;
    
    pushMatrix();
    translate((float)centerX, (float)centerY);
    shape(wigglytuff);
    popMatrix();
  }
}
