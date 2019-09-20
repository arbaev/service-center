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
    import { backendGet } from './app/api/index.js'

    export default {
        data: function () {
            return {
                user: {},
                message: "Staff component",
                client: {
                    email: ""
                },
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
                        // handle error
                        console.log(error);
                    })
                    .finally(function () {
                        // always executed
                    });
            },
            fetchClientsList() {
                let vm = this;
                backendGet('/client/home')
                    .then(function (response) {
                        vm.clientsList = response.data.data
                    })
                    .catch(function (error) {
                        // handle error
                        console.log(error);
                    })
                    .finally(function () {
                        // always executed
                    });
            },
            addClient() {
                this.clientsList.push({email: this.client.email})
                this.client.email = ''
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
