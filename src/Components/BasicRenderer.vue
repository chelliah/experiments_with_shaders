<template>
  <div>
    <div id="c"/>
    <div class="record-actions">
      <div id="record-button" :class="{active: isRecording}" v-on:click="isRecording=!isRecording"></div>
    </div>
  </div>
</template>

<script>

var THREE = require('three')
import CanvasRecorder from "./canvasRecorder.js";
// var CCapture = require('../assets/CCapture')
const canvas_size = {
  x: 1440,
  y: 900
}
export default {
  name: 'BasicRenderer',
  props: ['vertexShader', 'fragmentShader'],
  data () {
    return {
      shouldRender: false,
      container: document.getElementById('c'),
      isRecording: false,
      canvasElement: null,
      camera: null,
      capturer: null,
      scene: new THREE.Scene(),
      renderer: new THREE.WebGLRenderer(),
      uniforms: {},
      mesh: {}
    }
  },
  watch: {
    isRecording: function (isNowRecording) {
      if(isNowRecording) {
        this.capturer && this.capturer.start();
      } else {
        this.capturer && this.capturer.stop();
        this.capturer.save();
      }
    },
    fragmentShader: function () {
      this.onChangeFragmentShader()
    }
  },
  methods: {
    onChangeFragmentShader: function () {
      this.clearAnimation();
      this.init();
    },
    clearAnimation: function() {
      //keeps multiple instances from continually sending in requestAnimationFrame calls
      this.shouldRender = false;
      this.container = document.getElementById('c')
      this.container && this.container.childNodes[0] && this.container.removeChild(this.container.childNodes[0])
      cancelAnimationFrame(this.animate);
      window.removeEventListener('resize', this.onWindowResize, false)
      window.removeEventListener('mousemove', this.onMouseMove, false);

    },
    animate: function() {
      this.shouldRender && requestAnimationFrame(this.animate)
      this.uniforms.u_time.value += 0.02
      this.renderer.render(this.scene, this.camera)
    },
    onMouseMove: function(e) {
      this.uniforms.u_mouse.value.x = e.pageX
      this.uniforms.u_mouse.value.y = e.pageY
    },
    onWindowResize: function() {
      this.renderer.setSize(this.container.getBoundingClientRect().width, this.container.getBoundingClientRect().height)
      this.uniforms.u_resolution.value.x = this.renderer.domElement.width
      this.uniforms.u_resolution.value.y = this.renderer.domElement.height
    },
    init: function() {
       this.shouldRender = true;
       this.container = document.getElementById('c')

        this.camera = new THREE.OrthographicCamera(canvas_size.x / -2, canvas_size.y / 2, canvas_size.x / 2, canvas_size.y / -2, 2, 1000)
        this.camera.position.z = 1

              this.renderer = new THREE.WebGLRenderer()
      this.renderer.setPixelRatio(window.devicePixelRatio)
      this.canvasElement = this.renderer.domElement

      this.scene = new THREE.Scene()
      var geometry = new THREE.PlaneBufferGeometry(2, 2)

      this.uniforms = {
        u_time: { type: 'f', value: 1.0 },
        u_resolution: { type: 'v2', value: new THREE.Vector2() },
        u_mouse: { type: 'v2', value: new THREE.Vector2() }
      }

      var material = new THREE.ShaderMaterial({
        uniforms: this.uniforms,
        vertexShader: this.vertexShader,
        fragmentShader: this.fragmentShader
      })
      material.needsUpdate = true;

      this.mesh = new THREE.Mesh(geometry, material)
      this.scene.add(this.mesh);
      this.container.appendChild(this.canvasElement)

        this.capturer = new CanvasRecorder(this.canvasElement)

        this.onWindowResize();
        window.addEventListener('resize', this.onWindowResize, false);
        window.addEventListener('mousemove', this.onMouseMove, false);
    },
    runShader: function () {
      this.init();
      this.animate()
    }

  },
  mounted () {
    this.$nextTick(function () {
      // Code that will run only after the
      // entire view has been rendered
      this.runShader()
    })
  },
  beforeDestroy() {

    this.clearAnimation();
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.record-actions {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

#record-button {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(0,0,0,0.3);
  cursor: pointer;
}

#record-button:hover, .record-button.active {
  background: rgba(215, 40, 40, 0.8)
}

#record-button.active {
  border-radius: 0;
}

#c {
  width: 1440px;
  height: 900px;
  box-shadow: 0 2px 2px rgba(0,0,0,0.3);
  margin: 0 auto;
}
</style>
