#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec4 brickTile(vec2 _st, float _zoom) {
  _st *= _zoom;

  //here is where the offset is happening
  //modulus in the range of 0.0 to 2.0 (anything above 1.0 gets offset by 0.5)
  _st.x += step(1., mod(_st.y, 2.)) * clamp(sin(u_time)+0.5, 0.0, 1.0);
  _st.x -= step(1., mod(_st.y + 1., 2.)) * clamp(sin(u_time)+0.5, 0.0, 1.0);
  _st.y += step(1., mod(_st.x, 2.)) * clamp(cos(u_time)+0.5, 0.0, 1.0);
  _st.y -= step(1., mod(_st.x + 1., 2.)) * clamp(cos(u_time)+0.5, 0.0, 1.0);

  vec4 coords = vec4(fract(_st), _st.x, _st.y);


  return coords;
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec3 color = vec3(0.0);


  //apply the brick tiling
  vec4 bricks = brickTile(st, 5.0);
  st = bricks.xy;
  //add box for each brick
  // color = vec3(box(st, vec2(0.9)));
  color = vec3(st.x + 0.3, st.y + 1.*abs(sin(u_time/2.)), pow(bricks.z*cos(u_time), sin(bricks.a) + sin(bricks.a*u_time)));

  gl_FragColor = vec4(color, 1.0);
}