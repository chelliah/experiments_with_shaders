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
#define PALE_YELLOW vec3(1., .949, .831) // 100% red, 94.9% green and 83.1% blue
#define TAUPE vec3(.878, .639, .525) //87.8% red, 63.9% green and 52.5% blue
#define BROWN_5 vec3(.706, .40, .259) //70.6% red, 40% green and 25.9%
#define OLIVE vec3(.62, .682, .384) //62% red, 68.2% green and 38.4% blue
#define YELLOW vec3(.906, .82, .502) //f 90.6% red, 82% green and 50.2% blue
#define MINT vec3(.671, .827, .529) //67.1% red, 82.7% green and 52.9% blue

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

float circle_dist(in vec2 _st, in float _radius) {
  vec2 dist = _st - vec2(0.5);
  return smoothstep(_radius/5.,
                          _radius + (_radius * 0.01),
                          dot(dist, dist)*4.0);
}


float translated_circle(in vec2 _st, in float displacement, in float _radius) {
  return circle(_st - displacement, _radius);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st *= 8.;
//   st.x += 14.4124;
  st *= 2.;
  //st.y += 16.;
  
  
  float dist1 = distance(st.y, 0.);
  float dist2 = distance(st.y, 4.);
  float dist3 = distance(st.y, 8.);


  float dist4 = distance(st.y, 12.);
  float dist5 = distance(st.y, 16.);

  float dist_all = max(min(min(min(min(dist1, dist2), dist3), dist4), dist5), 0.2);
;
//   st.y += sin(st.x) * abs(dist_all);

  float distX1 = distance(st.x, 4.);
  float distX2 = distance(st.x, 8.);
  float dist_x_all = sqrt(min(distX1, distX2));
  
  float amplitude = 1.8;
  float frequency = 1.;
  float x = st.x / 8. * 2. * PI;
  float t = u_time/3.;
  //st = mod(st, 16.);
//st -= 1.;
  //st +=8.*sin(u_time/20.) + 8.* sin(u_time/12.);
  
  st.y += step(st.y, 4.) * sin(x + PI/9. + t + 35234.1235123) * (dist_all) /4. ;

   st.y -= (1. - step(st.y, 4.)) * sin(x + t * 1.532 + 9734.3456453) * (dist_all) /4. ;

   st.y += step(st.y, 4.) * sin(x + PI/9. + t/20. + 99487.5432) * (dist_all) /4. ;

   st.y -= (1. - step(st.y, 4.)) * sin(x + t/20. + 394267.23452) * (dist_all) /4. ;
  //st.y += sin(st.x*frequency*0.768 + t)/8.0 * dist_x_all;
//   st.y += sin(st.x*frequency*2.221 + t)/5.0 * dist_all;
//   st.y += sin(st.x*frequency*3.1122+ t)/2.5 * dist_all;
  st *=  st /5.;
  st += 10. ;

  float cd = circle_dist(st - 16., 200.);
  

  st += cd;

  float fm = circle_dist(st - 16., 500.);

  st += fm;



  float xPos = 32. - 16.*(noise(vec2(u_time/14.)));
  float yPos = 32. + 16.*cos(u_time/15. + 12441.);



  float circ = circle(st + st/20.* noise(st) - vec2(xPos, yPos), 1012.);
 if(circ > 0.) {
//st *= circ * circ * circ - .2*circ;
}

vec3 OLIVE_2 = mix(MINT, vec3(1.), 0.3);

  vec3 color = MINT;
  float check = abs(mod(floor(st.x), 2.) - mod(floor(st.y),2.));
  if (check == 0. && circ < 1.) {
    color = OLIVE_2;
  } else if ( check == 1. && circ < 1.) {

      color = MINT;
  } else if (check == 1. && circ == 1.) {
      color = OLIVE_2;
  }

  gl_FragColor = vec4(color, 1.);
}