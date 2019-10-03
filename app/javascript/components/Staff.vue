<template lang="pug">
  #app
    q-layout(view="hHh lpR fff")
      HeaderMain

      q-page-container
        p {{ message }}
        Dashboard

      FooterMain
</template>

<script>
  import HeaderMain from './app/HeaderMain'
  import FooterMain from './app/FooterMain'
  import Dashboard from './app/staff/Dashboard.vue'
  import {
    QLayout,
    QPageContainer,
    QPage,
    QDrawer,
    QPageSticky,
    QPageScroller,
  } from 'quasar'

  export default {
    data: function () {
      return {
        message: "Staff component",
      }
    },
    components: {
      QLayout,
      QPageContainer,
      QPage,
      QDrawer,
      QPageSticky,
      QPageScroller,
      HeaderMain,
      FooterMain,
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
