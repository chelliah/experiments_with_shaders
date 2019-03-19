// Author: Inigo Quiles
// Title: Expo

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

mat2 rotate2d(float _angle) {
  return mat2(cos(_angle),-sin(_angle),
              sin(_angle),cos(_angle));
}


float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    st = st * rotate2d(PI*-0.25+u_time/2.);

    vec3 color = vec3(step(mod(st.y, 0.1), 0.05+cos(u_time)*0.045));

    gl_FragColor = vec4(color,1.0);
}
