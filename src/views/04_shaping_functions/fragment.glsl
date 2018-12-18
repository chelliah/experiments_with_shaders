#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 st, float pct){
  return  smoothstep( pct-0.084, pct, st.y) -
          smoothstep( pct, pct+0.012, st.y);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

    float y = st.x;

    vec3 color = vec3(y);

    // Plot a line
    float pct = plot(st,y);
    color = (1.008-pct)*color+pct*vec3(1.000,0.843,0.264);

	gl_FragColor = vec4(color,1.0);
}