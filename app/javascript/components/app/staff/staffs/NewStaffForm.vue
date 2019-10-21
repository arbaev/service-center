<template lang="pug">
  section#new-staff-form-section
    q-form#new-staff-form(
      @submit="submitStaff"
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
        @input="validateForm"
        label="Staff email"
        type="email"
        :rules="rules.email"
        bottom-slots
        lazy-rules
        filled)

      div(v-if="isNewRecord")
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
      div(v-else)
        q-btn.q-my-md(@click="resetPasswordStaff"
          :staff="staff"
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
    QBanner,
  } from 'quasar';

  export default {
    name: "NewStaffForm",
    props: ['staff'],
    mixins: [empty],
    data: function () {
      return {
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
      QBanner,
    },
    methods: {
      validateForm() {
        this.$refs.newStaffForm.validate().then(success => {
          this.disabled = !success;
        })
      },
      submitStaff() {
        this.isNewRecord ? this.addStaff() : this.updateStaff()
      },
      addStaff() {
        backend.staff.createStaff(this.staff)
          .then(response => {
            this.errors = {};
            this.$refs.newStaffForm.resetValidation();
            bus.$emit('reloadStaffsList');
            bus.$emit('resetStaff');
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
      updateStaff() {
        backend.staff.updateStaff(this.staff)
          .then(response => {
            this.errors = {};
            this.$refs.newStaffForm.resetValidation();
            bus.$emit('reloadStaffsList');
            bus.$emit('resetStaff');
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
      resetPasswordStaff() {
        backend.staff.resetPasswordStaff(this.staff)
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
    },
    computed: {
      isNewRecord() {
        return !this.staff.id;
      },
      btnLabel() {
        return this.isNewRecord ? 'Create new Staff user' : 'Edit Staff user';
      },
      isEmailValid() {
        let regexEmail = /^.+@.+\..+/i;
        return regexEmail.test(this.staff.email);
      },
    }
  }
</script>
