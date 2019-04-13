#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;


  st *= 3.;

  vec2 i_st = floor(st);
  vec2 f_st = fract(st);

  vec3 color = vec3(.0);

  // Cell positions
  // vec2 point[5];
  // point[0] = vec2(0.690,0.570);
  // point[1] = vec2(0.60,0.07);
  // point[2] = vec2(0.28,0.64);
  // point[3] =  vec2(0.31,0.26);
  // point[4] = u_mouse/u_resolution;

  vec2 point = random2(i_st);
  float m_dist = 1.;  // minimun distance
  vec2 m_point;

  for (int y = -1; y <= 1; y++) {
    for (int x= -1; x<=1; x++) {
      vec2 neighbor = vec2(float(x), float(y));
      point = random2(i_st + neighbor);

      // Animate the point
      point = 0.5 + 0.5*sin(u_time + 16.2831*point);

      //vector between the pixel and the point
      // vec2 mouse_point = u_mouse/u_resolution;

      // vec2 diff = min(neighbor + point - f_st, mouse_point - f_st);
      vec2 diff = neighbor + point - f_st;
      float dist = length(diff);

      if (dist < m_dist) {
        m_dist = dist;
        m_point = point;
      }

      // m_dist = distance(m_dist, dist);
      // m_dist = min(m_dist, dist);
    }
  }

  // draw the min distance (Distance field)
  color += m_dist * 2.;
  color.rg = m_point;


  gl_FragColor = vec4(color,1.0);

}