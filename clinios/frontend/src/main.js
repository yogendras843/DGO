import Vue from 'vue'
import App from './App.vue'
import Http from './plugins/http'
import router from './router'
import store from './store'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import vuetify from './plugins/vuetify';
import CxltToastr from 'cxlt-vue2-toastr'
import FullCalendar from 'vue-full-calendar'
import 'cxlt-vue2-toastr/dist/css/cxlt-vue2-toastr.css'
var toastrConfigs = {
  position: 'bottom right',
  showDuration: 2000,
  timeOut: 3000,
  progressBar: true
}
Vue.use(BootstrapVue);
Vue.use(CxltToastr, toastrConfigs);
Vue.use(FullCalendar)
Vue.config.productionTip = false
Vue.prototype.$http = Http
Vue.prototype.$http.interceptors.request.use(config => {
  const token = store.state.token;
  if (token) {
    config.headers.Authorization = `JWT ${token}`
  }
  return config
}, err => {
  return Promise.reject(err)
});
Vue.prototype.$http.interceptors.response.use(response => {
  return response
}, err => {
  if (err.response.status) {
    localStorage.clear();
    store.state.token = null
    store.state.user = null
    router.push({name: 'index'})
  } else {
    return err
  }
});

router.beforeEach((to, from, next) => {
  if (to.meta.permission) {
    if (to.meta.permission == 1) {
      if (store.state.token != null && store.state.user.permission >= 1) {
        next();
      } else {
        next({ name : 'home' })
      }
    } else if (to.meta.permission == 2) {
      if (store.state.token != null && store.state.user.permission > 1) {
        next();
      } else {
        next({ name: 'home' })
      }
    }
  } else {
    next();
  }
})
new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
