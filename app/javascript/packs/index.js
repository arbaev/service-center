import Vue from 'vue'
import '../assets/quasar.conf'
import Index from '../components/Index'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Index)
    }).$mount();
    document.body.appendChild(app.$el);
});
