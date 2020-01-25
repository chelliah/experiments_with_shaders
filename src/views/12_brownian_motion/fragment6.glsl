#ifdef GL_ES
precision highp float;
#endif

#define PI 3.14159265359
#define BROWN_1 vec3(.875, .549, .388)
#define BROWN_2 vec3(.82, .498, .341)

uniform vec2 u_resolution;

vec2 rotate2D(vec2 _st, float _angle) {
  _st -= 0.5;
  _st = mat2(cos(_angle), -sin(_angle),
             sin(_angle), cos(_angle)) * _st;
  _st += 0.5;
  return _st;
}


float circle(in vec2 _st, in float _radius) {
  vec2 dist = _st - vec2(0.5);
  return 1.0 - smoothstep(_radius - (_radius * 0.01),
                          _radius + (_radius * 0.01),
                          dot(dist, dist)*4.0);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st *= 15.;
  vec2 flr = floor(st);

  st = fract(st);

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
  float circ_2 = circle(vec2(st.x - .15 * sin(PI/4. * 7.), st.y) , 0.25);

  vec3 color = BROWN_1;

  if (circ_1 > 0. && circ_2 == 0.) {
    color = BROWN_2;
  }

  gl_FragColor = vec4(color, 1.);
}