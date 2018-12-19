<template>
  <div class="view">

    <h1>{{label}}</h1>
    <p>
      Colors can be manipulated a number of ways. While you can get creative with the way you
      assign specific rgba values, you also have a series of blending functions.
    </p>
    <example-button-row :shader-options="shaderOptions" :callback="onChangeFragmentShader"/>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="fragmentShaderSource"/>
    <basic-renderer :fragment-shader="fragmentShaderSource" :vertex-shader="vertexShaderSource"/>
    <div>
      <h4>Variables</h4>
      <p>Given a vec3, you have a few different ways of accessing specific values from it</p>
      <code-block
        :is-editable="false"
        code="vec4 vector;
vector[0] = vector.r = vector.x = vector.s;
vector[1] = vector.g = vector.y = vector.t;
vector[2] = vector.b = vector.z = vector.p;
vector[3] = vector.a = vector.w = vector.q;"/>
    </div>
      <p>Properties can be combined/altered in any order, through a feature called <strong>swizzling</strong>.</p>
      <code-block
        :is-editable="false"
        code="vec3 yellow, magenta, green;
// Making Yellow
yellow.rg = vec2(1.0);  // Assigning 1. to red and green channels
yellow[2] = 0.0;        // Assigning 0. to blue channel

// Making Magenta
magenta = yellow.rbg;   // Assign the channels with green and blue swapped

// Making Green
green.rgb = yellow.bgb; // Assign the blue channel of Yellow (0) to red and blue channels"/>
    <h4>Mixing</h4>
    <p>The <strong>mix()</strong> function takes two colors and a percentage to interpolate between the two. This can be a single value (0.0 to 1.0) or another vector (i.e. mix(vec3(1.0,0.0,0.0), vec3(1.0,0.0,1.0), vec3(1.0,1.0,0.0))</p>
    <h4>Functions and Arguments</h4>
    <p>You will notice an <strong>in</strong> before the type of the arguments. This is a qualifier and in this case it specifies that the variable is read only. In future examples we will see that it is also possible to define arguments as out or inout. This last one, inout, is conceptually similar to passing an argument by reference which will give us the possibility to modify a passed variable.</p>
    <code-block
      :is-editable="false"
      code="int newFunction(in vec4 aVec4,      // read-only
                out vec3 aVec3,     // write-only
                inout int aInt);    // read-write"/>
    <h4>Color Conversion</h4>
    <p><a href="http://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl/" target="_blank">This</a> is a handy guide on how the RGB to HSL conversions are done</p>
  </div>
</template>

<script>

import CodeBlock from "../../Components/CodeBlock.vue";
import ExampleButtonRow from "../../Components/ExampleButtonRow.vue";
import BasicRenderer from "../../Components/BasicRenderer.vue";

var fragmentShaderSource = require("./fragment.glsl")
// var fragmentShaderSource2 = require("./fragment2.glsl")
// var fragmentShaderSource3 = require("./fragment3.glsl")
// var fragmentShaderSource4 = require("./fragment4.glsl")
// var fragmentShaderSource5 = require("./fragment5.glsl")
// var vertexShaderSource = require("./vertex.glsl")



export default {
  name: 'Shapes06',
  components: {
    CodeBlock,
    BasicRenderer,
    ExampleButtonRow
  },
   data() {
    return {
      fragmentShaderSource,
      vertexShaderSource,
      shaderOptions: [fragmentShaderSource]
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
