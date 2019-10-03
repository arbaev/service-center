<template lang="pug">
  section#dashboard-clients.q-mx-xl
    .row
      .col-12.col-sm-6.q-pa-sm
        NewClientForm(@reloadClientsList="fetchClientsList")

      .col-12.col-sm-6.q-pa-sm
        #clients-list(v-show="clientsList.length")
          h4.text-h4 Clients list
          ul
            li(v-for="client in clientsList" :key="client.id" :client="client") {{ client.id }}: {{ client.attributes.email }}
</template>

<script>
  import NewClientForm from '../staff/NewClientForm'
  import {backendGet} from '../api'

  export default {
    data: function () {
      return {
        clientsList: []
      }
    },
    components: {
      NewClientForm
    },
    created() {
      this.fetchClientsList();
    },
    methods: {
      fetchClientsList() {
        backendGet('/staff/client')
          .then(response => this.clientsList = response.data.data)
          .catch(error => console.log(error));
      },
    }
  }
</script>
