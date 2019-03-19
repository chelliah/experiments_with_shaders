//drawing a distance field
#ifdef GL_ES
precision mediump float;
#endif

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

float noise(vec2 st) {
  vec2 f = fract(st);
  vec2 i = floor(st);


  float a = random(i);
  float b = random(i + vec2(1., 0.));
  float c = random(i + vec2(0., 1.));
  float d = random(i + vec2(1., 1.));

  vec2 u = f*f*(3.0-2.0*f);

  float ab =  mix(a,b,u.x);
  float cd = mix(c,d,u.x);
  float ac = mix(a,c,u.y);
  float bd = mix(b,d,u.y);

  float mixed =  mix(a, b, u.x) +
         (c - a)* u.y * (1.0 - u.x) +
         (d - b) * u.x * u.y;

  //mixed =  mix(mix(ab, cd, u.y), mix(ac,bd, u.x), u.x);

  return mixed;
}


void main() {
  vec2 st = gl_FragCoord.xy/u_resolution;
  float pct = 0.0;

  st *= 5.;

  vec3 color = vec3(noise(st - vec2(0.5)));

  gl_FragColor = vec4( color, 1.0 );
}