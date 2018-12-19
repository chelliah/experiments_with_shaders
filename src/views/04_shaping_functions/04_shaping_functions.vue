<template>
  <div class="view">

    <h1>{{label}}</h1>

    <example-button-row :shader-options="shaderOptions" :callback="onChangeFragmentShader"/>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="selectedShader"/>
    <div id="c"/>
    <div>
      <p><a href="https://www.desmos.com/calculator/xykhidbkbg" target="_blank">Here</a> is a nice visualizer to see how smoothstep works</p>
      <p>Basically, smoothstep takes three values: the lower limit (edge0), the upper limit (edge1), and the actual value to normalize</p>
      <p>smoothstep performs smooth Hermite interpolation between 0 and 1 when <code>edge0 &lt; x &lt; edge1</code>. If x is less than edge0, it returns a value of 0, if x is greater than edge1, it returns a value of 1. This is useful in cases where a threshold function with a smooth transition is desired.</p>    </div>
    </div>
</template>

<script>

import CodeBlock from "../../Components/CodeBlock.vue";
import ExampleButtonRow from "../../Components/ExampleButtonRow.vue";

var THREE = require("three");
var fragmentShaderSource = require("./fragment.glsl")
var fragmentShaderSource2 = require("./fragment2.glsl")
var vertexShaderSource = require("./vertex.glsl")


export default {
  name: 'ShapingFunctions04',
  components: { CodeBlock, ExampleButtonRow },
  data() {
    return {
      selectedShader: fragmentShaderSource,
      shaderOptions: [fragmentShaderSource, fragmentShaderSource2]
    }
  },
  props: ["label"],
  methods: {
    onChangeFragmentShader: function (newVal) {
      this.selectedShader = newVal;

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
              fragmentShader: this.selectedShader
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

#c {
  width: 500px;
  height: 500px;
  box-shadow: 0 2px 2px rgba(0,0,0,0.3);
  margin: 0 auto;
}
</style>
