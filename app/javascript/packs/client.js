import Vue from 'vue'
import Client from '../components/Client'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Client)
    }).$mount();
    document.body.appendChild(app.$el);

    console.log(app)
});
