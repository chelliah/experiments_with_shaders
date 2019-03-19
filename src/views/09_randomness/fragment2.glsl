#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


float random(vec2 st) {
  //looks like tv static
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 238417.1234132);
}
void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  float rnd = random(st);
  gl_FragColor = vec4(vec3(rnd), 1.);
}