<template lang="pug">
  #app
    navbar
    h1 {{ message }}
</template>

<script>
  import Navbar from './app/navbar.vue'
  import {backendGet} from './app/api/index.js'

  export default {
    data: function () {
      return {
        message: "App component"
      }
    },
    components: {
      Navbar
    },
  }
</script>

<style scoped>
  h1 {
    font-size: 2em;
    text-align: center;
  }
</style>
