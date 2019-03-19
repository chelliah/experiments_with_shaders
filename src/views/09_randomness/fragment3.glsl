// Author @patriciogv - 2015
// Title: Mosaic

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  st *= 10.; // scale the coordinate system up by 10;
  vec2 ipos = floor(st); // get the integer coords (0 - 10
  vec2 fpos = fract(st); // get the fractional coords

  // assign a random value based on the integer coord
  vec3 color = vec3(random(ipos));

  color *= vec3(ipos, 1.);

  gl_FragColor = vec4(color, 1.);
}