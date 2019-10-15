import Vue from 'vue';
import VueRouter from "vue-router";

Vue.use(VueRouter);

import DashboardClients from "../components/app/staff/clients/DashboardClients";
import DashboardOrganizations from "../components/app/staff/organizations/DashboardOrganizations";
import DashboardStaffs from "../components/app/staff/staffs/DashboardStaffs";

export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/clients', component: DashboardClients },
    { path: '/organizations', component: DashboardOrganizations },
    { path: '/staffs', component: DashboardStaffs },
  ]
})
