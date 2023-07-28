import { createRouter, createWebHistory } from 'vue-router'
import {routes} from "@/router/routes";
import { useUserStore } from "@/stores/user.js";
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})
router.beforeEach(function(to,from,next){
const userStore = useUserStore();
  // 判断是否需要权限验证
  if(to.meta.isValidate){
    // 判断是否有用户名
    if(userStore.currentUsername === ""){
      ElMessage.warning("请先进行登录!")
      next("/login")
    }else{
      next()
    }  
  }else{
    next()
  }
})

export default router
