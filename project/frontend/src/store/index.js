import Vue from 'vue'
import Vuex from 'vuex'
import Router from 'vue-router'
import sample from './modules/sample/index'

Vue.use(Vuex)
Vue.use(Router)

const store = new Vuex.Store({
  // strict: true,
  modules: {
    sample
  }
})

export default store
