<template lang="pug">
  section#new-staff-form-section
    h4.text-h4 Add new Staff user
    q-form#new-staff-form(
      @submit="addStaff"
      ref="newStaffForm"
      no-error-focus
      autocorrect="off"
      autocapitalize="off"
      autocomplete="off"
      spellcheck="false")

      #staff-form-errors(v-show="notEmpty(errors)")
        div(v-for="(error, key) in errors")
          q-banner.q-my-sm.bg-red-6.text-white(rounded) {{ key }} {{ error.join(', ') }}

      q-input.q-mb-sm(
        v-model.trim="staff.email"
        label="Staff email"
        type="email"
        :rules="rules.email"
        bottom-slots
        lazy-rules
        filled)

      q-input.q-mb-sm(
        v-model="staff.password"
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

      q-input.q-mb-sm(
        v-model="staff.password_confirmation"
        label="Repeat password"
        @input="validateForm"
        :type="isPwd ? 'password' : 'text'"
        :rules="rules.password"
        lazy-rules
        filled)
        template(v-slot:append)
          q-icon.cursor-pointer(
            :name="isPwd ? 'fas fa-eye-slash' : 'fas fa-eye'"
            @click="isPwd = !isPwd")

      q-btn.q-mb-sm.float-right(
        label="Create new Staff user"
        type="submit"
        :disable="disabled"
        no-caps
        color="primary")
</template>

<script>
  import {backend} from "../api/index";
  import {empty} from '../../mixins/is_empty';
  import {
    QForm,
    QInput,
    QIcon,
    QBtn,
    QBanner
  } from 'quasar';

  export default {
    name: "NewStaffForm",
    mixins: [empty],
    data: function () {
      return {
        staff: {
          email: '',
          password: '',
          password_confirmation: '',
        },
        errors: {},
        disabled: true,
        isPwd: true,
        rules: {
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
      QBanner
    },
    methods: {
      validateForm() {
        this.$refs.newStaffForm.validate().then(success => {
          this.disabled = !success;
        })
      },
      addStaff() {
        backend.staff.createStaff(this.staff)
          .then(response => {
            this.$emit('reloadStaffsList');
            this.staff = {};
            this.errors = {};
            this.$refs.newStaffForm.resetValidation();
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
    },
    computed: {
      isEmailValid() {
        let regexEmail = /^.+@.+\..+/i;
        return regexEmail.test(this.staff.email);
      },
    }
  }
</script>
