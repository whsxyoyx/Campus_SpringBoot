<script setup>
// 导入user仓库
import {useUserStore} from "@/stores/user"
// 导入路由函数
import { useRouter } from "vue-router";
const router = useRouter()
import {ref} from "vue"
import { ElMessage } from "element-plus";
const userStore = useUserStore()
let logoutDialogVisible = ref(false)
// 退出登录的函数
const logout = function(){
  // 清空pinia中保存的用户名
  userStore.updateUsername('');
  // 同时跳转到登录页
  router.push('/login');
  // 关闭对话框
  logoutDialogVisible.value = false
  // 弹窗
  ElMessage.info("已退出登录!")
}
</script>
<template>
  <h3>当前用户:{{userStore.currentUsername}}</h3>
  <el-button type="info" plain @click="logoutDialogVisible = true">退出登录</el-button>
  <!-- 退出登录对话框区域 -->
  <el-dialog v-model="logoutDialogVisible" title="警告" width="30%" center>
    <span>
      您确定要退出登录吗?
    </span>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="logoutDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="logout">
          确认
        </el-button>
      </span>
    </template>
  </el-dialog> 
</template>