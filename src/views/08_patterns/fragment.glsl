#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;


float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(l,l)*4.0);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution;
  vec4 color = vec4(0.0);

  st*= 3.; //scale up the space by 3

  //you can also scale x and y values independently
  //st.x *=2.;
  //st.y *= 4.;


  st = fract(st); // wrap values around 1.0

  // how we have 3 spaces that go from 0 to 1

  // color = vec4(st,1.,0.);
  color = vec4(st.x, st.y, 1.0, circle(st,0.5));
  color = mod(color, 0.5);

  gl_FragColor = vec4(color);
}