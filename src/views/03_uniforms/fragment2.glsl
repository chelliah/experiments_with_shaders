#ifdef GL_ES
precision mediump float;
#endif

//this example uses two uniforms, time and screen resolution
// it also changes both the R G and B values of the FragColor

uniform vec2 u_resolution;  // Canvas size (width,height)
uniform float u_time;

void main() {
    //here we normalize (conver to 0.0 to 1.0 scale) this value by dividing against the total resoluton of the screen
    //gl_Fragcoord assumes the bottom-left point of the canvas as the origin
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

  gl_FragColor = vec4(st.x*abs(sin(u_time)),abs(cos(u_time))*st.y,st.y*abs(cos(u_time)),1.0);
}