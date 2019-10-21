<template lang="pug">
  section#dashboard-staffs.q-mx-xl
    .row
      .col.q-pa-sm
        q-btn(@click="formDialog = true" color="primary" label="Add Staff")

        StaffsList(
          :staffs-list="staffsList"
          @clickEditStaff="editStaff"
          :loading="staffsListLoading")

    q-dialog(v-model="formDialog" persistent)
      q-card.form-dialog
        q-card-section.row.items-center
          .text-h4(v-if="isNewRecord") Add new Staff user
          .text-h4(v-else) Edit Staff user
          q-space
          q-btn(@click="resetCurrentStaff" icon="fas fa-times" flat round)
        q-card-section.q-pa-md
          NewStaffForm(:staff="staff")
</template>

<script>
  import StaffsList from "./StaffsList";
  import NewStaffForm from "./NewStaffForm";
  import {backend} from "../../api";
  import { bus } from '../../api/bus'
  import {
    QSpinnerGears,
    QDialog,
    QCard,
    QCardSection,
    QCardActions,
    QBtn,
    QSpace,
  } from 'quasar'

  export default {
    data: function () {
      return {
        staffsList: [],
        staffsListLoading: true,
        staff: {
          email: '',
          password: ''
        },
        formDialog: false,
      }
    },
    components: {
      StaffsList,
      NewStaffForm,
      QSpinnerGears,
      QDialog,
      QCard,
      QCardSection,
      QCardActions,
      QBtn,
      QSpace,
    },
    created() {
      this.fetchStaffsList();
    },
    mounted() {
      bus.$on('resetStaff', this.resetCurrentStaff);
      bus.$on('reloadStaffsList', this.fetchStaffsList);
    },
    methods: {
      fetchStaffsList() {
        backend.staff.staffs()
          .then(response => this.staffsList = response.data.data)
          .catch(error => console.log(error))
          .finally(() => this.staffsListLoading = false);
      },
      editStaff(staff) {
        this.staff = this.dejson(staff);
        this.formDialog = true;
      },
      dejson(staff) {
        return {
          id: staff.id,
          email: staff.attributes.email
        }
      },
      resetCurrentStaff() {
        this.formDialog = false;
        this.staff = {};
      },
    },
    computed: {
      isNewRecord() {
        return !this.staff.id;
      },
    }
  }
</script>
