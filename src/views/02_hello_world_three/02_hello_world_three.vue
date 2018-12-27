<template>
  <div class="view">

    <h1>{{label}}</h1>
    <p>So yeah that was hard, from this point on I decided to use <a href="https://threejs.org/" target="_blank">Three.js</a> to
     handle some of the super low level stuff. I wasnt able to figure out how to get the vertex shader working like it did
     in the last example, but since three has better tools for geometry, i'll just focus on the fragment shader for now. </p>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="fragmentShaderSource"/>
    <basic-renderer :fragment-shader="fragmentShaderSource" :vertex-shader="vertexShaderSource"/>
    <div>
      <h4>Some notes from book of shaders</h4>
      <ul>
        <li>Shader Language has a single <strong>main()</strong> function that returns a color at the end. This is similar to C.</li>
        <li>The final pixel color is assigned to the reserved global variable <strong>gl_FragColor</strong>.</li>
        <li>GLSL has built-in variables (like gl_FragColor), functions and types. This example uses vec4, a four dimensional vector of floating point precision. In the example, these four values are RED, GREEN, BLUE and ALPHA channels. Also we can see that these values are normalized, which means they go from 0.0 to 1.0.</li>
        <li>GLSL has preprocessor macros. Macros are part of a pre-compilation step. With them it is possible to #define global variables and do some basic conditional operation (with #ifdef and #endif). All the macro comands begin with a hashtag (#). Pre-compilation happens right before compiling and copies all the calls to #defines and check #ifdef (is defined) and #ifndef (is not defined) conditionals. In our "hello world!" example above, we only insert the line 2 if GL_ES is defined, which mostly happens when the code is compiled on mobile devices and browsers.</li>
        <li>Float types are vital in shaders, so the level of precision is crucial. Lower precision means faster rendering, but at the cost of quality. You can be picky and specify the precision of each variable that uses floating point. In the first line (precision mediump float;) we are setting all floats to medium precision. But we can choose to set them to low (precision lowp float;) or high (precision highp float;).</li>
        <li>The last, and maybe most important, detail is that GLSL specs don’t guarantee that variables will be automatically casted. What does that mean? Manufacturers have different approaches to accelerate graphics card processes but they are forced to guarantee minimum specs. Automatic casting is not one of them. In our “hello world!” example vec4 has floating point precision and for that it expects to be assigned with floats. If you want to make good consistent code and not spend hours debugging white screens, get used to putting the point (.) in your floats. This kind of code will not always work:</li>
      </ul>
    </div>
  </div>
</template>

<script>

import CodeBlock from '../../Components/CodeBlock.vue'
import BasicRenderer from '../../Components/BasicRenderer.vue'

var fragmentShaderSource = require('./fragment.glsl')
var vertexShaderSource = require('./vertex.glsl')

export default {
  name: 'HelloWorld02',
  components: { CodeBlock, BasicRenderer },
  methods: {
    onChangeFragmentShader: function (newVal) {
      this.fragmentShaderSource = newVal
    }
  },
  data () {
    return {
      fragmentShaderSource,
      vertexShaderSource
    }
  },
  props: ['label']
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
