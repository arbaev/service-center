<template lang="pug">
  #equipments-list
    h4.text-h4 Equipments list
    q-table#equipments-list-table(
      :data="equipmentsList"
      no-data-label="No equipments yet"
      :columns="columns"
      :loading="loading"
      :pagination.sync="pagination"
      row-key="name")

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
    props: ['equipmentsList', 'loading'],
    data: function () {
      return {
        columns: [
          {
            name: 'name',
            required: true,
            label: 'Название',
            align: 'left',
            field: row => row.attributes.name,
            format: val => `${val}`,
            sortable: true
          },
          { name: 'id', align: 'center', label: '#id', field: 'id', sortable: true },
          { name: 'kind', label: 'Тип', sortable: true, field: row => row.attributes.kind },
          { name: 'actions', label: 'Действия' }
        ],
        pagination: {
          sortBy: 'name',
          descending: false,
          rowsPerPage: 20
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
  }
</script>
