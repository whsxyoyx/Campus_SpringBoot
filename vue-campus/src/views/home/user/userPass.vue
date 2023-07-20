<template>
<div id="userPass">
  <el-card class="box-card">
    <div  class="text item">
      <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="原密码" prop="oldPass">
          <el-input type="password" v-model="ruleForm.oldPass" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="pass">
          <el-input type="password" v-model="ruleForm.pass" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="checkPass">
          <el-input type="password" v-model="ruleForm.checkPass" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </el-card>


</div>
</template>

<script>
import axios from "axios";

export default {
  name: "userPass",
  data(){
    var validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入密码'));
      } else {
        if (this.ruleForm.checkPass !== '') {
          this.$refs.ruleForm.validateField('checkPass');
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.ruleForm.pass) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {
      ruleForm: {
        pass: '',
        checkPass: '',
        oldPass:''
      },
      user:{
        password:"",
        stuid:"",
        studentid:"",
        schoolid:"",
        sex:"",
        name:"",
        registertime:"",
        money:"",
        state:"",
        photo:"",
      },
      studentid:"",
      rules: {
        oldPass: [
          { validator: validatePass, trigger: 'blur' },
          { min: 6, max: 16, message: '密码长度在 6 到 16 个字符', trigger: 'blur',required:true }
        ],
        pass: [
          { validator: validatePass, trigger: 'blur' },
          { min: 6, max: 16, message: '密码长度在 6 到 16 个字符', trigger: 'blur',required:true }
        ],
        checkPass: [
          { validator: validatePass2, trigger: 'blur',required:true }
        ],
      }
    };
  },
  mounted() {
    this.getCurrentUser();
  },
  methods: {
    getCurrentUser(){
      this.user.studentid= sessionStorage.getItem("currentUserId");
      this.$http.get("user/getCurrentUser?studentid="+this.user.studentid).then((resp)=>{
        if (resp.data.code!=100){
          console.log(resp.data.msg)
        }else{
          this.user = resp.data.extend.user;
        }
      })
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if(this.ruleForm.oldPass!=this.user.password){
            this.$message({
              type: 'error',
              showClose: true,
              message: "原密码错误"
            });
            return;
          }
          this.user.password=this.ruleForm.pass;
          var params={
            stuid:this.user.stuid,
            studentid:this.user.studentid,
            password:this.user.password,
          }
          this.$http.put("user/updatePwd",params).then((resp)=>{
            if (resp.data.code!=100){
              this.$message({
                type: 'error',
                showClose: true,
                message: resp.data.msg
              });
            }else{
              this.$router.push("/login")
              this.$message({
                type: 'success',
                showClose: true,
                message: resp.data.msg
              });
            }
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  }

}
</script>

<style scoped>
.text {
  font-size: 14px;
}

.item {
  padding: 18px 0;
}

.box-card {
  width: 480px;
  text-align: center;
}
</style>
