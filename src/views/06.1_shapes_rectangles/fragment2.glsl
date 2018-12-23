#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;


void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec3 color = vec3(0.0);

  //each result will return 1.0 (white) or 0.0 (black)
  // float left = step(0.1, st.x); // is x > 0.1
  // float bottom = step(0.1, st.y); // is y > 0.1

  // color = vec3(left * bottom);

  // or combine left and bottom into one vec2
  vec2 bottomLeft = step(vec2(0.1), st);
  float pct = bottomLeft.x * bottomLeft.y;

  vec2 topRight = step(vec2(0.1), 1.0 - st);

  pct *= topRight.x * topRight.y;
  color = vec3(pct);

  gl_FragColor = vec4(color, 1.0);
}