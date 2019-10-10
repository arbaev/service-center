<template lang="pug">
  q-footer(reveal class="bg-blue-grey-6 text-white")
    q-toolbar
      q-toolbar-title.text-center
        small Training application to learn how to work with Rails + Vue
</template>

<script>
  import {
    QFooter,
    QToolbar,
    QToolbarTitle,
  } from 'quasar'

  export default {
    data: function() {
      return {}
    },
    components: {
      QFooter,
      QToolbar,
      QToolbarTitle,
    },
  }
</script>
