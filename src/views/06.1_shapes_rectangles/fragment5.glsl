uniform vec2 u_resolution;
uniform float u_time;


vec3 vertLineFull(in float leftIndex) {
  //returns the color black for pixels that fall within the range
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  float edge1 = 1. - smoothstep(leftIndex - 0.02, leftIndex, st.x);
  float edge2 = smoothstep(leftIndex + 0.03, leftIndex + 0.03 + 0.02, st.x);

  return vec3(max(edge1, edge2));
}

vec3 horizLineFull(in float topIndex) {

  //returns the color black for pixels that fall within the range
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  float edge1 = 1. - smoothstep(topIndex - 0.02, topIndex, 1.0 - st.y);
  float edge2 = smoothstep(topIndex + 0.03, topIndex + 0.03 + 0.02, 1.0 - st.y);

  return vec3(max(edge1, edge2));
}

vec3 rect(in vec2 location, in vec2 size,  in vec3 color) {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;

  float edgeLeft = 1. - smoothstep(location.x - 0.02, location.x, st.x);
  float edgeRight = smoothstep(location.x + size.x, location.x + size.x + 0.02, st.x);
  float h = max(edgeLeft, edgeRight);

  float edgeTop = 1. - smoothstep(location.y - 0.02, location.y, 1.0 - st.y);
  float edgeBottom = smoothstep(location.y + size.y, location.y + size.y + 0.02, 1.0 - st.y);
  float y = max(edgeTop, edgeBottom);

  // if color is white, let it return that, otherwise, return the color for anything within the enclosed spce
  return max(vec3(max(y,h)), color);
}

void main() {
  vec3 color = vec3(0.0);


  // first line, vertical, full height (left 15)
  vec3 vl1 = vertLineFull(0.15);
    // second line, vertical, full height (left 60)
  vec3 vl2 = vertLineFull(0.6);

  vec3 vl3 = vertLineFull(0.9);

  vec3 hl1 = horizLineFull(0.3);

  vec3 hl2 = horizLineFull(0.45);


  //black lines which span across part of the canvas
  vec3 r1 = rect(vec2(0.05, 0.0), vec2(0.03, 0.45), vec3(0.0,0.0,0.0));
  vec3 r2 = rect(vec2(0.18, 0.75), vec2(0.82, 0.03), vec3(0.0,0.0,0.0));

  // red box
  vec3 r3 = rect(vec2(0.0, 0.0), vec2(0.15, 0.45), vec3(1.0,0.0,0.0));

  //blue box
  vec3 r4 = rect(vec2(0.63, 0.78), vec2(0.37, 0.22), vec3(0.0,0.0,1.0));

  // yellow box
  vec3 r5 = rect(vec2(0.93, 0.0), vec2(0.07, 0.45), vec3(1.0,0.8,0.1));

  gl_FragColor = vec4(vl1*vl2*vl3*hl1*hl2*r1*r2*r3*r4*r5, 1.0);
}