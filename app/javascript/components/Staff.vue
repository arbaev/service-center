<template lang="pug">
  #app
    Navbar
    p {{ message }}
    .container.px-4
      Dashboard
</template>

<script>
  import Navbar from './app/Navbar.vue'
  import Dashboard from './app/staff/Dashboard.vue'

  export default {
    data: function () {
      return {
        message: "Staff component",
      }
    },
    components: {
      Navbar,
      Dashboard
    },
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
