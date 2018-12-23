//distance field

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


void main() {
  //normalize coordinate values
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  //remap the x st based on the aspect reation of the screen (1:1 in our case)
  st.x *= u_resolution.x/u_resolution.y;

  vec3 color = vec3(0.0);

  float d = 0.0;


  // remap the space from (0 to 1) to (-1 to 1)
  st = st * 2.0 - 1.0;

  // make the distance field
  d = length( abs(st) -.5 );
  // d = length(min(abs(st) - 0.3, 0.0));
  // d = length(max(abs(st) - 0.3, 0.0));

  // visualize the distance field
  gl_FragColor = vec4(vec3(fract(d*10.0)), 1.0);


  // gl_FragColor = vec4(vec3(step((0.3 + 0.2*sin(u_time)) - 0.03*sin(u_time/50.*(0.5 - abs(st.y))*(0.5 - abs(st.x))),d) ),1.0);

  //   gl_FragColor = vec4(vec3(fract(d + 1.456*tan(u_time))),1.0);
  // gl_FragColor = vec4(vec3(step(0.3,d) * step(d,.4)), 1.0);
  // gl_FragColor = vec4(vec3(smoothstep(.3,.4,d) * smoothstep(.6,.5,d)), 1.0);


}