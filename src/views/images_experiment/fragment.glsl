#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 u_resolution;
uniform float u_time;
uniform sampler2D u_texture; // <---------------------------------- texture sampler uniform

varying vec2 vUv;



float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

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

#define NUM_OCTAVES 5
float fbm (in vec2 _st) {
  float value = 0.0;
  float amplitude = 0.5;

  vec2 shift = vec2(100.0);

  //rotate to reduce axial bias
  mat2 rotate = mat2(cos(0.5), sin(0.5),
                  -sin(0.5), cos(0.5));

  for (int i=0; i < NUM_OCTAVES; ++i) {
    value += amplitude * noise(_st);
    _st = rotate * _st * 2. + shift;
    amplitude *= 0.5;
  }

  return value;
}

void main() {
  vec2 st = vUv;

  vec2 q = vec2(0.);
  q.x = fbm( st + 0.0*u_time);
  q.y = fbm( st + vec2(1.));

  vec2 r = vec2(0.);
  r.x = fbm( st + 1.*q + vec2(1.7, 9.2) + 0.15*u_time);
  r.y = fbm( st + 1.*q + vec2(8.3, 2.8) + 0.126*u_time);

  float f = fbm(st + r);

  vec3 color = texture2D(u_texture, vUv * f*2.).rgb;

  // gl_FragColor = vec4(1.0, 0.8, .8, 1.);
  // color.r += 1. * st.x * sin(u_time);
  gl_FragColor = vec4(color, 1.);
}