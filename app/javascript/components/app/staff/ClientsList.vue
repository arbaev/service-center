<template lang="pug">
  #clients-list
    h4.text-h4 Clients list
    q-table#clients-list-table(
      :data="clientsList"
      no-data-label="No clients yet"
      :columns="columns"
      :loading="loading"
      :pagination.sync="pagination"
      row-key="name")

      template(v-slot:body-cell-actions="props")
        q-td(:props="props")
          q-btn.action-delete(
            @click="onDeleteClient(props.row.id)"
            color="primary"
            icon="far fa-trash-alt"
            size="sm"
            round
            flat)

      template(v-slot:no-data="{ icon, message }")
        .full-width.row.flex-center.text-accent.q-gutter-sm
          q-icon(size="2em" name="fas fa-exclamation-triangle")
          span Well this is sad... {{ message }}

</template>

<script>
  import {
    QSpinnerGears,
    QTable,
    QTd,
    QBtn,
    QIcon,
  } from 'quasar'

  export default {
    props: ['clientsList', 'loading'],
    data: function () {
      return {
        columns: [
          {
            name: 'fullname',
            required: true,
            label: 'Full name',
            align: 'left',
            field: row => row.attributes.fullname,
            format: val => `${val}`,
            sortable: true
          },
          { name: 'id', align: 'center', label: '#id', field: 'id', sortable: true },
          { name: 'phone', label: 'Phone', field: row => row.attributes.phone },
          { name: 'email', label: 'Email', field: row => row.attributes.email },
          { name: 'actions', label: 'Действия' }
        ],
        pagination: {
          sortBy: 'name',
          descending: false,
          rowsPerPage: 8
        },
      }
    },
    components: {
      QSpinnerGears,
      QTable,
      QTd,
      QBtn,
      QIcon,
    },
    methods: {
      onDeleteClient(id) {
        this.$emit('clickDeleteClient', id)
      }
    }
  }
</script>
