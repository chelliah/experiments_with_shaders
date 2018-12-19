#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Plot a line on Y using a value between 0.0-1.0
//plot returns a value somehwere between 0.0 and 1.0
float plot(vec2 st){
    //smoothstep will basically normalize the differencxe between st.x-0.02 and st.x so long as the third value (st.y), lies inbetween them
    // if y is further than 0.02 from x, smoothstep will either return a value of 0 or 1
  return  smoothstep( st.x-0.02, st.x, st.y) -
          smoothstep( st.x, st.x+0.02, st.y);
}

void main() {
    //ST is a 2d vector, mapping from the bottom left to the top right of the screen
	vec2 st = gl_FragCoord.xy/u_resolution;

    //sets the inital color, which should be a greyscale value between 0.0 and 1.0
    // vec3(0.5) could be rewritten as vec3(0.5, 0.5, 0.5)
    vec3 color = vec3(st.x);

    // the plot function takes in the st vector
    float pct = plot(st);
    // vec3(0.0,1.0,0.0) is the color GREEN
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}
