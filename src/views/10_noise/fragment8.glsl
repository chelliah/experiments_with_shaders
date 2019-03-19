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

vec3 lines(vec2 st) {
  // return vec3(step(mod(st.y, 2.), 1.));
  float y = mod(st.y, .5);
  float bottomEdge = smoothstep(0., 0.2, y);
  float topEdge = 1. - smoothstep(0.3, .5, y);
  return vec3(
    bottomEdge*topEdge
  );
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(0.0);

    st += vec2(0.5);
    st = rotate2D(st, u_time/20.);

    vec2 pos = st * vec2(5.0, 4.);
    pos = rotate2D(pos, 0.25*noise(pos + u_time));

    color = lines(pos);

    gl_FragColor = vec4(color,1.0);
}