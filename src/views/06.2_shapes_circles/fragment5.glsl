#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec3 color = vec3(0.0);

  //remap st to  -0.5, 0.5
  vec2 pos = vec2(0.5) - st;

  float r = length(pos)*2.0;
  float a = atan(pos.y, pos.x);

  float f = cos(a*3.);
  //this example shows that values of f < 0 aren't mapped, thus when abs is used the number of loops doubles
  // f = abs(cos(a*3.))

  //the object here has a minimum radius of 0.3, with 5 loops extending outwards 0.5
  // f = abs(cos(a*2.5))*.5 + 0.3;

  //replace 12. and 15. with abs(cos(u_time)*5.)
  // f = abs(cos(a*12.)*sin(a*5.))*.8 + .1

  //coooool

  f = (cos(a*12.))*(cos(a*u_time/2.))*.03+.9;

  //this one looks like a cog
  // f = smoothstep(-.5,0.720, cos(a*10.))*0.2+0.5;


  color = vec3( 1.-smoothstep(f,f+0.02,r) );

  gl_FragColor = vec4(color, 1.0);
}