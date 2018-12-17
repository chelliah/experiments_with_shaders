import Vue from 'vue'
import Router from 'vue-router'
import Home00 from './views/00_home/00_home.vue'
import HelloWorld01 from './views/01_hello_world/01_hello_world.vue'

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
    label: "Example 01",
    component: HelloWorld01
  }
]

export default new Router({
  routes
})
