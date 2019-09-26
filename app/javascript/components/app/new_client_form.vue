<template lang="pug">
  #new-client-form
    span Add new client
    form(class="w-full max-w-sm")
      #form-errors
      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name") fullname
        div(class="md:w-2/3")
          input(v-model.lazy="client.fullname" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-full-name" type="text" placeholder="full name (min 5 chrs)")
          .error(v-show='client.fullname && !isFullnameValid')
            span.text-red-600 Five letters minimum

      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name") phone
        div(class="md:w-2/3")
          input(v-model.lazy="client.phone" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-phone" type="text" placeholder="phone (digits only)")
          .error(v-show='client.phone && !isPhoneValid')
            span.text-red-600 Enter 10 digits

      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name") email
        div(class="md:w-2/3")
          input(v-model.lazy="client.email" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-email" type="text" placeholder="client's email")
          .error(v-show='client.email && !isEmailValid')
            span.text-red-600 Enter correct email

      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name") password
        div(class="md:w-2/3")
          input(v-model="client.password" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-password" type="text" placeholder="create new password")

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
                backendPost('/staff/client', vm.client)
                    .then(function (response) {
                        vm.$emit('reloadClientsList');
                        vm.clearInputs();
                    })
                    .catch(function (error) {
                        vm.showErrors(error.response.data.errors);
                    })
                    .finally(function () {
                    });
            },
            clearInputs() {
                this.client.fullname = '';
                this.client.phone = '';
                this.client.email = '';
                this.client.password = '';
            },
            showErrors(errors) {
                let formErrors = document.getElementById("form-errors");
                Object.keys(errors).forEach(function (key){
                    formErrors.insertAdjacentHTML('beforeend', '<p class="alert alert-alert">' + key + ' ' + errors[key] +'</p>');
                });
            }
        },
        computed: {
            isFullnameValid() {
                let regexFullname = /^[A-zА-яЁё]{5,}$/;
                return regexFullname.test(this.client.fullname);
            },
            isPhoneValid() {
                let regexPhone = /^\d{10}$/;
                return regexPhone.test(this.client.phone);
            },
            isEmailValid() {
                let regexEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return regexEmail.test(this.client.email);
            },
        }
    }
</script>

<style scoped>

</style>
