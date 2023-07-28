<script setup>
import {Lock, User} from '@element-plus/icons-vue'
import { reactive, ref,} from 'vue';
import {useRouter} from "vue-router"
const router = useRouter();
import {request} from "@/api/request";

// 导入修改用户名的函数
import { useUserStore } from '@/stores/user';
const userStore = useUserStore();

//登录的信息
const loginInfo = reactive({
  username: '',
  password: ''
})
//登录的验证规则
const loginRules = {
  username: [
    {
      required: true,
      message: '用户名不能为空！',
      trigger: 'blur'
    },
    {
      min: 3,
      max: 5,
      message: '用户名长度在3-5之间',
      trigger: ['blur', 'change']
    },
  ],
  password: [
    {
      required: true,
      message: '密码不能为空！',
      trigger: 'blur'
    },
    {
      min: 4,
      max: 10,
      message: '密码长度在4-10之间',
      trigger: ['blur', 'change']
    },
  ]
}
//绑定form组件实例
const loginFormRef = ref(null)
//登录的函数
const login = function (){
  loginFormRef.value.validate(async valid =>{
    if(!valid) return;
    const res = await request({
      url:'admin/adminlogin',
      method:'get',
      params:{
        account:loginInfo.username,
        password:loginInfo.password
      }
    })
    if(res.code === 100) {
      userStore.updateUsername(loginInfo.username)
      await router.push("/index")
      await ElMessage.success(res.msg)
    }else {
      await ElMessage.error(res.msg)
    }
  })
}
//键盘登录的函数
window.addEventListener('keyup',function (e){
  if(e.key === 'Enter'){
    login();
  }
})

//重置表单的函数
const reset = function (){
  loginFormRef.value.resetFields();
}
</script>
<template>
  <div class="main-box">
    <div class="form-container">
      <el-form :model="loginInfo" :rules="loginRules" ref="loginFormRef">
        <el-form-item>
          <h2>校园互助后台管理系统</h2>
        </el-form-item>
        <el-form-item prop="username">
          <el-input v-model="loginInfo.username" :prefix-icon="User" type="text" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="loginInfo.password" :prefix-icon="Lock" type="password" placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="login">登录</el-button>
          <el-button type="info" plain @click="reset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>
<style scoped lang="less">
.main-box {
  height: 100%;
  display: flex;
  background-image: url("@/assets/imgs/6.jpg");

  .form-container {
    margin: auto;
    display: flex;
    align-items: center;
    width: 500px;
    height: 300px;
    padding: 15px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 10px 2px #7b6d6d;

    .el-form {
      margin: 0 40px;

      h2 {
        margin: auto;
      }

      .el-input {
        height: 40px;
        margin: auto;
      }

      .el-button {
        flex: 1;
        width: 200px;
        height: 40px;
      }
    }
  }
}
</style>
