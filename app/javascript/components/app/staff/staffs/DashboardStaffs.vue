<template lang="pug">
  section#dashboard-staffs.q-mx-xl
    .row
      .col-12.col-sm-6.q-pa-sm
        NewStaffForm(@reloadStaffsList="fetchStaffsList")

      .col-12.col-sm-6.q-pa-sm
        StaffsList(
          :staffs-list="staffsList"
          :loading="staffsListLoading")

</template>

<script>
  import StaffsList from "./StaffsList";
  import NewStaffForm from "./NewStaffForm";
  import {backend} from "../../api";
  import {
    QSpinnerGears,
  } from 'quasar'

  export default {
    data: function () {
      return {
        staffsList: [],
        staffsListLoading: true
      }
    },
    components: {
      StaffsList,
      NewStaffForm,
      QSpinnerGears,
    },
    created() {
      this.fetchStaffsList();
    },
    methods: {
      fetchStaffsList() {
        backend.staff.staffs()
          .then(response => this.staffsList = response.data.data)
          .catch(error => console.log(error))
          .finally(() => this.staffsListLoading = false);
      },
    }
  }
</script>
