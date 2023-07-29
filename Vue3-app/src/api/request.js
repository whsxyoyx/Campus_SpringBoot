import axios from "axios";
import {useUserStore} from "@/stores/user.js";
const useStore = useUserStore();

export function request(config){
  const instance = axios.create({
    baseURL: 'http://localhost:9999/api/',
    timeout: 5000,
  });
  //配置请求拦截器
  instance.interceptors.request.use(res =>{
    useStore.loading = true
    return res;
  },error=>{
    throw error;
  })
  //配置响应拦截器
  instance.interceptors.response.use(res =>{
    useStore.loading = false
    return res.data
  },error => {
    throw error;
  })
  return instance(config);
}
