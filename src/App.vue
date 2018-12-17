<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <HelloWorld01 msg="Welcome to Your Vue.js App"/>
  </div>
</template>

<script>
import HelloWorld01 from './components/01_hello_world/01_hello_world.vue'

export default {
  name: 'app',
  components: {
    HelloWorld01
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
