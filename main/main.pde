import java.nio.*;
import org.opencv.core.*;
import org.opencv.core.Mat;
import org.opencv.core.CvType;
import org.opencv.objdetect.QRCodeDetector;


import com.thomasdiewald.ps3eye.PS3EyeP5;

PS3EyeP5 ps3eye;
QRCodeDetector scanner;
PShape wigglytuff;

public void settings() {
  size(640, 480, P3D);
}

public void setup() {

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
    System.out.println("No PS3Eye connected. Good Bye!");
    exit();
    return;
  } 

  ps3eye.start();
  wigglytuff = loadShape("Wigglytuff.obj");
}

public void draw() {
  image(ps3eye.getFrame(), 0, 0);
  if (frameCount % 1 == 0) {
    Mat points = new Mat();
    String content = scanner.detectAndDecode(toMat(ps3eye.getFrame()), points);
    if (content.equals("Wigglytuff")) {
      println("Detection");
      //shape(wigglytuff);
      double[] initialPoint = points.get(0, 0);
      float[] prevCoord = new float[points.rows()];
      for (int i = 0; i < points.rows(); i++) {
        for (int j = 0; j < points.cols(); j++) {
          if(i == 0) {
            prevCoord[0] = (float)initialPoint[0];
            prevCoord[1] = (float)initialPoint[1];
            continue;
          }
          double[] coord = points.get(i, j);
          stroke(255, 0, 0);
          strokeWeight(5);
          line(prevCoord[0], prevCoord[1], (float)coord[0], (float)coord[1]);
          prevCoord[0] = (float)coord[0];
          prevCoord[1] = (float)coord[1];
          if(i == points.rows() - 1)  line(prevCoord[0], prevCoord[1], (float)initialPoint[0], (float)initialPoint[1]);
        }
      }
    }
  }
}
