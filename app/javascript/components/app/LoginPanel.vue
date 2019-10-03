<template lang="pug">
  div
    div(v-if="notEmpty(user)")
      span Welcome,
        strong  {{ user.email }}
        |!
      q-btn.q-ml-sm(type="a" :href="user.logout_link" data-method="delete" label="Logout" no-caps outline color="white")
    div(v-else)
      q-btn.q-ml-sm(type="a" href="/staffs/sign_in" label="Staff Login" no-caps outline color="white")
      q-btn.q-ml-sm(type="a" href="/clients/sign_in" label="Client Login" no-caps outline color="white")
</template>

<script>
  import {backendGet} from './api/index.js'
  import {empty} from '../mixins/is_empty.js'
  import {QBtn} from 'quasar'

  export default {
    mixins: [empty],
    data: function() {
      return {
        user: {}
      }
    },
    components: {
      QBtn
    },
    created() {
      this.currentUser();
    },
    methods: {
      currentUser() {
        this.fetchUser('/staff/user');
        if (this.isEmpty(this.user)) {
          this.fetchUser('/client/user');
        }
      },
      fetchUser(path) {
        backendGet(path)
          .then(response => {
            let attrs = response.data;
            if ("data" in attrs) {
              this.user = attrs.data.attributes;
              this.user.logout_link = attrs.links.logout_link;
            }
          })
          .catch(error =>  {
            console.log(error);
          })
      }
    }
  }
</script>
