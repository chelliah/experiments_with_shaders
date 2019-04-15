<template>
  <div>
    <div id="c"/>
  </div>
</template>

<script>
var THREE = require('three')
import CanvasRecorder from "../../Components/canvasRecorder";
import hourly from "./hourly.json";
import vertexShader from "./vertex.glsl"
import fragmentShader from "./fragment.glsl"
// var CCapture = require('../assets/CCapture')

export default {
  name: 'BasicRenderer',
  data () {
    return {
      fov: 30,
      hourlyIndex: 0,
      numHours: hourly.list.length,
      fragmentShader,
      vertexShader,
      shouldRender: false,
      container: document.getElementById('c'),
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
    fragmentShader: function () {
      this.onChangeFragmentShader()
    },
    hourlyIndex: function() {
      this.setWindspeed();
    }
  },
  methods: {
    setRandomHourlyInterval: function() {
      this.hourlyIndex = Math.floor(Math.random() * 96)
    },
    setWindspeed() {
      const { wind = {} } = hourly.list[this.hourlyIndex];
      this.uniforms.u_windspeed.value = wind.speed;
    },
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
      this.renderer.setSize(window.innerWidth, window.innerHeight)
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.uniforms.u_resolution.value.x = this.renderer.domElement.width
      this.uniforms.u_resolution.value.y = this.renderer.domElement.height
    },
    init: function() {
      this.shouldRender = true;
      this.container = document.getElementById('c')

      //set camera
      this.camera = new THREE.PerspectiveCamera(
        this.fov,
        window.innerWidth / window.innerHeight,
        1,
        10000
      );
      this.camera.position.z = 100;
      this.camera.position.y = -10;

      this.renderer = new THREE.WebGLRenderer()
      this.renderer.setPixelRatio(window.devicePixelRatio)
      this.canvasElement = this.renderer.domElement

      this.scene = new THREE.Scene()
      var geometry = new THREE.IcosahedronGeometry( 15, 4 );

      this.uniforms = {
        u_time: { type: 'f', value: 1.0 },
        u_resolution: { type: 'v2', value: new THREE.Vector2() },
        u_mouse: { type: 'v2', value: new THREE.Vector2() },
        u_windspeed: {  value: 10.0 }
      }

      // set material
      // var material = new THREE.MeshBasicMaterial( {
      //   color: 0xb7ff00,
      //   wireframe: true
      // } );

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

      this.setWindspeed();
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
    setInterval(this.setRandomHourlyInterval, 3000);
    this.$nextTick(function () {
      // Code that will run only after the
      // entire view has been rendered
      this.runShader()
    })
  },
  beforeDestroy() {
    clearInterval(this.setRandomHourlyInterval)
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
  width: 100vw;
  height: 100vh;
  position: absolute;
  /* box-shadow: 0 2px 2px rgba(0,0,0,0.3); */
  left: 0;
  top: 0;
  margin: 0 auto;
}
</style>
