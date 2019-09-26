import Vue from 'vue'
import Index from '../components/index.vue'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Index)
    }).$mount();
    document.body.appendChild(app.$el);
});
