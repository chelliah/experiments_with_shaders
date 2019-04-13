// Author: Inigo Quiles
// Title: Expo

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define red vec3(1.0, 0.2, 0.2)
#define light_grey vec3(0.8)
#define white vec3(1.)
#define black vec3(0.)

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

mat2 rotate2d(float _angle) {
  return mat2(cos(_angle),-sin(_angle),
              sin(_angle),cos(_angle));
}

vec3 diagonalStripe(in vec2 _st, in vec3 _stripe_color, in vec3 _bg_color) {
  float stripeVal =  step(mod(_st.y  - mod(_st.x, 0.04), 0.04), 0.02);

  // if (isVert) {
  //   stripeVal =  step(mod(_st.x + 0.02  - mod(_st.y, 0.04), 0.04), 0.02);

  // }

  if(stripeVal >0.) {
    return _stripe_color - _bg_color;
  } else {
    return vec3(0.);
  }

}

float plot(in vec2 st, in float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

float stripePosition(in float _pos,in float _edge,in float _width){
  return step(_edge, _pos) *
         (1.-step(_edge + _width, _pos));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    st.x *= u_resolution.x;
    vec3 color = light_grey; // light grey

    st = st * rotate2d(PI*-0.25+(u_time/20.));
  st*= 3. + (4.*sin(u_time/40.)); //scale up the space by 3

  //you can also scale x and y values independently
  //st.x *=2.;
  //st.y *= 4.;


  st = fract(st); // wrap values around 1.0

    color += diagonalStripe(st, red, light_grey) * stripePosition(st.x, 0.7, 0.05);
    color += diagonalStripe(st, red, light_grey) * stripePosition(st.y, 0.3, 0.05);


    /// vertical blacks
    color += diagonalStripe(st, black, light_grey) * (1.-step(0.1, st.x)) * step(0.0, st.x);
   color += diagonalStripe(st, white, light_grey) * (1.-step(0.2, st.x)) * step(0.1, st.x);
    color += diagonalStripe(st, black, light_grey) * (1.-step(0.3, st.x)) * step(0.2, st.x);


   color += diagonalStripe(st, white, light_grey) * (1.-step(0.4, st.x)) * step(0.3, st.x);
    color += diagonalStripe(st, black, light_grey) * (1.-step(0.5, st.x)) * step(0.4, st.x);

    //horizontal blacks

    color += diagonalStripe(st, black, light_grey) * (1.-step(0.1, st.y)) * step(0.0, st.y);
    color += diagonalStripe(st, black, light_grey) * (1.-step(0.3, st.y)) * step(0.2, st.y);
    color += diagonalStripe(st, black, light_grey) * (1.-step(0.5, st.y)) * step(0.4, st.y);

    color += diagonalStripe(st, white, light_grey) * (1.-step(0.8, st.y)) * step(0.75, st.y);

    gl_FragColor = vec4(color,1.0);
}