<template lang="pug">
  #dashboard
    new-client-form(@reloadClientsList="fetchClientsList")

    hr.my-5
    #clients-list(v-show="clientsList.length")
      h2.text-xl.font-bold Clients list
      ul(class="list-disc list-inside")
        li(v-for="client in clientsList" :key="client.id" :client="client") {{ client.id }}: {{ client.attributes.email }}
</template>

<script>
  import NewClientForm from './new_client_form'
  import {backendGet} from '../api/index.js'

  export default {
    name: "dashboard",
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
