// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import axios from 'axios'
import VueAxios from 'vue-axios'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
// Import Bootstrap an BootstrapVue CSS files (order is important)
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.config.productionTip = false
Vue.use(VueAxios, axios)
Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

window.axios = require('axios')

/**
 * vue エラーhandling 全てここに集約して返する。
 *  ・storeではasync/awaitでPromiseをかけて、resolve, rejectを返却するように実装する。
 *  async function(){
 *     await new Promise((resolve, reject) => {
 *       axios.get(url, { headers })
 *            .then(res => {
 *               resolve(response);
 *               commit('functionName',response.data)
 *            })
 *            .catch(error => {
 *               reject(error);
 *            })
 *            .finally(() => {
 *               commit('functionName','text')
 *            })
 *     })
 *   }
 * @param {*} err
 * @param {*} vm
 * @param {*} info
 */
Vue.config.errorHandler = function (err, vm, info) {
  console.info(`Captured in Vue.config.errorHandler: ${info}`, err)
}
window.addEventListener('error', event => {
  console.info('Captured in error EventListener', event.error)
})

window.addEventListener('unhandledrejection', event => {
  console.info('Captured in unhandledrejection EventListener', event.reason)
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
