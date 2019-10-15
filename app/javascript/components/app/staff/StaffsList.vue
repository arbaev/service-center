<template lang="pug">
  #staffs-list
    h4.text-h4 Staffs list
    q-table#staffs-list-table(
      :data="staffsList"
      no-data-label="No Staff users yet"
      :columns="columns"
      :loading="loading"
      :pagination.sync="pagination"
      row-key="email")

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
  } from 'quasar';

  export default {
    props: ['staffsList', 'loading'],
    data: function () {
      return {
        columns: [
          { name: 'id', align: 'center', label: '#id', field: 'id', sortable: true },
          { name: 'email', label: 'Email', field: row => row.attributes.email },
          { name: 'actions', label: 'Действия' }
        ],
        pagination: {
          sortBy: 'email',
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
  }
</script>
