<template lang="pug">
  #app
    navbar(:user="user")
    p {{ message }}
</template>

<script>
import Navbar from './app/navbar.vue'
import { backendGet } from './app/api/index.js'

export default {
    data: function () {
        return {
          user: {},
          message: "Client component"
        }
    },
    components: {
        Navbar
    },
    created() {
        this.fetchUser();
    },
    methods: {
        fetchUser() {
            let vm = this;
            backendGet('/client/user')
                .then(function (response) {
                    vm.user = response.data.data.attributes;
                    vm.user.logout_link = response.data.links.logout_link;
                })
                .catch(function (error) {
                    // handle error
                    console.log(error);
                })
                .finally(function () {
                    // always executed
                });
        }
    }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
