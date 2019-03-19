#ifdef GL_ES
precision highp float;
#endif


#define PI 3.14159
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Plot a line on Y using a value between 0.0-1.0
float grid(vec2 st) {
 float x =  (1.-smoothstep(-0.05, 0.05, st.x) ) * smoothstep(-0.05, 0.05, st.x);
 float y =  (1.-smoothstep(-0.02, 0.02, st.y) ) * smoothstep(-0.02, 0.02, st.y);
 return x + y;
}


float plot(vec2 st, float pct){
  return  step( pct-0.01, st.y) -
          step( pct+0.01, st.y);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
  // st.x *= 3.;

  //shift gird from y = -1 to 1, x = -4Pi to 4PI
  st.y *= 2.5;
  st.x *= 4.*PI;
  st -= vec2(4.*PI, 1.25);

  vec3 color = vec3(grid(st));

  float y = sin(st.x);
  // y = fract(sin(st.x)*1.0);

  // y = fract(sin(st.x)*10.0);

  // y = fract(sin(st.x)*100000.0);

  // vec3 color = vec3(y);

  // Plot a line
  float pct = plot(st,y);
  color += pct*vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}