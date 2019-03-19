#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (in float x) {
    return fract(sin(x)*1e4);
}

float random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

// float randomSerie(float x, float freq, float t) {
//     return step(.8,random( floor(x*freq)-floor(t) ));
// }

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;

  vec3 color = vec3(0.);



  float cols = 5.;
  float rows = 20. + random(20. + floor(u_time/2.)) * 20.;
  st.y *= cols;
  st.x *= rows;

  float isOddRow = step(mod(st.y, 2.), 1.);
  float isOddColumn = step(mod(st.x + isOddRow, 2.), 1.);
  float direction = 1.;

  if (isOddRow == 0.) {
    direction = -1.;
  }


  st.x += u_time*direction*(2. + random(mod(floor(st.x), 2.2)));
  st.x += floor(st.y);

  st.x = floor(st.x);
  st.x = floor(random(st.x* direction)*2.);


  st.y = fract(st.y);


  color = vec3(
    st.x,
    sin(st.x - random(floor(0.2*u_time))),
    st.x + random(floor(u_time)));

  gl_FragColor = vec4(color, 1.);
}