<template>
  <div class="view">

    <h1>{{label}}</h1>
    <p>
      Now that we have our examples set up, we can start looking at how information is passed to the gpu. T
      here are four main ways we can pass data to the GPU: Uniforms, varyings, attributes/buffers, and textures.
    </p>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="fragmentShaderSource"/>
    <div id="c"/>
    <div>
      <h4>Some notes from book of shaders</h4>
    </div>
  </div>
</template>

<script>

import CodeBlock from "../../Components/CodeBlock.vue";

var THREE = require("three");
var fragmentShaderSource = require("./fragment.glsl")
var vertexShaderSource = require("./vertex.glsl")


export default {
  name: 'Uniforms03',
  components: { CodeBlock },
  data() {
    return { fragmentShaderSource }
  },
  props: ["label"],
  methods: {
    onChangeFragmentShader: function (newVal) {
      this.fragmentShaderSource = newVal;

      var container = document.getElementById( 'c' );

      container.removeChild(container.childNodes[0]);
      this.runShader();
    },
    runShader: function() {
      var container;
      var camera, scene, renderer;
      var uniforms;

      const init = () => {
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
              vertexShader: vertexShaderSource,
              fragmentShader: this.fragmentShaderSource
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

      const onWindowResize = () =>  {
          renderer.setSize(container.getBoundingClientRect().width, container.getBoundingClientRect().height);
          uniforms.u_resolution.value.x = renderer.domElement.width;
          uniforms.u_resolution.value.y = renderer.domElement.height;
      }

      const animate = () => {
          requestAnimationFrame( animate );
          render();
      }

      const render = () => {
          uniforms.u_time.value += 0.05;
          renderer.render( scene, camera );
      }



      init();
      animate();
    }

  },
  mounted() {
    this.$nextTick(function () {
      // Code that will run only after the
      // entire view has been rendered
      this.runShader();
    })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

a {
  color: #eb357f;
}
#c {
  width: 500px;
  height: 500px;
  box-shadow: 0 2px 2px rgba(0,0,0,0.3);
  margin: 0 auto;
}
</style>
