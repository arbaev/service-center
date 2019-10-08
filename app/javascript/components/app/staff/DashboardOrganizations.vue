<template lang="pug">
  section#dashboard-organizations.q-mx-xl
    .row
      .col-12.col-sm-6.q-pa-sm
        NewOrganizationForm(@reloadOrganizationsList="fetchOrganizationsList")

      .col-12.col-sm-6.q-pa-sm
        #organizations-list
          h4.text-h4 Organizations list
          q-spinner-gears(v-if="organizationsListLoading" color="blue-grey-6" size="3em")
          q-table(v-else
            :data="organizationsList"
            no-data-label="No organizations yet"
            :columns="columns"
            row-key="name")
</template>

<script>
  import NewOrganizationForm from '../staff/NewOrganizationForm'
  import {backendGet} from '../api'
  import {
    QSpinnerGears,
    QTable,
  } from 'quasar'

  export default {
    data: function () {
      return {
        organizationsList: [],
        organizationsListLoading: true,
        orgTypes: [],
        columns: [
          {
            name: 'name',
            required: true,
            label: 'Название организации',
            align: 'left',
            field: row => row.attributes.name,
            format: val => `${val}`,
            sortable: true
          },
          { name: 'id', align: 'center', label: '#id', field: 'id', sortable: true },
          {
            name: 'orgType',
            label: 'Тип',
            sortable: true,
            field: row => this.setOrgTypeName(row.relationships.org_type.data.id)
          },
          { name: 'inn', label: 'ИНН', field: row => row.attributes.inn },
          { name: 'ogrn', label: 'ОГРН', field: row => row.attributes.ogrn },
        ],
      }
    },
    components: {
      NewOrganizationForm,
      QSpinnerGears,
      QTable,
    },
    created() {
      this.fetchOrganizationTypes();
      this.fetchOrganizationsList();
    },
    methods: {
      fetchOrganizationTypes() {
        backendGet('/staff/org_type')
          .then(response => this.orgTypes = response.data.data)
          .catch(error => console.log(error));
      },
      fetchOrganizationsList() {
        backendGet('/staff/organization')
          .then(response => this.organizationsList = response.data.data)
          .catch(error => console.log(error))
          .finally(() => this.organizationsListLoading = false);
      },
      setOrgTypeName(org_type_id) {
        const obj_type = this.orgTypes.find(obj => { return obj.id == org_type_id });
        return obj_type.name
      }
    }
  }
</script>
