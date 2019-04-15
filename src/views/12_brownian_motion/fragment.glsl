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
  st -= vec2(4.*PI, 1.25);

  vec3 color = vec3(grid(st));



   float i = floor(st.x);
   float f = fract(st.x);

   float r = random(vec2(i));


  //  float y = random(st.x);


  //  y = random(i);
  //  y = mix(random(i-0.5), random(i+0.5), f);

  //  // smoothstep is equivalent to the fn f(x) = 3x^2-2x^3
  //  y = mix(random(i-0.5), random(i+0.5), smoothstep(0., 1., f));

  float amplitude = 1.;
  float frequency = 1.;
  float y = sin(st.x * frequency);
  float t = 0.01*(-u_time*130.0);
  y += sin(st.x*frequency*2.1 + t)*4.5;
  y += sin(st.x*frequency*0.768 + t*1.121)*4.0;
  y += sin(st.x*frequency*2.221 + t*0.437)*5.0;
  y += sin(st.x*frequency*3.1122+ t*4.269)*2.5;
  y *= amplitude*0.06;


   //y = noise(st.x);

  // vec3 color = vec3(y);

  // Plot a line
  float pct = plot(st,y);
  color += pct*vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}