#ifdef GL_ES
precision mediump float;
#endif


#define PI 3.14159265359
#define red vec3(1.0, 0.2, 0.2)
#define light_grey vec3(0.8)
#define white vec3(1.)
#define black vec3(0.)
#define orange vec3(0.933, 0.439, 0.180)
#define blue vec3(0.078, 0.184, 0.349)
#define beige vec3(0.969, 0.886, 0.682)

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


mat2 rotate2d(float _angle) {
  return mat2(cos(_angle),-sin(_angle),
              sin(_angle),cos(_angle));
}

float flower( vec2 _st) {

    _st*= 3.; //scale up the space by 3
    _st = fract(_st);

    vec2 pos = vec2(0.5)-_st;

    pos = pos * rotate2d(PI*-0.25+(u_time/5.));

    float r = length(pos)*2.0;
    float a = atan(pos.y,pos.x);

    float cosAngle = abs(cos(a*5.));
    float f = cosAngle*.075+.5;
    float edgeOfPetal = cosAngle > 0.1 ? 1. : 0. ;
    return  (1.-smoothstep(f,f+0.02,r)) * smoothstep(0.15, 0.1501, r) * edgeOfPetal;

}

float distance_field(vec2 _st) {
      float d = 0.0;

      // Remap the space to -1. to 1.
      _st = _st *2.-1.;

      // Make the distance field
      d = length( abs(_st)-0.35 );

      return 1.-step(0.2, d);
}


float circle(vec2 _st, float scale, float size) {


    _st*= scale; //scale up the space by 3
    _st = fract(_st);
    vec2 pos = vec2(0.5)-_st;


    float r = length(pos)*2.0;
    // float a = atan(pos.y,pos.x);
    return (1.-smoothstep(size, size + .002,r));
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = blue;






    float flowers = flower(st);
    float circles = circle(st, 9., 0.15);

    float circles2 = distance_field(st);
    color += vec3(circles) * orange;
    color += vec3(circles2) * (beige - blue);
    color += vec3(flowers) * (orange - blue);

    gl_FragColor = vec4(color, 1.0);
}