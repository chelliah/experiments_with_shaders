#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;

  vec3 color = vec3(.0);

  // Cell positions
  vec2 point[5];
  point[0] = vec2(0.690,0.570);
  point[1] = vec2(0.60,0.07);
  point[2] = vec2(0.28,0.64);
  point[3] =  vec2(0.31,0.26);
  point[4] = u_mouse/u_resolution;


  float m_dist = 1.;  // minimun distance
  vec2 m_point;

  // Iterate through the points positions
  for (int i = 0; i < 5; i++) {
      float dist = distance(st, point[i]);

      // Keep the closer distance
      // m_dist = min(m_dist, dist);
      if (dist < m_dist) {
        m_dist = dist;

        //hold onto the point
        m_point = point[i];
      }
  }

  // draw the min distance (Distance field)
  color += m_dist*2.;

  // add tint according to closest point
  color.rg = m_point;

  gl_FragColor = vec4(color,1.0);

}