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

    // lets get weirder
    color.r =  tan(pow(st.x,st.y+mod(u_time/10.,2.)
)* PI / (2.0 + 0.8*sin(u_time/20.)
))/2.;
    color.g = cos((st.x - 0.33) * sqrt(st.y*mod(u_time/5., 6.)) * PI * 3.0*cos(u_time/15.0));
    color.b = cos((st.x*st.y + (5. + 1.66*sin(u_time/4.)))* PI * 1.5);


    // a weird rainbow
    color.r /=  cos(pow(st.x,st.y)* PI / (2.0 + 0.8*sin(u_time/20.)));
    color.g += sin((st.x - 0.33) * sqrt(st.y*mod(u_time/5., 6.)) * PI * 3.0*cos(u_time/15.0))/4.;
    color.b *= cos((st.x*st.y + (5. + 1.66*sin(u_time/4.)))* PI * 1.5);


    gl_FragColor = vec4(color,1.0);
}