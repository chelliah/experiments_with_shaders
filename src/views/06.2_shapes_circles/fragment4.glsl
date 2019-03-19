#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;
  vec3 color = vec3(0.0);
  float d = 0.0;

  // Remap the space to -1. to 1.
  st = st *2.-1.;

  // Make the distance field
  d = length( abs(st)-0.500 );
  d = length( min(abs(st)-.3,0.) );
  d = length( max(abs(st)-.3,0.) );

  // Visualize the distance field
  gl_FragColor = vec4(vec3(fract(d*10.0)),1.0);


  // Drawing with the distance field

  float stepcolor = step(
       0.3 + 0.2*sin(cos(u_time/2.0)/5./(abs(st.y*st.x) - 0.1))
  ,d);

  stepcolor = smoothstep(
       0.3 + 0.2*sin(cos(u_time/2.0)/5./(abs(st.y*st.x) - 0.1)),
       0.3 + 0.2*sin(cos(u_time/2.0)/5./(abs(st.y*st.x) - 0.1))
  ,d);

  stepcolor = smoothstep(
       0.3 + 0.5*sin(cos(u_time/2.0)/2./(d - 0.1)),
       0.3 + 0.5*cos(sin(u_time/2.0)/2./(abs(st.x * st.y) - 0.1))
  ,d);

  stepcolor = smoothstep(
       0.6 + 0.5*sin(cos(u_time/2.0)/2./(d - 0.1)),
       0.6 + 0.5*cos(sin(u_time/2.0)/2./(abs(st.x * st.y) - 0.1))
  ,d);

  stepcolor = smoothstep(
       0.9 - 0.5*sin(cos(u_time/2.0)/2./(pow(d,2.))),
       0.9 + 0.7*cos(cos(u_time/4.0)/2./(abs(st.x * st.y) - .1))
  ,d);



  gl_FragColor = vec4(vec3(stepcolor),1.0);


  float color2 = stepcolor * smoothstep(0., 0.2, min(d, abs(st.x*st.y)));

  gl_FragColor = vec4(vec3(max(color2,smoothstep(0.,1.,d))),1.0);



  // gl_FragColor = vec4(vec3(stepcolor * smoothstep(0., 0.2, min(d, abs(st.x*st.y)))),1.0);

  // gl_FragColor = vec4(vec3( step(.3,d) * step(d,.4)),1.0);
  // gl_FragColor = vec4(vec3( smoothstep(.3,.4,d)* smoothstep(.6,.5,d)) ,1.0);
}