<template lang="pug">
  #new-client-form
    span Add new client
    form(class="w-full max-w-sm")
      #form-errors(v-show="notEmpty(errors)")
        ul(v-for="(error, key) in errors")
          li(class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 m-1 rounded relative" role="alert") {{ key }} {{ error.join(', ') }}
      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name") fullname
        div(class="md:w-2/3")
          input(v-model.lazy="client.fullname" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-full-name" type="text" placeholder="full name (min 5 chrs)")
          .error(v-show='client.fullname && !isFullnameValid')
            span.text-red-600 Five letters minimum, no digits allowed

      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-phone") phone
        div(class="md:w-2/3")
          input(v-model.lazy="client.phone" @blur="validateClient" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-phone" type="text" placeholder="phone (10 digits)")
          .error(v-show='client.phone && !isPhoneValid')
            span.text-red-600 Enter 10 digits

      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-email") email
        div(class="md:w-2/3")
          input(v-model.lazy.trim="client.email" @blur="validateClient" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-email" type="text" placeholder="client's email")
          .error(v-show='client.email && !isEmailValid')
            span.text-red-600 Enter correct email

      div(class="md:flex md:items-center mb-6")
        div(class="md:w-1/3")
          label(class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-password") password
        div(class="md:w-2/3")
          input(v-model="client.password" class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="inline-password" type="text" placeholder="create new password")

      div(class="flex items-center justify-between")
        button(@click="addClient" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button" :disabled='disabled') Create new client
</template>

<script>
  import {backendPost} from '../api/index.js'
  import {empty} from '../../mixins/is_empty.js'

  export default {
    name: "NewClientForm",
    mixins: [empty],
    data: function () {
      return {
        client: {
          fullname: '',
          phone: '',
          email: '',
        },
        errors: {},
        disabled: true,
      }
    },
    methods: {
      addClient() {
        backendPost('/staff/client', this.client)
          .then(response => {
            if (response.data.errors) {
              this.errors = response.data.errors;
            } else {
              this.$emit('reloadClientsList');
              this.client = {};
              this.errors = {};
            }
          })
          .catch(error => console.log(error))
      },
      validateClient() {
        this.errors = {};

        backendPost('/staff/client/validation', this.client)
          .then(response => {
            this.isAlreadyTaken(response, ['email', 'phone'])
          })
          .catch(error => console.log(error))
      },
      isAlreadyTaken(response, properties) {
        properties.forEach(property => {
          let errMessages = response.data.errors[property];
          if (errMessages && errMessages.includes("has already been taken")) {
            this.$set(this.errors, property, '');
            this.errors[property] = errMessages;
          }
        });
      }
    },
    watch: {
      client: {
        handler() {
          this.disabled = !(this.isFullnameValid && this.isPhoneValid && this.isEmailValid);
        },
        deep: true
      }
    },
    computed: {
      isFullnameValid() {
        let regexFullname = /^[A-z А-яЁё]{5,}$/;
        return regexFullname.test(this.client.fullname);
      },
      isPhoneValid() {
        if(this.client.phone) {
          let regexPhone = /^[0-9]{10}$/;
          return regexPhone.test(this.client.phone.replace(/\D/g, ''));
        }
      },
      isEmailValid() {
        let regexEmail = /^.+@.+\..+/i;
        return regexEmail.test(this.client.email);
      },
    }
  }
</script>

<style scoped>
  button:disabled {
    cursor: not-allowed;
    pointer-events: all !important;
    background-color: lightgrey;
  }
</style>
