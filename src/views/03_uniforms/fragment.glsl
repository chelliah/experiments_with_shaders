// Uniforms are the same across each pixel accessed by the GPU, so every pixel receives the same value
// uniforms are not static
uniform vec2 u_resolution;  // Canvas size (width,height)
uniform float u_time;       // Time in seconds since load
void main() {
    //gl_FragCoord is a built in variable, representing the 2d xy plane
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    //vec4 is composable in a number of different ways
    // vec4(vec3(1.0,0.0,1.0),1.0) would work, or vec4(1.0), which uses swizziling to interpret the remianing three values
    gl_FragColor=vec4(st.x,st.y,0.0,1.0);
}