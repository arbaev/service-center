<template lang="pug">
  #app
    q-layout(view="hHh lpR fff")
      HeaderMain

      q-page-container
        p {{ message }}

        q-card
          q-tabs(
            v-model="tab"
            active-color="primary"
            indicator-color="primary"
            align="justify"
            narrow-indicator)

            q-tab#tab-clients(name="clients" label="Clients")
            q-tab#tab-organizations(name="organizations" label="Organizations")

          q-separator

          q-tab-panels(v-model="tab")
            q-tab-panel(name="clients")
              DashboardClients

            q-tab-panel(name="organizations")
              DashboardOrganizations

      FooterMain
</template>

<script>
  import HeaderMain from './app/HeaderMain'
  import FooterMain from './app/FooterMain'
  import DashboardClients from './app/staff/DashboardClients'
  import DashboardOrganizations from './app/staff/DashboardOrganizations'
  import {
    QLayout,
    QPageContainer,
    QPage,
    QDrawer,
    QPageSticky,
    QPageScroller,
    QCard,
    QTabs,
    QTabPanels,
    QTabPanel,
    QTab,
    QSeparator,
  } from 'quasar'

  export default {
    data: function () {
      return {
        message: "Staff component",
        tab: 'organizations',
      }
    },
    components: {
      QLayout,
      QPageContainer,
      QPage,
      QDrawer,
      QPageSticky,
      QPageScroller,
      QCard,
      QTabs,
      QTabPanels,
      QTabPanel,
      QTab,
      QSeparator,
      HeaderMain,
      FooterMain,
      DashboardClients,
      DashboardOrganizations
    },
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
