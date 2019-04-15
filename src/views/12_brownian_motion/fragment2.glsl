#ifdef GL_ES
precision highp float;
#endif


#define PI 3.14159
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random(float x) {
  //looks like tv static
  return fract(sin(x) * sin(x) * 238417.1234132);
}
vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

float random(vec2 st) {
  //looks like tv static
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 238417.1234132);
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

// Plot a line on Y using a value between 0.0-1.0
float grid(vec2 st) {
 float x =  (1.-smoothstep(-0.05, 0.05, st.x) ) * smoothstep(-0.05, 0.05, st.x);
 float y =  (1.-smoothstep(-0.02, 0.02, st.y) ) * smoothstep(-0.02, 0.02, st.y);
 return x + y;
}


float plot(vec2 st, float pct){
  return  step( pct-0.01, st.y) -
          step( pct+0.01, st.y);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
  // st.x *= 3.;

  //shift gird from y = -1 to 1, x = -4Pi to 4PI
  st.y *= 2.5;
  st.x *= 4.*PI;
  st -= vec2(4.*PI, 1.25);

  st.x /= u_time;

  vec3 color = vec3(grid(st));



   float i = floor(st.x);
   float f = fract(st.x);

   float r = random(vec2(i));


  //By adding different iterations of noise (octaves),
  //where we successively increment the frequencies in
  //regular steps (lacunarity) and decrease the amplitude (gain)
  //of the noise we can obtain a finer granularity in the noise
  //and get more fine detail. This technique is called
  //"fractal Brownian Motion" (fBM), or simply "fractal noise"
  //, and in its simplest form it can be created by the
  //following code:


  float y = 0.;

    // Properties
  const int octaves = 1;

  // increasing lacunarity increases tiny distortions
  float lacunarity = 2.0;

  // increasing gain increases the range of amplitudes
  // try to keep it between 0.0 and 0.71 (arbitrary)
  float gain = 0.5;
  //
  // Initial values
  float amplitude = 0.5;
  float frequency = 1. * u_time;
  //
  // Loop of octaves
  for (int i = 0; i < octaves; i++) {
    y += amplitude * noise(vec2(frequency*st.x));

    //multiply frequency by lacunarity, thus raising it
    frequency *= lacunarity;

    //multiply amplitude by gain, lowerin it
    amplitude *= gain;
  }

  // Plot a line
  float pct = plot(st,y);
  color += pct*vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}