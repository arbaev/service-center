<template lang="pug">
  section#dashboard-equipments.q-mx-xl
    .row
      .col.q-pa-sm
        EquipmentsList(
          :equipments-list="equipmentsList"
          :organizations-list="organizationsList"
          :loaded="loaded")

</template>

<script>
  import {backend} from '../../api';
  import EquipmentsList from './EquipmentsList';
  import {
    QSpinnerGears,
  } from 'quasar';

  export default {
    data: function () {
      return {
        equipmentsList: [],
        equipmentsListLoading: true,
        organizationsList: [],
        organizationsListLoading: true,
      }
    },
    components: {
      EquipmentsList,
      QSpinnerGears,
    },
    created() {
      this.fetchEquipmentsList();
      this.fetchOrganizationsList();
    },
    methods: {
      fetchEquipmentsList() {
        backend.staff.equipments()
          .then(response => { this.equipmentsList = response.data.data; })
          .catch(error => console.log(error))
          .finally(() => this.equipmentsListLoading = false);
      },
      fetchOrganizationsList() {
        backend.staff.organizations()
          .then(response => { this.organizationsList = response.data.data; })
          .catch(error => console.log(error))
          .finally(() => this.organizationsListLoading = false);
      },
    },
    computed: {
      loaded() {
        return !this.equipmentsListLoading && !this.organizationsListLoading;
      }
    }
  }
</script>
