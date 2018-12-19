<template>
  <div id="c"/>
</template>

<script>

var THREE = require("three");
// var OrbitControls = require('three-orbit-controls')(THREE)

export default {
  name: 'RendererWithAttributes',
  props: ["vertexShader", "fragmentShader"],
  data() {
    return {
      container: document.getElementById('c'),
      camera: new THREE.Camera(),
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
      var container = document.getElementById( 'c' );
      container.removeChild(container.childNodes[0]);
      this.runShader();
    },
    runShader: function() {
      var container;
      var uniforms;

      const init = () => {
          container = document.getElementById( 'c' );



          this.camera = new THREE.OrthographicCamera( 500 / - 2, 500 / 2, 500 / 2, 500 / - 2, 1, 1000 );
          this.camera.position.z = 1;


          this.scene = new THREE.Scene();
          // this.scene.background = new THREE.Color( 0x101010 );


          //geometry
          var geometry = new THREE.BufferGeometry();
          var positions = new Float32Array([

              1, -1, 0,
              -1, 1 ,0,
              -1, -1, 0,

              -1, 1 ,0,
              1, -1, 0,
              1, 1, 0,
          ]);
          var colors = new Float32Array([
            1.0,  1.0,  1.0,    // white
            0.0,  1.0,  0.0,    // green
            1.0,  0.0,  0.0,    // red

            0.0,  1.0,  0.0,    // green
            1.0,  1.0,  1.0,    // white
            0.0,  0.0,  1.0,    // blue
          ]);


          geometry.addAttribute( 'color', new THREE.BufferAttribute( colors, 3) );
          geometry.addAttribute( 'position', new THREE.BufferAttribute( positions, 3 ) );
          // geometry.setDrawRange({ start: 0, count: 4 });
          geometry.attributes.position.needsUpdate = true;
          // geometry.computeFaceNormals();




          uniforms = {
              u_time: { type: "f", value: 1.0 },
              u_resolution: { type: "v2", value: new THREE.Vector2() },
              u_mouse: { type: "v2", value: new THREE.Vector2() }
          };

          var material = new THREE.ShaderMaterial( {
              uniforms: uniforms,
              vertexShader: this.vertexShader,
              fragmentShader: this.fragmentShader
          } );

          var mesh = new THREE.Mesh( geometry, material );
          this.scene.add( mesh );



          var canvas = document.createElement('canvas');
          var context = canvas.getContext('webgl2');

          this.renderer = new THREE.WebGLRenderer( { canvas: canvas, context: context } );
          this.renderer.setPixelRatio( window.devicePixelRatio );

          container.appendChild( this.renderer.domElement );



          // var controls = new OrbitControls( this.camera, this.renderer.domElement );

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
          uniforms.u_time.value += 0.02;
          this.renderer.render( this.scene, this.camera );
      }



      init();
      animate();
    }

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
  box-shadow: 0 2px 2px rgba(0,0,0,0.3);
  margin: 0 auto;
}
</style>
