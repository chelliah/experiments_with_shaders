<template>
  <div class="view">

    <h1>{{label}}</h1>
    <example-button-row :shader-options="shaderOptions" :callback="onChangeFragmentShader"/>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="fragmentShaderSource"/>
    <basic-renderer :fragment-shader="fragmentShaderSource" :vertex-shader="vertexShaderSource"/>
    <code-block
      :isEditable="false"
      code="float amplitude = 1.;
        float frequency = 1.;
        y = sin(x * frequency);
        float t = 0.01*(-u_time*130.0);
        y += sin(x*frequency*2.1 + t)*4.5;
        y += sin(x*frequency*0.768 + t*1.121)*4.0;
        y += sin(x*frequency*2.221 + t*0.437)*5.0;
        y += sin(x*frequency*3.1122+ t*4.269)*2.5;
        y *= amplitude*0.06;"/>
    <ul>
      <li>Superposition - the property waves have which allow them to add up</li>
      <li>By adding different iterations of noise (octaves), where we successively increment the frequencies in the regular steps (lacunarity)</li>
      <li> Increasing frequency as the range (st.x) is narrowed is an essential tool to understanding fractals (although not a true fractal)</li>
      <li><a href="http://www.iquilezles.org/www/articles/morenoise/morenoise.htm" target="_blank"> super confusing but also maybe interesting once I understand more stuff</a></li>
    </ul>
  </div>
</template>
s
<script>

import CodeBlock from '../../Components/CodeBlock.vue'
import ExampleButtonRow from '../../Components/ExampleButtonRow.vue'
import BasicRenderer from '../../Components/BasicRenderer.vue'

var fragmentShaderSource = require('./fragment.glsl')

var fragmentShaderSource2 = require('./fragment2.glsl')
var fragmentShaderSource3 = require('./fragment3.glsl')
var fragmentShaderSource4 = require('./fragment4.glsl')
var fragmentShaderSource5 = require('./fragment5.glsl')

var vertexShaderSource = require('./vertex.glsl')

export default {
  name: 'Matrices07',
  components: {
    CodeBlock,
    BasicRenderer,
    ExampleButtonRow
  },
  data () {
    return {
      fragmentShaderSource,
      vertexShaderSource,
      shaderOptions: [
        fragmentShaderSource,
        fragmentShaderSource2,
        fragmentShaderSource3,
        fragmentShaderSource4,
        fragmentShaderSource5
      ]
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
