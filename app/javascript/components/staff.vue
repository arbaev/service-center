<template lang="pug">
  #app
    navbar
    p {{ message }}
    .container.px-4
      dashboard
</template>

<script>
    import Navbar from './app/navbar.vue'
    import Dashboard from './app/staff/dashboard.vue'

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
