<template>
  <div class="example-links">
      <button v-for="(value, index) in shaderOptions" :key="index" v-on:click="onSelect(index)">Example {{index + 1}}</button>
  </div>
</template>

<script>

export default {
  name: 'ExampleButtonRow',
  props: ["shaderOptions", "callback"],
  methods: {
    onSelect: function(index) {
      this.shaderOptions[index] && this.callback(this.shaderOptions[index]);
    }
  }
}
</script>

<style scoped>
.example-links {
  display: flex;
  width: 100%;
  margin: 0 32px;
}
.example-links button {
  margin: 0 4px 0 0;
  cursor: pointer;

  color: #eb357f;
}
</style>
