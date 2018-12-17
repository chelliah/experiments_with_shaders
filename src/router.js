import Vue from 'vue'
import Router from 'vue-router'
import Home00 from './views/00_home/00_home.vue'
import HelloWorld01 from './views/01_hello_world/01_hello_world.vue'
import HelloWorld02 from "./views/02_hello_world_three/02_hello_world_three";

Vue.use(Router)

export const routes = [
  {
    path: '/',
    name: 'home',
    className: "home",
    label: "Examples With Shaders",
    component: Home00
  },
  {
    path: '/01-hello-world',
    name: 'hello-world',
    label: "01 - Hello World",
    component: HelloWorld01
  },
  {
    path: "/02-hello-world-three",
    name: "hello-world-three",
    label: "02 - Hello World (Three js)",
    component: HelloWorld02
  }
]

export default new Router({
  routes
})
