<template lang="pug">
  section#new-client-form-section
    q-form#new-client-form(
      ref="newClientForm"
      @submit="submitClient"
      no-error-focus
      autocorrect="off"
      autocapitalize="off"
      autocomplete="off"
      spellcheck="false")

      #client-form-errors(v-show="notEmpty(errors)")
        div(v-for="(error, key) in errors")
          q-banner.q-my-sm.bg-red-6.text-white(rounded) {{ key }} {{ error.join(', ') }}

      q-input.q-mb-sm(
        v-model="client.fullname"
        label="Client full name"
        @blur="validateForm"
        :rules="rules.fullname"
        lazy-rules
        filled
        bottom-slots)

      q-input.q-mb-sm(
        v-model="client.phone"
        label="Client phone number"
        @blur="validateClient"
        mask="(###) ### - ####"
        hint="Mask: (###) ### - ####"
        :rules="rules.phone"
        type="tel"
        lazy-rules
        unmasked-value
        filled
        bottom-slots)

      q-input.q-mb-sm(
        v-model.trim="client.email"
        @blur="validateClient"
        label="Client email"
        type="email"
        :rules="rules.email"
        bottom-slots
        lazy-rules
        filled)

      div(v-if="isNewRecord")
        q-input.q-mb-sm(
          v-model="client.password"
          label="Enter password"
          @input="validateForm"
          :type="isPwd ? 'password' : 'text'"
          :rules="rules.password"
          lazy-rules
          filled)
          template(v-slot:append)
            q-icon.cursor-pointer(
              :name="isPwd ? 'fas fa-eye-slash' : 'fas fa-eye'"
              @click="isPwd = !isPwd")
      div(v-else)
        q-btn.q-my-md(@click="resetPasswordClient"
          :client="client"
          label="Send reset password instructions"
          color="negative"
          no-caps)

      q-btn.q-mb-sm.float-right(
        type="submit"
        :disable="disabled"
        color="primary"
        no-caps)
        template(v-slot="label") {{ btnLabel }}
</template>

<script>
  import {backend} from "../../api";
  import {empty} from '../../../mixins/is_empty';
  import { bus } from '../../api/bus'
  import {
    QForm,
    QInput,
    QIcon,
    QBtn,
  } from 'quasar';

  export default {
    name: "NewClientForm",
    props: ['client'],
    mixins: [empty],
    data: function () {
      return {
        errors: {},
        disabled: true,
        isPwd: true,
        rules: {
          fullname: [
            val => !!val || 'Field is required',
            val => this.isFullnameValid || 'Only letters are allowed',
            val => val.length >= 5 || 'Please use mimimum 5 characters',
          ],
          phone: [
            val => !!val || 'Field is required',
            val => val.length === 10 || 'Please use 10 digits'
          ],
          email: [
            val => !!val || 'Field is required',
            val => this.isEmailValid || 'Enter correct email'
          ],
          password: [val => !!val || 'Field is required']
        }
      }
    },
    components: {
      QForm,
      QInput,
      QIcon,
      QBtn,
    },
    methods: {
      validateForm() {
        this.$refs.newClientForm.validate().then(success => {
          this.disabled = !success;
        })
      },
      submitClient() {
        this.isNewRecord ? this.addClient() : this.updateClient()
      },
      addClient() {
        backend.staff.createClient(this.client)
          .then(response => {
            this.errors = {};
            this.$refs.newClientForm.resetValidation();
            bus.$emit('reloadClientsList');
            bus.$emit('resetClient');
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
      updateClient() {
        backend.staff.updateClient(this.client)
          .then(response => {
            this.errors = {};
            this.$refs.newClientForm.resetValidation();
            bus.$emit('reloadClientsList');
            bus.$emit('resetClient');
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
      resetPasswordClient() {
        backend.staff.resetPasswordClient(this.client)
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
      validateClient() {
        this.errors = {};
        if (this.isNewRecord) {
          backend.staff.validateClient(this.client)
            .then(response => {
              this.validateForm();
            })
            .catch(error => {
              this.isAlreadyTaken(error.response.data.errors, ['email', 'phone'])
            })
        }
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
    computed: {
      isNewRecord() {
        return !this.client.id;
      },
      btnLabel() {
        return this.isNewRecord ? 'Create new client' : 'Edit client';
      },
      isFullnameValid() {
        let regexFullname = /^[A-z .А-яЁё]*$/;
        return regexFullname.test(this.client.fullname);
      },
      // it doesn't need if Quasar phone mask used
      // isPhoneValid() {
      //     let regexPhone = /^[0-9]{10}$/;
      //     return regexPhone.test(this.client.phone.replace(/\D/g, ''));
      // },
      isEmailValid() {
        let regexEmail = /^.+@.+\..+/i;
        return regexEmail.test(this.client.email);
      },
    }
  }
</script>
