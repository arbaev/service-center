<template lang="pug">
  section#dashboard-organizations.q-mx-sm
    .row
      .col-12.col-sm-6.q-pa-sm
        NewOrganizationForm(@reloadOrganizationsList="fetchOrganizationsList")

      .col-12.col-sm-6.q-pa-sm
<<<<<<< HEAD
        OrganizationsList(:organizations-list="organizationsList" :loading="organizationsListLoading")
=======
        q-spinner-gears(v-if="organizationsListLoading" color="blue-grey-6" size="3em")
        OrganizationsList(v-else :organizations-list="organizationsList")
>>>>>>> b4f10d8f9d67049cac50c5e512d6ddbc257531aa

</template>

<script>
  import NewOrganizationForm from '../staff/NewOrganizationForm'
  import OrganizationsList from '../staff/OrganizationsList'
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
      }
    },
    components: {
      NewOrganizationForm,
      OrganizationsList,
      QSpinnerGears,
      QTable,
    },
    created() {
      this.fetchOrganizationTypes();
    },
    methods: {
      fetchOrganizationTypes() {
        backendGet('/staff/org_type')
          .then(response => {
            this.orgTypes = response.data.data;
            this.fetchOrganizationsList();
          })
          .catch(error => console.log(error));
      },
      fetchOrganizationsList() {
        backendGet('/staff/organization')
          .then(response => {
            this.organizationsList = response.data.data;
            this.setOrgTypeAttribute();
          }
      )
          .catch(error => console.log(error))
          .finally(() => this.organizationsListLoading = false);
      },
      setOrgTypeAttribute() {
        this.organizationsList.forEach(org => {
          const org_type_obj = org.relationships.org_type.data;
          org.attributes.org_type = this.orgTypes.find(obj => { return obj.id == org_type_obj.id })
        });
      },
    }
  }
</script>
