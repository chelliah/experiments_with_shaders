<template>
  <div>
    <div id="c"/>
    <div class="record-actions">
      <div id="record-button" :class="{active: isRecording}" v-on:click="captureStream"></div>
    </div>
  </div>
</template>

<script>

var THREE = require('three')
var CCapture = require('../assets/CCapture')

export default {
  name: 'BasicRenderer',
  props: ['vertexShader', 'fragmentShader'],
  data () {
    return {
      container: document.getElementById('c'),
      canvasElement: null,
      camera: null,
      capturer: null,
      scene: new THREE.Scene(),
      renderer: new THREE.WebGLRenderer()
    }
  },
  watch: {
    fragmentShader: function () {
      this.onChangeFragmentShader()
    }
  },
  methods: {
    onChangeFragmentShader: function () {
      var container = document.getElementById('c')
      container.removeChild(container.childNodes[0])
      this.runShader()
    },
    captureStream: function () {
      this.capturer.start()
    },
    runShader: function () {
      var container
      var uniforms

      const init = () => {
        container = document.getElementById('c')

        this.camera = new THREE.OrthographicCamera(500 / -2, 500 / 2, 500 / 2, 500 / -2, 2, 1000)
        this.camera.position.z = 1

        this.scene = new THREE.Scene()

        var geometry = new THREE.PlaneBufferGeometry(2, 2)

        uniforms = {
          u_time: { type: 'f', value: 1.0 },
          u_resolution: { type: 'v2', value: new THREE.Vector2() },
          u_mouse: { type: 'v2', value: new THREE.Vector2() }
        }

        var material = new THREE.ShaderMaterial({
          uniforms: uniforms,
          vertexShader: this.vertexShader,
          fragmentShader: this.fragmentShader
        })

        var mesh = new THREE.Mesh(geometry, material)
        this.scene.add(mesh)

        this.renderer = new THREE.WebGLRenderer()
        this.renderer.setPixelRatio(window.devicePixelRatio)
        this.capturer = new CCapture({ format: 'webm' })
        this.canvasElement = this.render.domElement

        container.appendChild(this.canvasElement)

        onWindowResize()
        window.addEventListener('resize', onWindowResize, false)

        document.onmousemove = function (e) {
          uniforms.u_mouse.value.x = e.pageX
          uniforms.u_mouse.value.y = e.pageY
        }
      }

      const onWindowResize = () => {
        this.renderer.setSize(container.getBoundingClientRect().width, container.getBoundingClientRect().height)
        uniforms.u_resolution.value.x = this.renderer.domElement.width
        uniforms.u_resolution.value.y = this.renderer.domElement.height
      }

      const animate = () => {
        requestAnimationFrame(animate)
        if (this.canvasElement && this.capturer) {
          this.capturer.capture(this.canvasElement)
        }
        render()
      }

      const render = () => {
        uniforms.u_time.value += 0.05
        this.renderer.render(this.scene, this.camera)
      }

      init()
      animate()
    }

  },

  mounted () {
    this.$nextTick(function () {
      // Code that will run only after the
      // entire view has been rendered
      this.runShader()
    })
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
  width: 1024px;
  height: 1024px;
  box-shadow: 0 2px 2px rgba(0,0,0,0.3);
  margin: 0 auto;
}
</style>
