<template lang="pug">
  #equipments-list
    h4.text-h4 Equipments list
    q-table#equipments-list-table(
      :data="equipmentsList"
      no-data-label="No equipments yet"
      :columns="columns"
      :loading="!loaded"
      :pagination.sync="pagination"
      row-key="name")

      template(v-slot:body-cell-organization="props")
        q-td(:props="props")
          q-select(
            v-model="selects[props.row.id]"
            :options="organizationsSelect"
            @input="val => { onSelect({item: props.row.id, value: val}) }"
            label="Принадлежит"
            stack-label
            dense=true
            options-dense=true
            filled)

      template(v-slot:no-data="{ icon, message }")
        .full-width.row.flex-center.text-accent.q-gutter-sm
          q-icon(size="2em" name="fas fa-exclamation-triangle")
          span Well this is sad... {{ message }}

</template>

<script>
  import { backend } from '../../api';
  import {
    QSpinnerGears,
    QTable,
    QTd,
    QBtn,
    QIcon,
    QSelect,
  } from 'quasar'

  export default {
    props: {
      equipmentsList: Array,
      organizationsList: Array,
      loaded: Boolean
    },
    data: function () {
      return {
        selects: [],
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
          { name: 'organization', label: 'Организация' }
        ],
        pagination: {
          sortBy: 'name',
          descending: false,
          rowsPerPage: 10
        },
      }
    },
    components: {
      QSpinnerGears,
      QTable,
      QTd,
      QBtn,
      QIcon,
      QSelect,
    },
    methods: {
      onSelect(selected) {
        backend.staff.updateEquipment({
          id: selected.item,
          organization_id: selected.value.value})
          .then(response => {
            console.info(response.data);
          })
          .catch(error => {
            this.errors = error.response.data.errors;
          })
      },
      setOrganizationsSelectModels() {
        this.equipmentsList.forEach(eq => {
          const organization_id = eq.relationships.organization.data && eq.relationships.organization.data.id;
          if(organization_id) {
            this.selects[eq.id] = this.organizationsSelect.find(item => item.value == organization_id);
          }
        });
      },
    },
    computed: {
      organizationsSelect() {
        let org_options =  this.organizationsList.map(org => {
          return {value: org.id, label: org.attributes.name};
        });
        org_options.splice(0,0,{value: 0, label: ''});
        return org_options;
      },
    },
    watch: {
      loaded() {
        this.setOrganizationsSelectModels();
      }
    }
  }
</script>
