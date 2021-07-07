import Vue from 'vue'
import '../assets/quasar.conf'
import Staff from '../components/Staff'
import router from '../router'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Staff),
        router
    }).$mount();
    document.body.appendChild(app.$el);
});
