//drawing a distance field
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


float circle(in vec2 _st, in float _radius) {
  vec2 dist = _st - vec2(0.5);
  return 1.0 - smoothstep(_radius - (_radius * 0.01),
                          _radius + (_radius * 0.01),
                          dot(dist, dist)*4.0);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution;
  float pct = 0.0;


  // a. the DISTANCE from the pixel to the center;
  pct = distance(st, vec2(0.5));


  //b. The LENGTH of the vector fromt eh pixel to the center
  vec2 tc2 = vec2(0.5)-st;
  pct = length(tc2);

  // // the squareRoot of the vector from teh pixel to the center c = sqrt(a^2 + b^2)
  vec2 tC = vec2(0.5) - st;
  pct = sqrt(pow(tC.x, 2.0) + pow(tC.y, 2.0));


  // pct = step(pct, 0.3);
  // pct = 1.0 - step(pct, 0.3);


  vec3 color = vec3(pct);

  //  color = vec3(circle(st,0.9));


  gl_FragColor = vec4( color, 1.0 );
}