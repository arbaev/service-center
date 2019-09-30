<template lang="pug">
  #dashboard
    NewClientForm(@reloadClientsList="fetchClientsList")

    hr.my-5
    #clients-list(v-show="clientsList.length")
      h2.text-xl.font-bold Clients list
      ul(class="list-disc list-inside")
        li(v-for="client in clientsList" :key="client.id" :client="client") {{ client.id }}: {{ client.attributes.email }}
</template>

<script>
  import NewClientForm from '../staff/NewClientForm'
  import {backendGet} from '../api'

  export default {
    name: "Dashboard",
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
