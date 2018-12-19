<template>
  <div class="view">

    <h1>{{label}}</h1>
    <p>
      Now that we have our examples set up, we can start looking at how information is passed to the gpu.
      There are four main ways we can pass data to the GPU: Uniforms, varyings, attributes/buffers, and textures.
      Uniforms are consistent across all pixels acted on by the GPU
    </p>
    <example-button-row :shader-options="shaderOptions" :callback="onChangeFragmentShader"/>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="fragmentShaderSource"/>
    <basic-renderer :fragment-shader="fragmentShaderSource" :vertex-shader="vertexShaderSource"/>
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
import BasicRenderer from "../../Components/BasicRenderer.vue";

var fragmentShaderSource = require("./fragment.glsl")
var fragmentShaderSource2 = require("./fragment2.glsl")
var vertexShaderSource = require("./vertex.glsl")


export default {
  name: 'Uniforms03',
  components: { CodeBlock, ExampleButtonRow, BasicRenderer },
  data() {
    return {
      fragmentShaderSource,
      vertexShaderSource,
      shaderOptions: [fragmentShaderSource, fragmentShaderSource2]
     }
  },
  props: ["label"],
  methods: {
    onChangeFragmentShader: function (newVal) {
      this.fragmentShaderSource = newVal;
    }
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
