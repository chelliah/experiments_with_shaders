<template>
  <div id="c"/>
</template>

<script>

var THREE = require("three");

export default {
  name: 'BasicRenderer',
  props: ["vertexShader", "fragmentShader", "init", "animate"],
  watch: {
    fragmentShader: function () {
      this.onChangeFragmentShader()
    }
  },
  methods: {
    onChangeFragmentShader: function () {

      var container = document.getElementById( 'c' );

      container.removeChild(container.childNodes[0]);
      this.runShader();
    },
    runShader: function() {
      var container;
      var uniforms;

      const init = () => {
          container = document.getElementById( 'c' );

          this.camera = new THREE.Camera();
          this.camera.position.z = 1;

          this.scene = new THREE.Scene();

          var geometry = new THREE.PlaneBufferGeometry( 2, 2 );

          uniforms = {
              u_time: { type: "f", value: 1.0 },
              u_resolution: { type: "v2", value: new THREE.Vector2() },
              u_mouse: { type: "v2", value: new THREE.Vector2() }
          };

          var material = new THREE.ShaderMaterial( {
              uniforms: uniforms,
              vertexShader: vertexShaderSource,
              fragmentShader: this.selectedShader
          } );

          var mesh = new THREE.Mesh( geometry, material );
          this.scene.add( mesh );

          this.renderer = new THREE.WebGLRenderer();
          this.renderer.setPixelRatio( window.devicePixelRatio );

          container.appendChild( this.renderer.domElement );

          onWindowResize();
          window.addEventListener( 'resize', onWindowResize, false );

          document.onmousemove = function(e){
            uniforms.u_mouse.value.x = e.pageX
            uniforms.u_mouse.value.y = e.pageY
          }
      }

      const onWindowResize = () =>  {
          this.renderer.setSize(container.getBoundingClientRect().width, container.getBoundingClientRect().height);
          uniforms.u_resolution.value.x = this.renderer.domElement.width;
          uniforms.u_resolution.value.y = this.renderer.domElement.height;
      }

      const animate = () => {
          requestAnimationFrame( animate );
          render();
      }

      const render = () => {
          uniforms.u_time.value += 0.01;
          this.renderer.render( this.scene, this.camera );
      }



      init();
      animate();
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
</style>
