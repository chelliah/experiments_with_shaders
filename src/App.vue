<template>
  <div id="app">
    <!-- <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/01-hello-world">Example 01</router-link>
    </div> -->

    <ul id="nav">
      <li :key="key" v-for="(route, key) in routes" :class="route.className">
        <router-link v-bind="route" :to="route.value">{{ route.label }}</router-link>
      </li>
    </ul>
    <router-view id="view"/>
  </div>
</template>
<script>
  import { routes } from "./router";
  console.log(routes);

  export default {
    name: "App",
    data() {
      return { routes: routes.map((route) => {return { key: route.key, label: route.label, value: route.path, className: route.className}}) }
    }
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

#nav li a {
  color: rgba(30,30,30);
  text-decoration: none;
  padding: 8px 0;
  position: relative;
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
}

</style>
