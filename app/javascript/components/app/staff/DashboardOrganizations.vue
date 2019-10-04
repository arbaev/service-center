<template lang="pug">
  section#dashboard-organizations.q-mx-xl
    .row
      .col-12.col-sm-6.q-pa-sm

      .col-12.col-sm-6.q-pa-sm
        #organizations-list(v-show="organizationsList.length")
          h4.text-h4 Organizations list
          q-spinner-gears(v-if="organizationsListLoading" color="blue-grey-6" size="3em")
          ul(v-else)
            li(v-for="organization in organizationsList" :key="organization.id" :organization="organization") {{ organization.id }}: {{ organization.attributes.name }}
</template>

<script>
  import {backendGet} from '../api'
  import {
    QSpinnerGears,
  } from 'quasar'

  export default {
    data: function () {
      return {
        organizationsList: [],
        organizationsListLoading: true
      }
    },
    components: {
      QSpinnerGears,
    },
    created() {
      this.fetchOrganizationsList();
    },
    methods: {
      fetchOrganizationsList() {
        backendGet('/staff/organization')
          .then(response => this.organizationsList = response.data.data)
          .catch(error => console.log(error))
          .finally(() => this.organizationsListLoading = false);
      },
    }
  }
</script>
