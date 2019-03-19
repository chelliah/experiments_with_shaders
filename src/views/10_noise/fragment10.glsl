#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 rotate2D(vec2 _st, float _angle) {
  _st -= 0.5;
  _st = mat2(cos(_angle), -sin(_angle),
             sin(_angle), cos(_angle)) * _st;
  _st += 0.5;
  return _st;
}

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);
    //  u = f*f*f*(f*(f*6.-15.)+10.);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec2 pos = st * vec2(10.);


    color = vec3( noise(pos)*.5+.5 );

    // float r = length(pos)*2.0;
    // float a = atan(pos.y,pos.x);

    // float f = cos(a*3.);
    // // f = abs(cos(a*3.));
    // // f = abs(cos(a*2.5))*.5+.3;
    // // f = abs(cos(a*12.)*sin(a*3.))*.8+.1;
    // // f = smoothstep(-.5,1., cos(a*10.))*0.2+0.5;

    color = vec3( 1.-smoothstep(0., .6 + .5*noise(vec2(st.x+u_time*.2)), st.y) );
    color *= vec3(noise(vec2(pos.x + 2.*noise(vec2((st.y)*(st.x )+ u_time/15.)), pos.y - u_time))*.5 + 0.5);


    //color += 0.1*vec3(noise(vec2(pos.t + 21.*noise(vec2((st.y)*(st.x )+ u_time/15.)), pos.y - u_time))*.5 + 0.5);

    gl_FragColor = vec4(color, 1.0);
}