#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(st.x);

    // a weird rainbow
    color.r =  cos(st.x * PI * 2.0);
    color.g = cos((st.x - 0.33) * PI * 1.0);
    color.b = cos((st.x - 0.66)* PI * 1.5);

    gl_FragColor = vec4(color,1.0);
}