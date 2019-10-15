import Vue from 'vue'
import '../assets/quasar.conf'
import Client from '../components/Client'
import router from '../router'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Client),
        router
    }).$mount();
    document.body.appendChild(app.$el);
});
