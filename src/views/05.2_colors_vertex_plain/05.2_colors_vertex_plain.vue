<template>
  <div class="view">
    <h1>{{label}}</h1>
    <code-block is-editable="false" :code="runShaderCode"/>
    <canvas id="c"/>
  </div>
</template>

<script>
import CodeBlock from "../../Components/CodeBlock.vue";


var fragmentShaderSource = require("./fragment.glsl")
var vertexShaderSource = require("./vertex.glsl")

function runShader() {
  //from fathominfo
  var canvas = document.getElementById('c'),
    gl = canvas.getContext('webgl', {}),
    program,
    W = 500,
    H = 500,

    positionLocation,

    // New: we are going to pass some colors from js to the shader
    colorLocation
    ;

  // make the canvas fill the window
  canvas.width = W;
  canvas.height = H;

  function initGLData() {
    // now we can get some config info
    gl.viewport(0, 0, W, H);

    positionLocation = gl.getAttribLocation(program, "a_position");
    gl.enableVertexAttribArray(positionLocation);
    var buffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      /**
      note that unlike processing or canvas.getContext('2d'),
      the screen coordinates are
        -1, 1 left to right
        1, -1 top to bottom
        and 0, 0 is the center
      and because GL is finicky, you have to specify them as floats,
      not ints, so add that '.0' to the end
      */
      new Float32Array([
        -1.0, 1.0,
         1.0, 1.0,
        -1.0, -1.0,
         1.0, -1.0
      ]),
      gl.STATIC_DRAW
    );
    gl.vertexAttribPointer(positionLocation, 2, gl.FLOAT, false, 0, 0);


    // New: get the place where the shader wants us to put colors
    colorLocation = gl.getAttribLocation(program, "a_color");
    gl.enableVertexAttribArray(colorLocation);
    buffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
    gl.bufferData(gl.ARRAY_BUFFER,
      // we send over a color for each vertex
      new Float32Array([
        1.0,  1.0,  1.0,  1.0,    // white
        1.0,  0.0,  0.0,  1.0,    // red
        0.0,  1.0,  0.0,  1.0,    // green
        0.0,  0.0,  1.0,  1.0,    // blue
      ]),
      gl.STATIC_DRAW);
    gl.vertexAttribPointer(colorLocation, 4, gl.FLOAT, false, 0, 0);

  }




  function draw() {
    // Set clear color to black, fully opaque
    gl.clearColor(0.0, 0.0, 0.0, 1.0);
    // Clear the color buffer with specified clear color
    gl.clear(gl.COLOR_BUFFER_BIT);
    gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
  }






  // ██████╗  ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗     ███████╗████████╗██╗   ██╗███████╗███████╗
  // ██╔══██╗██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝     ██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝
  // ██████╔╝██║   ██║██████╔╝██║██╔██╗ ██║██║  ███╗    ███████╗   ██║   ██║   ██║█████╗  █████╗
  // ██╔══██╗██║   ██║██╔══██╗██║██║╚██╗██║██║   ██║    ╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝
  // ██████╔╝╚██████╔╝██║  ██║██║██║ ╚████║╚██████╔╝    ███████║   ██║   ╚██████╔╝██║     ██║
  // ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝

  compileGL();
  initGLData();
  requestDraw();


  // build our program
  function compileGL() {
    var frag = loadShader(gl, gl.FRAGMENT_SHADER, fragmentShaderSource);
    var vert = loadShader(gl, gl.VERTEX_SHADER, vertexShaderSource);
    program = gl.createProgram();
    gl.attachShader(program, vert);
    gl.attachShader(program, frag);
    gl.linkProgram(program);
    gl.useProgram(program);
  }

  function requestDraw() {
    requestAnimationFrame(draw);
  }

  // straight outta mozilla
  //https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Adding_2D_content_to_a_WebGL_context
  function loadShader(gl, type, source) {
    const shader = gl.createShader(type);
    // Send the source to the shader object
    gl.shaderSource(shader, source);
    // Compile the shader program
    gl.compileShader(shader);
    // See if it compiled successfully
    if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
      alert('An error occurred compiling the shaders: ' + gl.getShaderInfoLog(shader));
      gl.deleteShader(shader);
      return null;
    }
    return shader;
  }

}


export default {
  name: 'HelloWorld01',
  props: ["label"],
  components: { CodeBlock },
  data() {
    return { runShaderCode: runShader.toString() }
  },
  methods: {
    runShader
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
  margin: 0 auto;
  box-shadow: 0 2px 2px rgba(0,0,0,0.3)
}
</style>
