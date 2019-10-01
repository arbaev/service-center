import Vue from 'vue'
import '../assets/quasar.conf'
import Staff from '../components/Staff'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Staff)
    }).$mount();
    document.body.appendChild(app.$el);

    console.log(app)
});
