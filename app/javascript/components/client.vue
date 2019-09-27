<template lang="pug">
  #app
    navbar
    p {{ message }}
</template>

<script>
import Navbar from './app/navbar.vue'

export default {
    data: function () {
        return {
          message: "Client component"
        }
    },
    components: {
        Navbar
    },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
