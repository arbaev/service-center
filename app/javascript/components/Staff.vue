<template lang="pug">
  #app
    q-layout(view="hHh lpR fff")
      HeaderMain(:user="user")

      q-page-container
        p {{ message }}
        router-view

      FooterMain
</template>

<script>
  import {backend} from "./app/api";
  import HeaderMain from './app/HeaderMain';
  import FooterMain from './app/FooterMain';
  import {
    QLayout,
    QPageContainer,
    QPage,
    QDrawer,
    QPageSticky,
    QPageScroller,
  } from 'quasar';

  export default {
    data: function () {
      return {
        message: "Staff component",
        tab: 'organizations',
        user: {},
      }
    },
    components: {
      QLayout,
      QPageContainer,
      QPage,
      QDrawer,
      QPageSticky,
      QPageScroller,
      HeaderMain,
      FooterMain,
    },
    created() {
      this.fetchCurrentUser();
    },
    methods: {
      fetchCurrentUser() {
        backend.staff.user()
          .then(response => {
            const attrs = response.data;
            this.user = attrs.data.attributes;
            this.user.logout_link = attrs.links.logout_link;
          })
          .catch(error =>  {
            console.log(error.response);
          })
      },
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
