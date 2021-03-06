#ifdef GL_ES
precision highp float;
#endif


#define PI 3.14159
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random(float x) {
  //looks like tv static
  return fract(sin(x) * sin(x) * 238417.1234132);
}

float random(vec2 st) {
  //looks like tv static
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 238417.1234132);
}



float noise(float x) {
  float i = floor(x);
  float f = fract(x);

  float r = random(vec2(i));
  float u = f  * f * (3.0 - 2.000 * f );
  r = mix(random(i - 0.5), random(i + 0.5), f);

  r = mix(random(i - 0.5), random(i + 0.5), u);


  return r;
}

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
  st -= vec2(2.*PI, 1.25);

  vec3 color = vec3(grid(st));



   float i = floor(st.x);
   float f = st.x;

   float r = random(vec2(i));


  float y = f*f*(3.0-2.0*f);
 // y = f*f*f*(f*(f*6.-15.)+10.);

  // Plot a line
  float pct = plot(st,y);
  color += pct*vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}