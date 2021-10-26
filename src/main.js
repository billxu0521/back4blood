import Vue from 'vue'
import App from './App.vue'
import VueMeta from 'vue-meta'
import './plugins/element.js'
import Ads from 'vue-google-adsense'

Vue.use(require('vue-script2'))
Vue.use(Ads.Adsense)
Vue.use(VueMeta)
Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')

