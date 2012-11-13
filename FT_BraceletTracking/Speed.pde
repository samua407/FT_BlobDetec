// adapted from http://processing.org/learning/topics/pattern.html


void ledSpeed(int x, int y, int px, int py) {
  float speed = abs(x-px) + abs(y-py);
  println(speed);
}
