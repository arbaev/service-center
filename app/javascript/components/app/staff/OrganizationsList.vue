<template lang="pug">
  #organizations-list
    h4.text-h4 Organizations list
    q-table(
      :data="organizationsList"
      no-data-label="No organizations yet"
      :columns="columns"
<<<<<<< HEAD
      :loading="loading"
      :pagination.sync="pagination"
=======
>>>>>>> b4f10d8f9d67049cac50c5e512d6ddbc257531aa
      row-key="name")
</template>

<script>
  import {
    QSpinnerGears,
    QTable,
  } from 'quasar'

  export default {
<<<<<<< HEAD
    props: ['organizationsList', 'loading'],
=======
    props: ['organizationsList'],
>>>>>>> b4f10d8f9d67049cac50c5e512d6ddbc257531aa
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
          { name: 'orgType', label: 'Тип', sortable: true, field: row => row.attributes.org_type.name },
          { name: 'inn', label: 'ИНН', field: row => row.attributes.inn },
          { name: 'ogrn', label: 'ОГРН', field: row => row.attributes.ogrn },
        ],
<<<<<<< HEAD
        pagination: {
          sortBy: 'name',
          descending: false,
          rowsPerPage: 8
        },
=======
>>>>>>> b4f10d8f9d67049cac50c5e512d6ddbc257531aa
      }
    },
    components: {
      QSpinnerGears,
      QTable,
    },
  }
</script>
