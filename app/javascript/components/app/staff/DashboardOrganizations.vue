<template lang="pug">
  section#dashboard-organizations.q-mx-sm
    .row
      .col-12.col-sm-6.q-pa-sm
        NewOrganizationForm(@reloadOrganizationsList="fetchOrganizationsList")

      .col-12.col-sm-6.q-pa-sm
        OrganizationsList(
          :organizations-list="organizationsList"
          @clickDeleteOrg="deleteOrganization"
          :loading="organizationsListLoading")

</template>

<script>
  import {backend} from '../api';
  import NewOrganizationForm from '../staff/NewOrganizationForm';
  import OrganizationsList from '../staff/OrganizationsList';
  import {
    QSpinnerGears,
    QTable,
  } from 'quasar';

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
        backend.staff.orgTypes()
          .then(response => {
            this.orgTypes = response.data.data;
            this.fetchOrganizationsList();
          })
          .catch(error => console.log(error));
      },
      fetchOrganizationsList() {
        backend.staff.organizations()
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
      deleteOrganization(id) {
        backend.staff.deleteOrganization(id)
          .then(response => {
            const elemIndex = this.organizationsList.findIndex(org => org.id === id);
            this.organizationsList.splice(elemIndex, 1);
            }
          )
          .catch(error => console.log(error));
      }
    }
  }
</script>
