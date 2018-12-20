import Vue from 'vue'
import Router from 'vue-router'
import Home00 from './views/00_home/00_home.vue'
import HelloWorld01 from './views/01_hello_world/01_hello_world.vue'
import HelloWorld02 from "./views/02_hello_world_three/02_hello_world_three";
import Uniforms03 from "./views/03_uniforms/03_uniforms.vue";
import ShapingFunction04 from "./views/04_shaping_functions/04_shaping_functions";
import Colors05 from "./views/05_colors/05_colors.vue";
import ColorsWithVertexAttributes05_1 from "./views/05.1_colors_with_vertex_attributes/05.1_colors_with_vertex_attributes.vue";
import ColorsWithVertexAttributes05_2 from "./views/05.2_colors_vertex_plain/05.2_colors_vertex_plain.vue";
import Shapes06 from "./views/06_shapes/06_shapes.vue";

Vue.use(Router)

export const routes = [
  {
    path: '/',
    name: 'home',
    className: "home",
    component: Home00,
    props: {
      label: "Experiments With Shaders",
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
  },
  {
    path: "/05-color",
    name: "color",
    component: Colors05,
    props: {
      label: "05 - Color",
    }
  },
  {
    path: "/05-1-color-with-attributes",
    name: "color-with-vertex-attributes",
    component: ColorsWithVertexAttributes05_1,
    props: {
      label: "05.1 - Color With Vertex Attributes",
    }
  },
  {
    path: "/05-2-color-with-attributes-plain",
    name: "color-with-vertex-attributes-plain",
    component: ColorsWithVertexAttributes05_2,
    props: {
      label: "05.2 - Color With Vertex Attributes (No Three)",
    }
  },
  {
    path: "/06-Shapes",
    name: "shapes",
    component: Shapes06,
    props: {
      label: "06 - Shapes",
    }
  }
]

export default new Router({
  routes
})
