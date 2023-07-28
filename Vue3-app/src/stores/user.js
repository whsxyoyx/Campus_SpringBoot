import { defineStore } from "pinia";
import {ref} from "vue"
export const useUserStore = defineStore("user",function(){
  // 保当前的用户名
  let currentUsername = ref('');
  // 加载效果
  const loading = ref(false);
  // 修改用户名的函数
  const updateUsername = function(newName){
    currentUsername.value = newName;
  }
  return{
    loading,
    currentUsername,
    updateUsername,
  }
},{
  persist:true
})
