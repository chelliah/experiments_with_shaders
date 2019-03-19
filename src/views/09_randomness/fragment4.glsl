#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265358979323846

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


float random(in vec2 _st) {
  return fract(sin(dot(_st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 truchetPattern(in vec2 _st, in float _index) {
  // new value between 0 and 1
  _index = fract(((_index-0.5)*2.));

  if (_index > 0.75) {
    _st = vec2(1.) - _st;
  } else if (_index > 0.5) {
    _st = vec2(1.-_st.x, _st.y);
  } else if (_index > 0.25) {
    _st = 1. - vec2(1.-_st.x, _st.y);
  }

  return _st;

}


void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st *= 10.;
  st.x += u_time/2.;

  //  integer value 0 to 10
  vec2 ipos = floor(st);
  // fractional value 0.0 to 1.0
  vec2 fpos = fract(st);
  // vec2 fpos = floo


  vec2 tile = truchetPattern(fpos, random(ipos));

// maze
  float color = smoothstep(tile.x-0.3,tile.x,tile.y)-
          smoothstep(tile.x, tile.x + 0.3, tile.y);

  // color = (step(length(tile), 0.6) - step(length(tile), 0.4)) + (1. - step(length(tile), 0.6) - step(length(tile), 0.4));
  // color = (step(length(tile), 0.6) - step(length(tile), 0.4)) + (step(dot(tile,vec2(1.)),0.6) - step(length(tile-vec2(1.)), 0.4));


  // gl_FragColor = vec4(vec3(color), 1.);

    gl_FragColor = vec4(vec3(color*tile.x, color*tile.y, 0.8),1.0);
}