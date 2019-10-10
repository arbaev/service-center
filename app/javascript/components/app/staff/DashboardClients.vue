<template lang="pug">
  section#dashboard-clients.q-mx-xl
    .row
      .col-12.col-sm-6.q-pa-sm
        NewClientForm(@reloadClientsList="fetchClientsList")

      .col-12.col-sm-6.q-pa-sm
        #clients-list(v-show="clientsList.length")
          h4.text-h4 Clients list
          q-spinner-gears(v-if="clientsListLoading" color="blue-grey-6" size="3em")
          ul(v-else)
            li(v-for="client in clientsList" :key="client.id" :client="client") {{ client.id }}: {{ client.attributes.email }}
</template>

<script>
  import NewClientForm from '../staff/NewClientForm'
  import {backend} from "../api";
  import {
    QSpinnerGears,
  } from 'quasar'

  export default {
    data: function () {
      return {
        clientsList: [],
        clientsListLoading: true
      }
    },
    components: {
      NewClientForm,
      QSpinnerGears,
    },
    created() {
      this.fetchClientsList();
    },
    methods: {
      fetchClientsList() {
        backend.staff.clients()
          .then(response => this.clientsList = response.data.data)
          .catch(error => console.log(error))
          .finally(() => this.clientsListLoading = false);
      },
    }
  }
</script>
