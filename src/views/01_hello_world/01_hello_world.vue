<template>
  <div class="view">
    <h1>{{label}}</h1>
    <canvas id="c"/>
  </div>
</template>

<script>

var glsl = require('glslify')
var fragmentShaderSource = require("./fragment.glsl")
var vertexShaderSource = require("./vertex.glsl")
var FragmentShader = glsl(fragmentShaderSource);
var VertexShader = glsl(vertexShaderSource);


export default {
  name: 'HelloWorld01',
  props: ["label"],
  mounted() {

    function runShader() {
      var canvas = document.getElementById("c");

      var gl = canvas.getContext("webgl");


      //given a shader file, lets load it and compile it
      function createShader(gl, type, source) {
        var shader = gl.createShader(type);
        gl.shaderSource(shader, source);
        gl.compileShader(shader);
        var success = gl.getShaderParameter(shader, gl.COMPILE_STATUS);
        if (success) {
          return shader;
        } else {
          // console.log(gl.getShaderInfoLog(shader));
          gl.deleteShader(shader);
        }
      }

      //link the 2 shaders into a program
      function createProgram(gl, vertexShader, fragmentShader) {
        var program = gl.createProgram();
        gl.attachShader(program, vertexShader);
        gl.attachShader(program, fragmentShader);
        gl.linkProgram(program);
        var success = gl.getProgramParameter(program, gl.LINK_STATUS);
        if (success) {
          return program;
        } else {
          // console.log(gl.getProgramInfoLog(program));
          gl.deleteProgram(program);
        }
      }

      if (gl) {
        var vertexShaderSource = VertexShader;
        var fragmentShaderSource = FragmentShader;

        var vertexShader = createShader(gl, gl.VERTEX_SHADER, vertexShaderSource);
        var fragmentShader = createShader(gl, gl.FRAGMENT_SHADER, fragmentShaderSource);

        var program = createProgram(gl, vertexShader, fragmentShader);


        // now we can supply data to the glsl program
        // looking up attribute l;ocations is something you should do during intialization, not the render loop
        var positionAttributeLocation = gl.getAttribLocation(program, "a_position");

        var positionBuffer = gl.createBuffer();


        //bind points are like little internal global variables inside webgl
        //first you bind a resource to a bind point
        // then all other functions refer to the resource though the bind point
        gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);

        var positions = [
          0, 0,
          0, 0.5,
          0.6, 0,
        ];

        //The last argument, gl.STATIC_DRAW is a hint to WebGL about how we'll use the data. WebGL can try to use that hint to optimize certain things. gl.STATIC_DRAW tells WebGL we are not likely to change this data much.
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(positions), gl.STATIC_DRAW);


        //this is a helper function
        // webgl-utils.resizeCanvasToDisplaySize(gl.canvas);
        gl.canvas.height = canvas.getBoundingClientRect().height
        gl.canvas.width = canvas.getBoundingClientRect().width

        //pass the size of the canvas, maps it to the clipspace
        gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);


        // Clear the canvas
        gl.clearColor(0, 0, 0, 0);
        gl.clear(gl.COLOR_BUFFER_BIT);

        // Tell it to use our program (pair of shaders)
        gl.useProgram(program);

        //tell webgl how to take data from the bnuffer we set up
        gl.enableVertexAttribArray(positionAttributeLocation);

        //TELL the program how to extract teh data
        // Bind the position buffer.
        gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);

        // Tell the attribute how to get data out of positionBuffer (ARRAY_BUFFER)
        var size = 2;          // 2 components per iteration
        var type = gl.FLOAT;   // the data is 32bit floats
        var normalize = false; // don't normalize the data
        var stride = 0;        // 0 = move forward size * sizeof(type) each iteration to get the next position
        var offset = 0;        // start at the beginning of the buffer

        //this binds the current array_buffer to the attribute
        gl.vertexAttribPointer(
            positionAttributeLocation, size, type, normalize, stride, offset)

        var primitiveType = gl.TRIANGLES;
        var count = 3;
        gl.drawArrays(primitiveType, offset, count);
      }
    }
    this.$nextTick(function () {
      // Code that will run only after the
      // entire view has been rendered
      runShader();
    })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

#c {
  width: 500px;
  height: 500px;
  box-shadow: 0 2px 2px rgba(0,0,0,0.3)
}
</style>
