#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;


float random(in vec2 _st) {
  return fract(sin(dot(_st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec4 brickTile(vec2 _st, float _zoom) {
  _st.y *= _zoom;

  //here is where the offset is happening
  //modulus in the range of 0.0 to 2.0 (anything above 1.0 gets offset by 0.5)
  _st.x += step(1., mod(_st.y, 2.)) *clamp(cos(u_time + floor(_st.y))+0.5, 0.0, 1.0);
  _st.x -= step(1., mod(_st.y + 1., 2.)) *sin(u_time - floor(_st.y))+0.5;
  //_st.y += step(1., mod(_st.x, 2.)) * clamp(cos(u_time)+0.5, 0.0, 1.0);
  //_st.y -= step(1., mod(_st.x + 1., 2.)) * clamp(cos(u_time)+0.5, 0.0, 1.0);

  vec4 coords = vec4(fract(_st), _st.x, _st.y);


  return coords;
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec3 color = vec3(0.0);


  //apply the brick tiling
  vec4 bricks = brickTile(st, 20.0);
  st = bricks.xy;
  //add box for each brick
  // color = vec3(box(st, vec2(0.9)));
  color = vec3(st.x, fract(st.x + u_time/20.), 1.);

  gl_FragColor = vec4(color, 1.0);
}