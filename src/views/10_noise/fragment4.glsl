#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define brown vec3(0.169, 0.024, 0.012)

#define red1 vec3(0.506, 0.098, 0.067)
// [NSColor colorWithCalibratedRed:0.506 green:0.098 blue:0.067 alpha:1.00]
#define red2 vec3(0.169, 0.024, 0.012)
// [NSColor colorWithCalibratedRed:0.459 green:0.082 blue:0.047 alpha:1.00]
#define orange vec3(.871, .694, .4)

// [NSColor colorWithCalibratedRed:0.871 green:0.694 blue:0.400 alpha:1.00]



float random(float x) {
  //looks like tv static
  return fract(sin(x) * sin(x) * 238417.1234132);
}

float random(vec2 st) {
  //looks like tv static
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 238417.1234132);
}


float noise(vec2 st) {
  vec2 f = fract(st);
  vec2 i = floor(st);


  float a = random(i);
  float b = random(i + vec2(1., 0.));
  float c = random(i + vec2(0., 1.));
  float d = random(i + vec2(1., 1.));

  vec2 u = f*f*(3.0-2.0*f);

  // float ab =  mix(a,b,u.x);
  // float cd = mix(c,d,u.x);
  // float ac = mix(a,c,u.y);
  // float bd = mix(b,d,u.y);

  float mixed =  mix(a, b, u.x) +
         (c - a)* u.y * (1.0 - u.x) +
         (d - b) * u.x * u.y;

  //mixed =  mix(mix(ab, cd, u.y), mix(ac,bd, u.x), u.x);

  return mixed;
}

vec3 rect(vec2 st, in vec2 location, in vec2 size,  in vec3 color) {
  float ftime = u_time;
  float rand1 = noise(st*40.*st.y - vec2(ftime))*.1 + noise(st*4000. + vec2(ftime))*(size.x/2.) - (size.x/4.);
  float rand2 = noise(st*40.*(1.-st.y) - vec2(ftime))*.1 + noise(st*4000. + vec2(ftime))*(size.x/2.) - (size.x/4.);

  float rand3 = noise(st*40.*st.x - vec2(ftime))*.1 + noise(st*4000. + vec2(ftime))*(size.y/2.) - (size.y/4.);
  float rand4 = noise(st*40.*(1.-st.x) - vec2(ftime))*.1 + noise(st*4000. + vec2(ftime))*(size.y/2.) - (size.y/4.);


  float edgeLeft = 1. - step(location.x - rand1, st.x);
  float edgeRight = step(location.x + size.x - rand2, st.x);
  float h = max(edgeLeft, edgeRight);

  float edgeTop = 1. - step(location.y - rand3, 1.0 - st.y);
  float edgeBottom = step(location.y + size.y - rand4, 1.0 - st.y);
  float y = max(edgeTop, edgeBottom);

  // if color is white, let it return that, otherwise, return the color for anything within the enclosed spce
  return vec3(1. - max(y,h)) * color;
}


void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  vec3 color = brown;


  vec3 r1 = rect(st, vec2(.04, .05), vec2(.35, .8), red1);

  vec3 r2 = rect(st, vec2(0.45, 0.05), vec2(0.3, 0.9), red2);
  vec3 r3 = rect(st, vec2(0.75, 0.1), vec2(0.2, 0.8), orange);


  // color += r1 + r2 + r3;
  color += mix(r1,r2,st.x) + mix(r2,r3,st.x);


  // color += rect(st, vec2(0.75, 0.1), vec2(0.2, 0.8), orange);


  gl_FragColor = vec4(color, 1.0);
}