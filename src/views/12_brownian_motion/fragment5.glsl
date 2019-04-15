// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

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

#define SLATE vec3(0.333,0.462,0.667)
#define OLIVE vec3(0.666667,0.666667,0.498039)
#define RED vec3(0.645,0.109,0.134)
#define TEAL vec3(0.219,0.414,0.490)

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st *= 3.;
  // st += st * abs(sin(u_time*0.1)*3.);
  vec3 color = vec3(0.);

  vec2 q = vec2(0.);
  q.x = fbm( st + 0.0*u_time);
  q.y = fbm( st + vec2(1.));

  vec2 r = vec2(0.);
  r.x = fbm( st + 1.*q + vec2(1.7, 9.2) + 0.15*u_time);
  r.y = fbm( st + 1.*q + vec2(8.3, 2.8) + 0.126*u_time);

  float f = fbm(st + r);

  color = mix(SLATE,
              OLIVE,
              clamp((f*f)*4.,0.,1.));

  color += mix(color,
              RED,
              clamp(length(q), 0., 1.44));

  color += mix(color,
                TEAL,
                1.784-clamp(length(r.x),0.,1.));

  gl_FragColor = vec4((f*f*f + .6*f*f + .5*f)*color, 1.);

}