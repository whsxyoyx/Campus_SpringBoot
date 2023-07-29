import Vue from 'vue';
import App from './App.vue'
import router from './router'
import axios from 'axios'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

Vue.config.productionTip = false

/*axios全局配置*/
axios.defaults.baseURL = 'http://localhost:9999/api/'
Vue.prototype.$http = axios

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
  return `${y}-${m}-${d} ${hh}:${mm}:${ss}`;
  /* return y+'-'+m+'-'+d+' '+hh+':'+mm+':'+ss;*/
})

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
