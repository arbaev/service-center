<template lang="pug">
  #app
    navbar(:user="user")
    p {{ message }}
    .container.px-4
      dashboard(:clientsList="clientsList" @reloadClientsList="fetchClientsList")
</template>

<script>
    import Navbar from './app/navbar.vue'
    import Dashboard from './app/dashboard.vue'
    import { backendGet } from './app/api/index.js'

    export default {
        data: function () {
            return {
                user: {},
                message: "Staff component",
                clientsList: []
            }
        },
        components: {
            Navbar,
            Dashboard
        },
        created() {
            this.fetchUser();
            this.fetchClientsList();
        },
        methods: {
            fetchUser() {
                let vm = this;
                backendGet('/staff/home/user')
                    .then(function (response) {
                        vm.user = response.data.data.attributes;
                        vm.user.logout_link = response.data.links.logout_link;
                    })
                    .catch(function (error) {
                        console.log(error);
                    })
                    .finally(function () {
                    });
            },
            fetchClientsList() {
                let vm = this;
                backendGet('/client/home')
                    .then(function (response) {
                        vm.clientsList = response.data.data
                    })
                    .catch(function (error) {
                        console.log(error);
                    })
                    .finally(function () {
                    });
            },
        }
    }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
