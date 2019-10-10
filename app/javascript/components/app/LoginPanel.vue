<template lang="pug">
  div
    div(v-if="user")
      span Welcome,
        strong  {{ user.email }}
        |!
      q-btn.q-ml-sm(type="a" :href="user.logout_link" data-method="delete" label="Logout" no-caps outline color="white")
    div(v-else)
      q-btn.q-ml-sm(type="a" href="/staffs/sign_in" label="Staff Login" no-caps outline color="white")
      q-btn.q-ml-sm(type="a" href="/clients/sign_in" label="Client Login" no-caps outline color="white")
</template>

<script>
  import {QBtn} from 'quasar';

  export default {
    props: ["user"],
    data() {
      return {}
    },
    components: {
      QBtn
    },
  }
</script>
