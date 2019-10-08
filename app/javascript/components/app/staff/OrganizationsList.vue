<template lang="pug">
  #organizations-list
    h4.text-h4 Organizations list
    q-table(
      :data="organizationsList"
      no-data-label="No organizations yet"
      :columns="columns"
      row-key="name")
</template>

<script>
  import {
    QSpinnerGears,
    QTable,
  } from 'quasar'

  export default {
    props: ['organizationsList'],
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
      }
    },
    components: {
      QSpinnerGears,
      QTable,
    },
  }
</script>
