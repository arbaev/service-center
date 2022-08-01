<template lang="pug">
  section#dashboard-organizations.q-mx-xl
    .row
      .col.q-pa-sm
        q-btn(@click="formDialog = true" color="primary" label="Add organization")

        OrganizationsList(
          :organizations-list="organizationsList"
          @clickDeleteOrg="deleteOrganization"
          :loading="organizationsListLoading")

        q-dialog(v-model="formDialog" persistent)
          q-card.form-dialog
            q-card-section.row.items-center
              .text-h4 Add new organization
              q-space
              q-btn(@click="resetCurrentOrganization" icon="fas fa-times" flat round)
            q-card-section.q-pa-md
              NewOrganizationForm(:organization="organization")

</template>

<script>
  import {backend} from '../../api';
  import { bus } from '../../api/bus';
  import NewOrganizationForm from './NewOrganizationForm';
  import OrganizationsList from './OrganizationsList';
  import {
    QSpinnerGears,
    QDialog,
    QCard,
    QCardSection,
    QCardActions,
    QBtn,
    QSpace,
  } from 'quasar';

  export default {
    data: function () {
      return {
        organizationsList: [],
        organizationsListLoading: true,
        orgTypes: [],
        organization: {},
        formDialog: false,
      }
    },
    components: {
      NewOrganizationForm,
      OrganizationsList,
      QSpinnerGears,
      QDialog,
      QCard,
      QCardSection,
      QCardActions,
      QBtn,
      QSpace,
    },
    created() {
      this.fetchOrganizationTypes();
    },
    mounted() {
      bus.$on('resetOrganization', this.resetCurrentOrganization);
      bus.$on('reloadOrganizationsList', this.fetchOrganizationTypes);
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
      },
      resetCurrentOrganization() {
        this.formDialog = false;
        this.organization = {};
      },
    }
  }
</script>
