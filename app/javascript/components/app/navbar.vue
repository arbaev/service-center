<template lang='pug'>
  nav.flex.items-center.justify-between.flex-wrap.bg-blue-700.p-6
    .flex.items-center.flex-shrink-0.text-white.mr-6
      <svg class="fill-current h-8 w-8 mr-2" width="54" height="54" viewBox="0 0 54 54" xmlns="http://www.w3.org/2000/svg"><path d="M13.5 22.1c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05zM0 38.3c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05z"/></svg>
      .font-semibold.text-xl.tracking-tight Tim Service Center

    div(class="w-full block flex-grow lg:flex lg:items-center lg:w-auto")
      div(class="text-sm lg:flex-grow")

      div
        span(class="block mt-4 lg:inline-block lg:mt-0 text-white mr-4") Welcome,
          strong  {{ user.email }}
          |!
        a(v-bind:href="user.logout_link" data-method="delete" class="inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-blue-700 hover:bg-white mt-4 lg:mt-0") Logout
</template>

<script>
    export default {
        name: "navbar",
        props: ['user']
    }
</script>

<style scoped>
</style>
