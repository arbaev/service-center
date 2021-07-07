<template lang="pug">
  section#dashboard-clients.q-mx-xl
    .row
      .col.q-pa-sm
        q-btn(@click="formDialog = true" color="primary" label="Add Client")

        ClientsList(
          :clients-list="clientsList"
          @clickEditClient="editClient"
          @clickDeleteClient="deleteClient"
          :loading="clientsListLoading")

    q-dialog(v-model="formDialog" persistent)
      q-card.form-dialog
        q-card-section.row.items-center
          .text-h4(v-if="isNewRecord") Add new client
          .text-h4(v-else) Edit client
          q-space
          q-btn(@click="resetCurrentClient" icon="fas fa-times" flat round)
        q-card-section.q-pa-md
          NewClientForm(:client="client")

</template>

<script>
  import ClientsList from "./ClientsList";
  import NewClientForm from "./NewClientForm";
  import {backend} from "../../api";
  import { bus } from '../../api/bus'
  import {
    QSpinnerGears,
    QDialog,
    QCard,
    QCardSection,
    QCardActions,
    QBtn,
    QSpace,
  } from 'quasar'

  export default {
    data: function () {
      return {
        clientsList: [],
        clientsListLoading: true,
        client: {
          fullname: '',
          phone: '',
          email: '',
          password: ''
        },
        formDialog: false,
      }
    },
    components: {
      ClientsList,
      NewClientForm,
      QSpinnerGears,
      QDialog,
      QCard,
      QCardSection,
      QCardActions,
      QBtn,
      QSpace,
    },
    created() {
      this.fetchClientsList();
    },
    mounted() {
      bus.$on('resetClient', this.resetCurrentClient);
      bus.$on('reloadClientsList', this.fetchClientsList);
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
      },
      editClient(client) {
        this.client = this.dejson(client);
        this.formDialog = true;
      },
      dejson(client) {
        return {
          id: client.id,
          fullname: client.attributes.fullname,
          email: client.attributes.email,
          phone: client.attributes.phone
        }
      },
      resetCurrentClient() {
        this.formDialog = false;
        this.client = {};
      },
    },
    computed: {
      isNewRecord() {
        return !this.client.id;
      },
    }
  }
</script>
