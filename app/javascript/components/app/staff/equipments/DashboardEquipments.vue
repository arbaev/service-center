<template lang="pug">
  section#dashboard-equipments.q-mx-xl
    .row
      .col.q-pa-sm
        EquipmentsList(
          :equipments-list="equipmentsList"
          :loading="equipmentsListLoading")

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
      }
    },
    components: {
      EquipmentsList,
      QSpinnerGears,
    },
    created() {
      this.fetchEquipmentsList();
    },
    methods: {
      fetchEquipmentsList() {
        backend.staff.equipments()
          .then(response => { this.equipmentsList = response.data.data; })
          .catch(error => console.log(error))
          .finally(() => this.equipmentsListLoading = false);
      },
    }
  }
</script>
