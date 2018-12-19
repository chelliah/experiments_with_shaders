<template>
  <div class="view">

    <h1>{{label}}</h1>
    <p>
      Now that we have our examples set up, we can start looking at how information is passed to the gpu.
      There are four main ways we can pass data to the GPU: Uniforms, varyings, attributes/buffers, and textures.
      Uniforms are consistent across all pixels acted on by the GPU
    </p>
    <example-button-row :shader-options="shaderOptions" :callback="onChangeFragmentShader"/>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="selectedShader"/>
    <div id="c"/>
    <div>
      <h4>Some notes from book of shaders</h4>
      <p>
        The GPU has hardware accelerated angle, trigonometric and exponential functions. Some of those functions are: <code>sin()</code>, <code>cos()</code>, <code>tan()</code>, <code>asin()</code>, <code>acos()</code>, <code>atan()</code>, <code>pow()</code>, <code>exp()</code>, <code>log()</code>, <code>sqrt()</code>, <code>abs()</code>, <code>sign()</code>, <code>floor()</code>, <code>ceil()</code>, <code>fract()</code>, <code>mod()</code>, <code>min()</code>, <code>max()</code> and <code>clamp()</code>.
      </p>
      <p>In the second example we use <code>gl_FragCoord</code>, which holds the screen coordinates of the pixel or screen fragment that the active thread is working on. gl_FragCoord is considered a <strong>varying</strong>, because it differs based on the fragment which reads from it</p>
    </div>
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
  name: 'Uniforms03',
  components: { CodeBlock, ExampleButtonRow },
  data() {
    return {
      selectedShader: fragmentShaderSource,
      shaderOptions: [fragmentShaderSource, fragmentShaderSource2],
      container: document.getElementById('c'),
      camera: new THREE.Camera(),
      scene: new THREE.Scene(),
      renderer: new THREE.WebGLRenderer(),

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
      var uniforms;

      const init = () => {
          container = document.getElementById( 'c' );

          this.camera = new THREE.Camera();
          this.camera.position.z = 1;

          this.scene = new THREE.Scene();

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
          this.scene.add( mesh );

          this.renderer = new THREE.WebGLRenderer();
          this.renderer.setPixelRatio( window.devicePixelRatio );

          container.appendChild( this.renderer.domElement );

          onWindowResize();
          window.addEventListener( 'resize', onWindowResize, false );

          document.onmousemove = function(e){
            uniforms.u_mouse.value.x = e.pageX
            uniforms.u_mouse.value.y = e.pageY
          }
      }

      const onWindowResize = () =>  {
          this.renderer.setSize(container.getBoundingClientRect().width, container.getBoundingClientRect().height);
          uniforms.u_resolution.value.x = this.renderer.domElement.width;
          uniforms.u_resolution.value.y = this.renderer.domElement.height;
      }

      const animate = () => {
          requestAnimationFrame( animate );
          render();
      }

      const render = () => {
          uniforms.u_time.value += 0.01;
          this.renderer.render( this.scene, this.camera );
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
