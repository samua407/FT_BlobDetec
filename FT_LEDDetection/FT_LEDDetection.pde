// - Super Fast Blur v1.1 by Mario Klingemann <http://incubator.quasimondo.com>
// - BlobDetection library

import processing.video.*;
import blobDetection.*;

Capture cam;
BlobDetection theBlobDetection;
PImage img;
boolean newFrame=false;

// ==================================================
// setup()
// ==================================================
void setup()
{
  // Size of applet
  size(640, 480);
  // Capture
  cam = new Capture(this, 40*4, 30*4, 15);
  // Comment the following line if you use Processing 1.5
  cam.start();

  // BlobDetection
  // img which will be sent to detection (a smaller copy of the cam frame);
  img = new PImage(80, 60); 
  theBlobDetection = new BlobDetection(img.width, img.height);
  theBlobDetection.setPosDiscrimination(true);
  theBlobDetection.setThreshold(0.95f); // will detect bright areas whose luminosity > 0.2f;
}

// ==================================================
// captureEvent()
// ==================================================
void captureEvent(Capture cam)
{
  cam.read();
  newFrame = true;
}

// ==================================================
// draw()
// ==================================================
void draw()
{
  if (newFrame)
  {
    newFrame=false;
    image(cam, 0, 0, width, height);
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
   // fastblur(img, 2);
    theBlobDetection.computeBlobs(img.pixels);
    drawBlobsAndEdges(true, true);
  }
}

// ==================================================
// drawBlobsAndEdges()
// ==================================================
void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges)
{
  noFill();
  Blob b;
  EdgeVertex eA, eB;
  for (int n=0 ; n<theBlobDetection.getBlobNb() ; n++)
  {
    b=theBlobDetection.getBlob(n);
    if (b!=null)
    {
      // Edges
      if (drawEdges)
      {
        strokeWeight(3);
        stroke(0, 255, 0);
        for (int m=0;m<b.getEdgeNb();m++)
        {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA !=null && eB !=null)
            line(
            eA.x*width, eA.y*height, 
            eB.x*width, eB.y*height
              );
        }
      }

      // Blobs
      if (drawBlobs)
      {
        strokeWeight(1);
        stroke(255, 0, 0);
        rect(
        b.xMin*width, b.yMin*height, 
        b.w*width, b.h*height
          );
      }
    }
  }
}

//CUT SUPER FAST BLUR
