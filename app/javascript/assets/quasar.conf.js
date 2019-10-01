// Quasar framework settings
import Vue from 'vue'

import iconSet from 'quasar/icon-set/fontawesome-v5.js'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'

import './styles/quasar.styl'
import 'quasar/dist/quasar.ie.polyfills'

import { Quasar } from 'quasar'

Vue.use(Quasar, {
  config: {},
  components: {
  },
  directives: {
  },
  iconSet: iconSet,
  plugins: {
  }
});
