#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;


mat2 rotate2d(float _angle) {
  return mat2(cos(_angle),-sin(_angle),
              sin(_angle),cos(_angle));
}
float box(in vec2 _st, in vec2 _size) {
  _size = vec2(0.5) - _size*0.5;
  vec2 uv = smoothstep(
    _size,
    _size + vec2(0.001),
    _st
  );

  uv *= smoothstep(
    _size,
    _size + vec2(0.001),
    vec2(1.0) - _st
  );

  return uv.x*uv.y;
}

float cross(in vec2 _st, float _size) {
  return box(_st, vec2(_size, _size/4.)) +
         box(_st, vec2(_size/4., _size));
}

float cubicPulse( float c, float w, float x ){
    x = abs(x - c);
    if( x>w ) return 0.0;
    x /= w;
    return 1.0 - x*x*(3.0-2.0*x);
}

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec3 color = vec3(0.0);

  // move space from the center to vec2(0.0);
  st -= vec2(0.5);

  // rotate teh space
  st = rotate2d(sin(u_time)*PI) * st;

  //move it back to the original place
  st += vec2(0.5);

  //show the coordinates of the space on the background
  // color = vec3(st.x, st.y, 0.);

  //add the shape on the foreground
  color += vec3(cross(st,0.4));

  gl_FragColor = vec4(color, 1.0);
}