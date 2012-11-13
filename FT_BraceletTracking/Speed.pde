
// speed formula adapted from 
// http://processing.org/learning/topics/pattern.html


void ledSpeed(int x, int y, int px, int py) {
  float speed = abs(x-px) + abs(y-py);
  println(speed);

  if (speed >= 200) {
    if (speed <= 299) {
      sc.playNote(50, 100, 2.0);
    }
  }

  if (speed >= 300) {
    if (speed <= 399) {
      sc.playNote(60, 100, 2.0);
    }
  }
  
  if (speed >= 400) {
    sc.playNote(70, 100, 2.0);
  }
}

