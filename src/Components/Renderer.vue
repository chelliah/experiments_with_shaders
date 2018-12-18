<template>
  <div id="c"/>
</template>

<script>

var THREE = require("three");

var glsl = require('glslify')
var fragmentShaderSource = require("./fragment.glsl")
var vertexShaderSource = require("./vertex.glsl")
var FragmentShader = glsl(fragmentShaderSource);
var VertexShader = glsl(vertexShaderSource);


export default {
  name: 'Renderer',
  props: ["vertexShader", "fragmentShader", "init", "animate"],
  mounted() {
    this.$nextTick(function () {
      // Code that will run only after the
      // entire view has been rendered
      runShader();
    })

    function runShader() {
      var container;
      var camera, scene, renderer;
      var uniforms;

      this.init && ithis.init();
      this.animate && this.animate();

      function onWindowResize( event ) {
          renderer.setSize(container.getBoundingClientRect().width, container.getBoundingClientRect().height);
          uniforms.u_resolution.value.x = renderer.domElement.width;
          uniforms.u_resolution.value.y = renderer.domElement.height;
      }

      function render() {
          uniforms.u_time.value += 0.05;
          renderer.render( scene, camera );
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

#c {
  width: 500px;
  height: 500px;
  box-shadow: 0 2px 2px rgba(0,0,0,0.3);
  margin: 0 auto;
}
</style>
