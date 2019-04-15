<template>
  <div id="app">
    <!-- <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/01-hello-world">Example 01</router-link>
    </div> -->

    <ul id="nav" :class="`${hideNavBar  ? 'collapsible' : ''}`">
      <li :key="key" v-for="(route, key) in routes" :class="route.className">
        <router-link v-bind="route" :to="route.value">{{ route.label }}</router-link>
      </li>
    </ul>
    <router-view id="view"/>
  </div>
</template>
<script>
import { routes } from './router'

export default {
  name: 'App',
  data () {
    return { routes: routes.map((route) => { return { key: route.key, label: route.props.label, value: route.path, className: route.className } }) }
  },
  computed: {
    hideNavBar() {
      console.log(this.$route)
      return this.$route && this.$route.meta && this.$route.meta.hideNavBar
    }
  },
}
</script>
<style>
html, body {
  margin: 0;
}
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */

  display: flex;
  height: 100vh;
  width: 100vw;
}

#nav {
  flex-basis: 200px;

  background: rgba(45,45,80,0.05);
  border-right: 1px solid rgba(0,0,0,0.1);
  margin: 0;
  padding: 64px 32px;

  list-style:none;
  align-items: left;
  display: flex;
  flex-direction: column;
  align-items: baseline;

}


#nav.collapsible {
  position: fixed;
  z-index: 100;
  width: 264px;
  box-sizing: border-box;
  height: 100vh;
  left: 0;
  top: 0;
  transition: transform 0.3s ease-out;
  transform: translateX(-264px);
  background: none;
  box-shadow: none;

  background:rgba(255,255,255,0.2);
}

#nav.collapsible:hover{
  transform: translateX(0%);
  background:rgba(255,255,255,0.9);
}

#nav li a {
  color: rgba(30,30,30);
  text-decoration: none;
  padding: 8px 0;
  position: relative;
}

#nav li {

  text-align: left;
}

#nav li:not(.home) .router-link-exact-active {
  color: #eb357f;
}

#nav li:not(.home) .router-link-exact-active::before {
  content: "";
  position: absolute;
  height: 38px;
  /* top: 0; */
  top: 0;
  left: -32px;
  width: 4px;
  background: #eb357f;
}

#nav.collapsible li:not(.home) .router-link-exact-active::before {
  content: "nav";
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  width: 42px;
  transition: transform 0.3s ease-out 0.3s;
  transform: translateX(264px);
}

#nav.collapsible:hover li:not(.home) .router-link-exact-active::before {
  content: "";
  width: 4px;
  transition: transform 0.1s ease-out, width 0.1s;
  transform: translateX(0px);
}

#nav li.home {
  margin-bottom: 32px;
  text-align: left;
}

#nav li.home a {
  font-size: 32px;
}

#view {
  flex-basis: 500px;
  flex-grow: 1;
  flex-shrink: 0;
  height: 100vh;
  overflow: scroll;
  box-sizing: border-box;

  text-align: left;
  padding: 32px 32px 64px;
  padding-bottom: 64px;
}

</style>
