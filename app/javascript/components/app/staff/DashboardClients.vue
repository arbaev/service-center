<template lang="pug">
  section#dashboard-clients.q-mx-xl
    .row
      .col-12.col-sm-6.q-pa-sm
        NewClientForm(@reloadClientsList="fetchClientsList")

      .col-12.col-sm-6.q-pa-sm
        ClientsList(
          :clients-list="clientsList"
          @clickDeleteClient="deleteClient"
          :loading="clientsListLoading")

</template>

<script>
  import ClientsList from "./ClientsList";
  import NewClientForm from "./NewClientForm";
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
      ClientsList,
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
      deleteClient(id) {
        backend.staff.deleteClient(id)
          .then(response => {
              const elemIndex = this.clientsList.findIndex(client => client.id === id);
              this.clientsList.splice(elemIndex, 1);
            }
          )
          .catch(error => console.log(error));
      }
    }
  }
</script>
