// Author: Inigo Quiles
// Title: Expo

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    //try replacing this with log() or exp()



    vec3 color = vec3(
      (sin(u_time) + 0.5)
      *
      min(
        smoothstep(0.2, 0.5, st.x) * smoothstep(0.2, 0.5, st.y),
        smoothstep(0.7, 0.5, st.x) * smoothstep(0.7, 0.5, st.y)
      )
    );


    gl_FragColor = vec4(color,1.0);


}
