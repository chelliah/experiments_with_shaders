#ifdef GL_ES
precision mediump float;
#endif


uniform vec2 u_resolution;
uniform float u_time;

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

  // To move the cross we move the coordinate space

  //in a circle
  vec2 translate = vec2(cos(u_time/4.),sin(u_time/4.));

  //in a line
  translate = vec2(cos(u_time/5.0));

  // in a parabola
  translate = vec2(cos(u_time/4.),-1.+2.*pow(cos(u_time/4.), 2.));

  // in a wormhole
  // translate = vec2(cos(u_time/4.),cubicPulse(0.2, 0.5, st.x));

  st += translate*0.35; // we multiply by 0.35 to reduce the intensity of the transformation

  // Show the coordinates of the space on teh background
  // gradientz.
  color = vec3(st.x,st.y, 0.0);
  // color *= vec3(st.y, cos(st.x*6.28), abs(sin(u_time)));

  // Add the shape on the foreground
  color += vec3(cross(st,0.25));

  gl_FragColor = vec4(color, 1.0);
}