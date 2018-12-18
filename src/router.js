import Vue from 'vue'
import Router from 'vue-router'
import Home00 from './views/00_home/00_home.vue'
import HelloWorld01 from './views/01_hello_world/01_hello_world.vue'
import HelloWorld02 from "./views/02_hello_world_three/02_hello_world_three";
import Uniforms03 from "./views/03_uniforms/03_uniforms.vue";
import ShapingFunction04 from "./views/04_shaping_functions/04_shaping_functions";

Vue.use(Router)

export const routes = [
  {
    path: '/',
    name: 'home',
    className: "home",
    component: Home00,
    props: {
      label: "Examples With Shaders",
    }
  },
  {
    path: '/01-hello-world',
    name: 'hello-world',
    label: "01 - Hello World",
    component: HelloWorld01,
    props: {
      label: "01 - Hello World"
    }
  },
  {
    path: "/02-hello-world-three",
    name: "hello-world-three",
    component: HelloWorld02,
    props: {
      label: "02 - Hello World (Three js)",
    }
  },
  {
    path: '/03-uniforms',
    name: 'uniforms',
    label: "03 - Uniforms",
    component: Uniforms03,
    props: {
      label: "03 - Uniforms"
    }
  },
  {
    path: "/04-shaping-functions",
    name: "shaping-functions",
    component: ShapingFunction04,
    props: {
      label: "04 - Shaping Functions",
    }
  }
]

export default new Router({
  routes
})
