// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}


// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

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

#define OCTAVES 6
float fbm (in vec2 st) {
  //.inital values
  float value = 0.0;
  float amplitude = 0.5;
  float frequency = 0.;

    // increasing lacunarity increases tiny distortions
  float lacunarity = 2.0;

  // increasing gain increases the range of amplitudes
  // try to keep it between 0.0 and 0.71 (arbitrary)
  float gain = 0.5;

  for (int i=0; i < OCTAVES; i++) {
    value += amplitude * noise(st);
    st *= vec2(lacunarity);
    amplitude *= gain;

  }
  return value;
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;

  vec3 color = vec3(0.0);
  color += fbm(st * 3.);

  gl_FragColor = vec4(color,1.);
}

