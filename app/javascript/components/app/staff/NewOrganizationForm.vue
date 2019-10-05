<template lang="pug">
  section#new-organization-form-section
    h4.text-h4 Add new organization
    q-form#new-organization-form(@submit="addOrganization" ref="newOrganizationForm")
      #organization-form-errors(v-show="notEmpty(errors)")
        div(v-for="(error, key) in errors")
          q-banner.q-my-sm.bg-red-6.text-white(rounded) {{ key }} {{ error.join(', ') }}

      q-select#organization-type-input.q-mb-sm(
        v-model="organization.org_type_id"
        :options="orgTypes"
        option-value="id"
        option-label="name"
        label="Тип организации"
        @blur="validateForm"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
        emit-value
        map-options
        filled)

      q-input.q-mb-sm(
        v-model.lazy="organization.name"
        label="Название организации"
        @blur="validateForm"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
        filled)

      q-input.q-mb-sm(
        v-model.lazy="organization.inn"
        label="ИНН"
        @blur="validateForm"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
        filled)

      q-input.q-mb-sm(
        v-model.trim="organization.ogrn"
        label="ОГРН"
        @input="validateForm"
        :rules="[val => !!val || 'Field is required']"
        filled)

      q-btn.q-mb-sm.float-right(
        label="Create new organization"
        type="submit"
        :disable="disabled"
        no-caps
        color="primary")
</template>

<script>
  import { backendGet, backendPost } from '../api/index.js'
  import {empty} from '../../mixins/is_empty'
  import {
    QForm,
    QInput,
    QSelect,
    QBtn,
    QBanner
  } from 'quasar'

  export default {
    mixins: [empty],
    data: function () {
      return {
        organization: {
          name: '',
          org_type_id: '',
          inn: '',
          ogrn: ''
        },
        orgTypes: [],
        errors: {},
        disabled: true
      }
    },
    components: {
      QForm,
      QInput,
      QSelect,
      QBtn,
      QBanner
    },
    created() {
      this.fetchOrganizationTypes();
    },
    methods: {
      validateForm() {
        this.$refs.newOrganizationForm.validate().then(success => {
          this.disabled = !success;
        })
      },
      fetchOrganizationTypes() {
        backendGet('/staff/org_type')
          .then(response => this.orgTypes = response.data.data)
          .catch(error => console.log(error));
      },
      addOrganization() {
        backendPost('/staff/organization', { organization: this.organization })
          .then(response => {
            this.$emit('reloadOrganizationsList');
            this.organization = {};
            this.errors = {};
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      }
    }
  }
</script>
