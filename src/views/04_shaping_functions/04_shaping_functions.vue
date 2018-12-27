<template>
  <div class="view">

    <h1>{{label}}</h1>
    <p>
      Some of our previous examples showed ways we could vary color across the canvas
      by using <strong>uniforms</strong> and <strong>varyings</strong>.
      Now, let's focus on isolating these changes to a single dimension.
    </p>
    <example-button-row :shader-options="shaderOptions" :callback="onChangeFragmentShader"/>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="fragmentShaderSource"/>
    <basic-renderer :fragment-shader="fragmentShaderSource" :vertex-shader="vertexShaderSource"/>
    <div>
      <h4>Log, Exp, Pow</h4>
      <p>All of these functions help you alter what would otherwise be a linear normalization.</p>
      <h4>Sin, Cos, Tan</h4>
      <p>These basic trigonometric.</p>
      <h4>Smoothstep</h4>
      <p><a href="https://www.desmos.com/calculator/xykhidbkbg" target="_blank">Here</a> is a nice visualizer to see how smoothstep works</p>
      <p>Given a range of two numbers and a value, this function will interpolate the value between the defined range.</p>
      <h4>Step</h4>
      <p>Step also interpolates to 0.0 or 1.0, without any smoothing.</p>
      <h4>Extra functions</h4>
      <code>
        // y = mod(x,0.5); // return x modulo of 0.5
        // y = fract(x); // return only the fraction part of a number
        // y = ceil(x);  // nearest integer that is greater than or equal to x
        //y = floor(x); // nearest integer less than or equal to x
        //y = sign(x);  // extract the sign of x
        // y = abs(x);   // return the absolute value of x
        // y = clamp(x,0.0,1.0); // constrain x to lie between 0.0 and 1.0
        // y = min(0.0,x);   // return the lesser of x and 0.0
        // y = max(0.0,x);   // return the greater of x and 0.0
      </code>
      <h4>Resources</h4>
      <a href="http://www.iquilezles.org/apps/graphtoy/" target="_blank">Graph Toy - a resource for visualizing opengl functions</a>
      <a href="http://tobyschachman.com/Shadershop/" target="_blank">Learn how to build more complex functions</a>
    </div>
  </div>
</template>

<script>

import CodeBlock from '../../Components/CodeBlock.vue'
import ExampleButtonRow from '../../Components/ExampleButtonRow.vue'
import BasicRenderer from '../../Components/BasicRenderer.vue'

var fragmentShaderSource = require('./fragment.glsl')
var fragmentShaderSource2 = require('./fragment2.glsl')
var fragmentShaderSource3 = require('./fragment3.glsl')
var fragmentShaderSource4 = require('./fragment4.glsl')
var vertexShaderSource = require('./vertex.glsl')

export default {
  name: 'ShapingFunctions04',
  components: { CodeBlock, ExampleButtonRow, BasicRenderer },
  data () {
    return {
      fragmentShaderSource,
      vertexShaderSource,
      shaderOptions: [fragmentShaderSource, fragmentShaderSource2, fragmentShaderSource3, fragmentShaderSource4]
    }
  },
  props: ['label'],
  methods: {
    onChangeFragmentShader: function (newVal) {
      this.fragmentShaderSource = newVal
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
a {

  color: #eb357f;
}
</style>
