import java.nio.*;
import org.opencv.core.*;
import org.opencv.core.Mat;
import org.opencv.core.CvType;
import org.opencv.objdetect.QRCodeDetector;


import com.thomasdiewald.ps3eye.PS3EyeP5;

PS3EyeP5 ps3eye;
QRCodeDetector scanner;

public void settings() {
  size(640, 480);
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
}

public void draw() {
  image(ps3eye.getFrame(), 0, 0);
  if(frameCount % 5 == 0) println("Current txt = " + scanner.detectAndDecode(toMat(ps3eye.getFrame())));
}
