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

import jp.nyatla.nyar4psg.*;

PS3EyeP5 ps3eye;
MultiNft nya;
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
  nya = new MultiNft(this, width, height, "camera.dat", NyAR4PsgConfig.CONFIG_PSG);

  if (ps3eye == null) {
    System.err.println("No PS3Eye connected.");
    System.exit(2);
    return;
  } 

  nya.addNftTarget("marks/Wigglytuff/wigglytuff", 120);
  ps3eye.start();
  
  wigglytuff = loadShape("Wigglytuff.obj");
  wigglytuff.rotateX(PI);
  wigglytuff.scale(50);
}

public void draw() {
  nya.detect(ps3eye.getFrame());
  nya.drawBackground(ps3eye.getFrame());

  if (!nya.isExist(0)) {
    return;
  }
  nya.beginTransform(0);
  translate(-80, 55, 20);
  shape(wigglytuff);
  nya.endTransform();
}
