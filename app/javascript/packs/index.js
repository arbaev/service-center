import Vue from 'vue'
import '../assets/quasar.conf'
import Index from '../components/Index'
import router from '../router'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Index),
        router
    }).$mount();
    document.body.appendChild(app.$el);
});
