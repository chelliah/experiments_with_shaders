// attribute vec3 a_position;
// in vec3 a_position;
// New: a place to get the color passed from js
attribute vec3 color;

// New: a place where we can tell the fragment shader what the color is
varying vec4 v_color;

void main() {
  gl_Position = vec4(position, 1.0);
  v_color = vec4(color, 1.0);
}