<template>
  <div class="view">

    <h1>{{label}}</h1>
    <example-button-row :shader-options="shaderOptions" :callback="onChangeFragmentShader"/>
    <code-block :is-editable="true" :on-change="onChangeFragmentShader" :code="fragmentShaderSource"/>
    <basic-renderer :fragment-shader="fragmentShaderSource" :vertex-shader="vertexShaderSource"/>
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

var fragmentShaderSource5 = require('./fragment5.glsl')
var fragmentShaderSource6 = require('./fragment6.glsl')
var fragmentShaderSource7 = require('./fragment7.glsl')
var fragmentShaderSource8 = require('./fragment8.glsl')

var fragmentShaderSource9 = require('./fragment9.glsl')
var fragmentShaderSource10 = require('./fragment10.glsl')
var fragmentShaderSource11 = require('./fragment11.glsl')
var vertexShaderSource = require('./vertex.glsl')

export default {
  name: 'Noise10',
  components: {
    CodeBlock,
    BasicRenderer,
    ExampleButtonRow
  },
  data () {
    return {
      fragmentShaderSource,
      vertexShaderSource,
      shaderOptions: [fragmentShaderSource, fragmentShaderSource2, fragmentShaderSource3, fragmentShaderSource4, fragmentShaderSource5, fragmentShaderSource6, fragmentShaderSource7, fragmentShaderSource8, fragmentShaderSource9, fragmentShaderSource10, fragmentShaderSource11]
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
