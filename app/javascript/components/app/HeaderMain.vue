<template lang="pug">
  q-header#header-main.bg-blue-9.text-white.q-py-sm(reveal bordered)
    q-toolbar
      q-toolbar-title
        q-avatar.text-white
          svg(width="54" height="54" viewBox="0 0 54 54" xmlns="http://www.w3.org/2000/svg")
            path(fill="white" d="M13.5 22.1c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05zM0 38.3c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05z")
        span.q-px-sm Tim Service Center

      LoginPanel
</template>

<script>
  import LoginPanel from './LoginPanel'

  import {
    QHeader,
    QToolbar,
    QToolbarTitle,
    QAvatar
  } from 'quasar'

  export default {
    data: function() {
      return {}
    },
    components: {
      QHeader,
      QToolbar,
      QToolbarTitle,
      QAvatar,
      LoginPanel
    },
  }
</script>
