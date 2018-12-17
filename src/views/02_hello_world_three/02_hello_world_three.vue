<template>
  <div class="view">
    <div id="c"/>
  </div>
</template>

<script>

var THREE = require("three");

var glsl = require('glslify')
var fragmengShaderSource = require("./fragment.glsl")
var vertexShaderSource = require("./vertex.glsl")
var FragmentShader = glsl(fragmengShaderSource);
var VertexShader = glsl(vertexShaderSource);


export default {
  name: 'HelloWorld02',
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

      init();
      animate();

      function init() {
          container = document.getElementById( 'c' );

          camera = new THREE.Camera();
          camera.position.z = 1;

          scene = new THREE.Scene();

          var geometry = new THREE.PlaneBufferGeometry( 2, 2 );

          uniforms = {
              u_time: { type: "f", value: 1.0 },
              u_resolution: { type: "v2", value: new THREE.Vector2() },
              u_mouse: { type: "v2", value: new THREE.Vector2() }
          };

          var material = new THREE.ShaderMaterial( {
              uniforms: uniforms,
              vertexShader: VertexShader,
              fragmentShader: FragmentShader
          } );

          var mesh = new THREE.Mesh( geometry, material );
          scene.add( mesh );

          renderer = new THREE.WebGLRenderer();
          renderer.setPixelRatio( window.devicePixelRatio );

          container.appendChild( renderer.domElement );

          onWindowResize();
          window.addEventListener( 'resize', onWindowResize, false );

          document.onmousemove = function(e){
            uniforms.u_mouse.value.x = e.pageX
            uniforms.u_mouse.value.y = e.pageY
          }
      }

      function onWindowResize( event ) {
          renderer.setSize(container.getBoundingClientRect().width, container.getBoundingClientRect().height);
          uniforms.u_resolution.value.x = renderer.domElement.width;
          uniforms.u_resolution.value.y = renderer.domElement.height;
      }

      function animate() {
          requestAnimationFrame( animate );
          render();
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
