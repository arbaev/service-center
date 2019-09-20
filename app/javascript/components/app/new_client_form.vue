<template lang="pug">
  #new-client-form
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
</template>

<script>
    import { backendPost } from './api/index.js'

    export default {
        name: "new_client_form",
        data: function () {
            return {
                client: {},
            }
        },
        methods: {
            addClient() {
                let vm = this;
                backendPost('/client/home', vm.client)
                    .then(function (response) {
                        vm.$emit('reloadClientsList');
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

</style>
