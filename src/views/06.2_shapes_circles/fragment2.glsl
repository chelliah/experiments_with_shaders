//using the distance field to draw a circle
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution;
  float pct = 0.0;


  float f_time = u_time * 2.0;


  vec2 center = vec2(0.5);
  // circleSize = 0.3 + (0.3 * sin(f_time * st.x) * cos(pow(f_time * st.y, 0.5))*st.x*st.y);

  float circleSize = 0.3;
  // circleSize = 0.3 + (0.3 * sin(f_time * st.x) * cos(pow(f_time * st.y, 0.5))/st.x*st.y);


  // a. the DISTANCE from the pixel to the center;
  pct = distance(st, center);


  //b. The LENGTH of the vector fromt eh pixel to the center
  vec2 tc2 = center-st;
  pct = length(tc2);

  // // the squareRoot of the vector from teh pixel to the center c = sqrt(a^2 + b^2)
  vec2 tC = center - st;
  pct = sqrt(pow(tC.x, 2.0) + pow(tC.y, 2.0));

  //circle with hard outline
  vec3 color = vec3(step(pct, circleSize));

  //circule with inverted outline
  color = vec3(smoothstep(pct, circleSize, circleSize + 0.5));

  //blurred circle
  color = vec3(1.0 - smoothstep(pct - 0.05, pct, circleSize));

  // color = vec3(1.0 - smoothstep(pct - 0.5, pct, circleSize  - (st.x) * 0.5));

  gl_FragColor = vec4( color, 1.0 );
}