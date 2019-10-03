<template lang="pug">
  #app
    q-layout(view="hHh lpR fff")
      HeaderMain

      q-page-container
      h1 {{ message }}

      FooterMain
</template>

<script>
  import HeaderMain from './app/HeaderMain'
  import FooterMain from './app/FooterMain'
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
        message: "App component"
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
      FooterMain
    }
  }
</script>

<style scoped>
  h1 {
    font-size: 2em;
    text-align: center;
  }
</style>
