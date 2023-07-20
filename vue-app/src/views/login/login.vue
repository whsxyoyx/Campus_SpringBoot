<template>
  <div class="login">
    <div class="login-center">
        <p class="title-center">校园互助后台管理系统</p>
        <el-form :model="ruleForm" :rules="rules" @submit.native.prevent ref="ruleForm" label-width="70px" class="demo-ruleForm">

            <el-form-item label="用户名" prop="account">
            <el-input v-model="ruleForm.account"></el-input>
            </el-form-item>

            <el-form-item label="密码" prop="password">
            <el-input type="passsword" v-model="ruleForm.password" show-password></el-input>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" class="login-button"  native-type="submit"  @click="submitForm('ruleForm')" :disabled="ruleForm.account==''&&ruleForm.password==''" :loading="loginState">登录</el-button>
                 <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>


        </el-form>
    </div>

  </div>
</template>

<script>

import axios from "axios";

export default {
    data(){
        return{
            loginState:false,
             ruleForm: {
               account: '',
                password: '',
             },
              rules: {
                account: [
                    { required: true, message: '请输入用户名称', trigger: 'change' },
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'change' },
                ]
             }
        }
    },
    methods:{
        submitForm(formName){
          this.$refs[formName].validate((valid) => {
            if (valid) {
              this.loginState=true;
              this.$http.get("admin/adminlogin?account="+this.ruleForm.account+
                  "&password="+encodeURIComponent(this.ruleForm.password)).then((resp)=>{
                this.loginState=false;
                if(resp.data.code==100){
                  window.sessionStorage.setItem('currentAdminAccount',this.ruleForm.account);
                  //push跳转页面
                  this.$router.push("/home/index");
                  this.$message({
                    type: 'success',
                    showClose: true,
                    message: resp.data.msg,
                  });
                }else{
                  this.$message({
                    type: 'error',
                    showClose: true,
                    message: resp.data.msg,
                  });
                }
              })
            }else {
              this.$message({
                message: '用户名或密码格式不正确',
                showClose: true,
                type: 'error'
              });
              console.log('error submit!!');
              return false;
            }
          });
        },
      resetForm(formName){
        this.$refs[formName].resetFields();
      },

    }
}
</script>
