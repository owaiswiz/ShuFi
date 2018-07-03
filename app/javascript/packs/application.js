/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'application.css'

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource';
import App from '../app.vue'
import ManageDevices from '../src/components/ManageDevices.vue'
import AddDevice from '../src/components/AddDevice.vue'

Vue.use(VueResource);
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',
    data: {
      devices: [
        {
          id: 23,
          name: 'Lava',
          editing: true,
          mac: 'B8:5A:2F:23:8C:EA',
          loading: false,
        },
        {
          id: 4,
          name: 'Samsung',
          editing: false,
          loading: false
        }
      ]
    },
    
    components: {
      App,
      ManageDevices,
      AddDevice
    }
  })
})
