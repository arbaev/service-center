<template lang="pug">
  #app
    navbar(:user="user")
    p {{ message }}
    .container.px-4

      #dashboard
        span Add new client
          form(class="w-full max-w-sm")
            div(class="md:flex md:items-center mb-6")
              div(class="md:w-1/3")
                label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name") email
              div(class="md:w-2/3")
                input(v-model="client.email" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-full-name" type="text" placeholder="enter new client email")

            div(class="md:flex md:items-center mb-6")
              div(class="md:w-1/3")
                label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name") password
              div(class="md:w-2/3")
                input(v-model="client.password" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-full-name" type="text" placeholder="create new password")

            div(class="flex items-center justify-between")
              button(@click="addClient" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button") Create new client

        hr.my-5
        h2.text-xl.font-bold Clients list
        ul(class="list-disc list-inside")
          dashboard(v-for="item in clientsList" :key="item.id" :client="item")
</template>

<script>
    import Navbar from './app/navbar.vue'
    import Dashboard from './app/dashboard.vue'
    import { backendGet, backendPost } from './app/api/index.js'

    export default {
        data: function () {
            return {
                user: {},
                message: "Staff component",
                client: {},
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
            addClient() {
                let vm = this;
                backendPost('/client/home', vm.client)
                    .then(function (response) {
                        vm.fetchClientsList();
                        vm.client.email = '';
                        vm.client.password = '';
                    })
                    .catch(function (error) {
                        console.log(error);
                    })
                    .finally(function () {
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
