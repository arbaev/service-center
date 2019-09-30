<template lang="pug">
  #app
    Navbar
    h1 {{ message }}
</template>

<script>
  import Navbar from './app/Navbar.vue'

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
