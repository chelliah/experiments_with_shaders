
#ifdef GL_ES
precision mediump float;
#endif

#define SMOOTH(r,R) (1.0-smoothstep(R-1.0,R+1.0, r))
#define RANGE(a,b,x) ( step(a,x)*(1.0-step(b,x)) )
#define RS(a,b,x) ( smoothstep(a-1.0,a+1.0,x)*(1.0-smoothstep(b-1.0,b+1.0,x)) )
#define PI 3.1415926535897932384626433832795

#define blue1 vec3(0.74,0.95,1.00)
#define blue2 vec3(0.87,0.98,1.00)
#define blue3 vec3(0.35,0.76,0.83)
#define blue4 vec3(0.953,0.969,0.89)
#define red   vec3(1.00,0.38,0.227)

#define MOV(a,b,c,d,t) (vec2(a*cos(t)+b*cos(0.1*(t)), c*sin(t)+d*cos(0.1*(t))))


uniform vec2 u_resolution;
uniform float u_time;

mat2 rotate2d(float _angle) {
  return mat2(cos(_angle),-sin(_angle),
              sin(_angle),cos(_angle));
}

float circle(in vec2 _st, in float _radius) {
  vec2 dist = _st - vec2(0.5);
  return 1.0 - smoothstep(_radius - (_radius * 0.01),
                          _radius + (_radius * 0.01),
                          dot(dist, dist)*4.0);
}

float circleOutline(in vec2 _st, in float _radius) {
  vec2 dist = _st - vec2(0.5);
  return smoothstep(_radius - (sqrt(_radius)*0.03),
                          _radius,
                          dot(dist, dist)*4.0)
         - smoothstep(_radius,
                          _radius + (sqrt(_radius)*0.03),
                          dot(dist, dist)*4.0);
}


float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.500) - _size*0.5;
    vec2 uv = smoothstep(_size - vec2(0.01),
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size - vec2(0.01),
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float boxWithDisplacementGradient(in vec2 _st, in vec2 _size){
    _size = vec2(0.500) - _size*0.5;
    vec2 uv = smoothstep(_size-vec2(0.1),
                        _size,
                        _st);
    return uv.x*uv.y;
}




float movingLine(in vec2 _st) {
  float theta = fract(u_time/10.)*2.0*PI;
  vec2 centered = _st;

  // move space from the center to vec2(0.0);
  centered -= vec2(0.5);

  // rotate teh space
  centered = rotate2d(theta) * centered;


  centered += vec2(0.25,0.5);

  // if (_st.x > 0.5) {
    return box(centered, vec2(0.5, 0.005)) + boxWithDisplacementGradient(centered, vec2(0.5, 0.005));
  // }
  // return 0.;

}

vec3 expandingBubble(in vec2 _st) {
  vec2 displacement = vec2(sin(u_time/20.)*0.3, tan(pow(u_time/20., 0.5))*0.3);

  vec2 centered = _st + displacement;

  float redVal = circle(centered, 0.001) + (circleOutline(centered, fract(u_time/2.)/10.) * (1.-fract(u_time/2.)));

  return red * redVal;


}

void main() {

  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  vec3 color = vec3(0.0);

  //center circle
  color += circle(st, 0.001) * blue2;

  color += circleOutline(st, 0.2) * blue1;
  color += circleOutline(st, 0.6) * blue1;
  color += circleOutline(st, 1.0) * blue1;
  color += movingLine(st);
  color += expandingBubble(st);

  gl_FragColor = vec4(color, 1.);
}

