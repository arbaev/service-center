<template lang="pug">
  section#new-client-form
    h4.text-h4 Add new client
    q-form(@submit="addClient")
      #form-errors(v-show="notEmpty(errors)")
        div(v-for="(error, key) in errors")
          q-banner.q-my-sm.bg-red-6.text-white(rounded) {{ key }} {{ error.join(', ') }}

      q-input.q-mb-sm(
        v-model.lazy="client.fullname"
        label="Your full name"
        filled
        bottom-slots
        :error="client.fullname.length && !isFullnameValid"
        error-message="Five letters minimum, no digits allowed")

      q-input.q-mb-sm(
        v-model.lazy="client.phone"
        @blur="validateClient"
        label="Your phone number"
        filled
        bottom-slots
        :error="client.phone.length && !isPhoneValid"
        error-message="Please use 10 digits"
        type="tel")

      q-input.q-mb-sm(
        v-model.lazy.trim="client.email"
        @blur="validateClient"
        label="Your email"
        filled
        bottom-slots
        :error="client.email.length && !isEmailValid"
        error-message="Enter correct email"
        type="email")

      q-input.q-mb-sm(
        v-model="client.password"
        label="Enter password"
        filled
        :type="isPwd ? 'password' : 'text'")
        template(v-slot:append)
          q-icon.cursor-pointer(
            :name="isPwd ? 'fas fa-eye-slash' : 'fas fa-eye'"
            @click="isPwd = !isPwd")

      q-btn.q-mb-sm.float-right(
        label="Create new client"
        type="submit"
        :disable="disabled"
        no-caps
        color="primary")
</template>

<script>
  import {backendPost} from '../api/index.js'
  import {empty} from '../../mixins/is_empty'
  import {
    QForm,
    QInput,
    QIcon,
    QBtn,
    QBanner
  } from 'quasar'

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
        isPwd: true
      }
    },
    components: {
      QForm,
      QInput,
      QIcon,
      QBtn,
      QBanner
    },
    methods: {
      addClient() {
        backendPost('/staff/client', this.client)
          .then(response => {
            this.$emit('reloadClientsList');
            this.client = {};
            this.errors = {};
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
      validateClient() {
        this.errors = {};

        backendPost('/staff/client/validation', this.client)
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            this.isAlreadyTaken(error.response.data.errors, ['email', 'phone'])
          })
      },
      isAlreadyTaken(errors, properties) {
        properties.forEach(property => {
          let errMessages = errors[property];
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
          let regexPhone = /^[0-9]{10}$/;
          return regexPhone.test(this.client.phone.replace(/\D/g, ''));
      },
      isEmailValid() {
        let regexEmail = /^.+@.+\..+/i;
        return regexEmail.test(this.client.email);
      },
    }
  }
</script>
