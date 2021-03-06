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

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

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

float translated_circle(in vec2 _st, in float displacement, in float _radius) {
  return circle(_st - displacement, _radius);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st *= 15.;
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

  // vec2 mouse_point = u_mouse/u_resolution;

  // float displacement = distance(flr + ipos, mouse_point * 15.);
  // float circ_3 = translated_circle(st, -1. * displacement, 0.5);
  // float circ_4 = translated_circle(vec2(st.x - .15 * sin(PI/4. * 7.), st.y), -1. * displacement,  0.28);



  vec3 color = BROWN_1;

  // float nz = noise((ipos * u_time/20. + flr)/5. + u_time/20.);
  float nz = noise((ipos+ flr)/5. + u_time/20.) + noise((ipos + flr)/32. + u_time/18.);

  // if (circ_3 > 0. && circ_4 == 0.) {
  //   color = PINK;
  // }
  if (circ_1 > 0. && circ_2 == 0.) {
    // if(nz > 1. && nz < 1.3) {
    //   float prg = smoothstep(1.3, 1., nz);
    //   float rnd = noise(vec2((flr + ipos)*200. +u_time/20.));

    //   if(rnd > prg) {
    //     color = mix(PINK, BROWN_2, 0.3);
    //   } else {
    //     color = BROWN_2;
    //   }
    // } else if(nz >= 1.3) {
    //     color = mix(PINK, BROWN_2, 0.3);
    // } else {
    //   color = BROWN_2;
    // }
    color = BROWN_2;
  }

  gl_FragColor = vec4(color, 1.);
}