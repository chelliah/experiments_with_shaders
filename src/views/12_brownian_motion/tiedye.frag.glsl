#ifdef GL_ES
precision highp float;
#endif

#define PI 3.14159265359
#define BROWN_1 vec3(.875, .549, .388)
#define BROWN_2 vec3(.82, .498, .341) //82% red, 49.8% green and 34.1% blue
#define BROWN_3 vec3(.576, .29, .188) //57.6% red, 29% green and 18.8% blue
#define BROWN_4 vec3(.753, .51, .388) // 75.3% red, 51% green and 38.8% blue
#define PINK vec3(.992,.624,.482) //99.2% red, 62.4% green and 48.2% blue.
#define COCOA  vec3(.349, .157, .098) //34.9% red, 15.7% green and 9.8% blue
#define OLIVE vec3(.62, .682, .384) //62% red, 68.2% green and 38.4% blue
#define BROWN_5 vec3(.706, .40, .259) //70.6% red, 40% green and 25.9%
uniform vec2 u_resolution;
uniform float u_time;

vec2 rotate2D(vec2 _st, float _angle) {
  _st -= 0.5;
  _st = mat2(cos(_angle), -sin(_angle),
             sin(_angle), cos(_angle)) * _st;
  _st += 0.5;
  return _st;
}



float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}


// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float circle(in vec2 _st, in float _radius) {
  vec2 dist = _st - vec2(0.5);
  return 1.0 - smoothstep(_radius - (_radius * 0.01),
                          _radius + (_radius * 0.01),
                          dot(dist, dist)*4.0);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st *= vec2(200., 300.);
  vec2 flr = floor(st);
  vec2 ipos = fract(st);
  st = ipos;

  float modX = mod(flr.x, 2. ); // 0 or 1;

  float modY = mod(flr.y, 2. ); // 0 or 1;

  if(modX == 0. && modY == 0. ) {

    st = rotate2D(st, PI/4. * 7.);
  } else if (modX == 1. && modY == 0.) {
    st = rotate2D(st, PI/4. * 3.);
  } else if (modX == 0. && modY == 1.) {
    st = rotate2D(st, PI/4. * 5.);
  } else if (modX == 1. && modY == 1.) {
    st = rotate2D(st, PI/4.);
  }



  //   //  integer value 0 to 10
  // vec2 ipos = floor(st);
  // // fractional value 0.0 to 1.0
  // vec2 fpos = fract(st);
  // // vec2 fpos = floo
  // // st -= vec2(.5);

  float circ_1 = circle(st, 0.5);
  float circ_2 = circle(vec2(st.x - .15 * sin(PI/4. * 7.), st.y) , 0.28);

  vec3 color = BROWN_1;

  // float nz = noise((ipos * u_time/20. + flr)/5. + u_time/20.);
  float nz = noise(rotate2D(ipos + flr, PI/1.421 * (u_time + 9345.435) /-50. + 20.)/32./5. + u_time/60.) + noise(rotate2D(ipos + flr, PI/1.421 * (u_time + 12323.412)/150. + 12123.12)/32. + u_time/18.) + noise(rotate2D(ipos + flr, PI/1.421 + (sin(u_time/300.) + u_time/600. + 12323.412)/-80. + 12123.12)/32. + u_time/18.)
;


//    float pct = smoothstep(1.09, 1.1, nz);
//    float pct2 = smoothstep(1.49, 1.5, nz);
//    float pct3 = smoothstep(1.99, 2.0, nz);
//    color = mix(BROWN_1, PINK, pct);
//    color = mix(BROWN_1, BROWN_2, pct) * mix(PINK, BROWN_2, pct2);

//    if(nz < 1.1) {
//        color = mix(COCOA, BROWN_2, pct);
//    } else if (nz < 1.5 ) {
//        color = mix(BROWN_2, BROWN_3, pct2);
//    } else {
//        color = mix(BROWN_3, BROWN_4, pct3);
//    }

   float pct = smoothstep(.0, 1.5, nz);
   float pct2 = smoothstep(1.3, 1.9, nz);
   float pct3 = smoothstep(2.0, 3., nz);
//    color = mix(BROWN_1, PINK, pct);
//    color = mix(BROWN_1, BROWN_2, pct) * mix(PINK, BROWN_2, pct2);

   if(nz < 1.) {
       color = mix(OLIVE, BROWN_2, pct);
   } else if (nz < 2. ) {
       color = mix(BROWN_2, BROWN_3, pct);
   } else {
       color = mix(BROWN_3, OLIVE, pct);
   }

  color = mix(mix(BROWN_5, BROWN_4, pct3 / pct), mix(BROWN_3, OLIVE, (pct + pct3)), pct2);

  gl_FragColor = vec4(color, 1.);
}