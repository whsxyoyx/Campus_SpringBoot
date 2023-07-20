import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
/*axios全局配置*/
axios.defaults.baseURL = 'http://localhost:8888/api/'
Vue.prototype.$http = axios

import dayjs from "dayjs";
Vue.prototype.dayjs = dayjs;//可以全局使用dayjs
Vue.use(ElementUI);
Vue.config.productionTip = false;

//配置的全局过滤器
  // 使用：{{需要被过滤的时间戳 | dateFormat}}
  // 格式：2023-01-26 23:20:51
Vue.filter('dateFormat',function (originVal){
  const dt=new Date(originVal);
  const y=dt.getFullYear();
  const m=(dt.getMonth()+1+"").padStart(2,'0');
  const d=(dt.getDate()+"").padStart(2,'0');
  const hh=(dt.getHours()+"").padStart(2,'0');
  const mm=(dt.getMinutes()+"").padStart(2,'0');
  const ss=(dt.getSeconds()+"").padStart(2,'0');
  return y+'-'+m+'-'+d+' '+hh+':'+mm+':'+ss;
})

new Vue({
  router,
  store,
  render: h => h(App)

}).$mount('#app')
