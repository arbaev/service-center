<template lang="pug">
  #organizations-list
    h4.text-h4 Organizations list
    q-table#organizations-list-table(
      :data="organizationsList"
      no-data-label="No organizations yet"
      :columns="columns"
      :loading="loading"
      :pagination.sync="pagination"
      row-key="name")

      template(v-slot:body-cell-actions="props")
        q-td(:props="props")
          q-btn.action-delete(
            @click="onDeleteOrg(props.row.id)"
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
    props: ['organizationsList', 'loading'],
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
      onDeleteOrg(id) {
        this.$emit('clickDeleteOrg', id)
      }
    }
  }
</script>
