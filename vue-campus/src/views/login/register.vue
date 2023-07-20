<template>

  <el-form
    :model="ruleForm"
    :rules="rules"
    ref="ruleForm"
    class="demo-ruleForm"
    label-position="labelPosition" label-width="90px"
  >

    <el-form-item label="学号" prop="studentid">
      <el-input type="text" placeholder="请输入学号"  v-model="ruleForm.studentid" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="姓名" prop="name">
      <el-input type="text" placeholder="请输入姓名"  v-model="ruleForm.name" autocomplete="off"></el-input>
    </el-form-item>

    <el-form-item label="性别" prop="sex">
      <el-select v-model="ruleForm.sex" placeholder="请输入性别" style="width:100%">
        <el-option label="男" value="0" ></el-option>
        <el-option label="女" value="1"></el-option>
      </el-select>
    </el-form-item>

    <el-form-item label="密码" prop="pass">
      <el-input type="password" v-model="ruleForm.pass" placeholder="请输入密码" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="确认密码" prop="checkPass">
      <el-input type="password" v-model="ruleForm.checkPass" placeholder="确认密码" autocomplete="off"></el-input>
    </el-form-item>

    <el-form-item label="学校" prop="school">
      <el-select v-model="schools.schoolid" placeholder="请选择学校"  style="width:100%">
        <el-option v-for="(item,index) in schools" :key="index" :label="item.name" :value="item.schoolid"></el-option>
      </el-select>
    </el-form-item>

    <el-row style="text-align: center;margin-top: -10px;">
      <el-button type="primary" style="margin-top: 10px" @click="doRegister('ruleForm')">注册</el-button>
      <el-button @click="resetRegForm('ruleForm')">重置</el-button>
    </el-row>
    </el-form>

</template>

<script>
import axios from "axios";
export default {
  name: "register",
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
      if (value =='') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.ruleForm.pass) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    var validUsername = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入用户名"));
      } else if (!this.isvalidUsername(value)) {
        callback(
          new Error(
            "请输入正确格式的姓名"
          )
        );
      }else {
        callback();
      }
    };

    var validUserId = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入用户名"));
      } else if (!this.isvalidUserId(value)) {
        callback(
          new Error(
            "学号可以是10-13位数字"
          )
        );
      }else {
        callback();
      }
    };
    var validateSchool = (rule, value, callback) => {
      if (this.schools.schoolid ===undefined) {
        callback(new Error('请选择学院'));
      }else {
        callback();
      }
    };
    return{
      schools:{
        name:"",
        schoolid:"",
      },
      status:'first',
      ruleForm:{
          name: "",
          studentid: "",
          pass: "",
          checkPass: "",
          schoolid: "",
          sex: "男",
      },
      rules: {
        studentid: [
         /* {required: true, message: '请输入学号', trigger: 'change'},
          {min: 10, max: 13, message: '长度在 10 到 13 个字符', trigger: 'blur'}*/
          { required: true, validator: validUserId, trigger: "blur" }
        ],
       name: [
         /* {required: true, message: '请输入姓名', trigger: 'change'},
          {min:2, max: 5, message: '姓名长度在 2 到 5 个字符', trigger: 'blur'},*/
          { required: true, validator: validUsername, trigger: "blur" }
        ],
         sex: [
          {required: true},
        ],
        school: [
          { validator: validateSchool, trigger: 'blur',required: true }
        ],
        pass: [
          /*{required: true, message: '密码不能为空'},*/
          { validator: validatePass, trigger: 'blur' ,required: true },
          { min: 6, max: 16, message: '密码长度在 6 到 16 个字符', trigger: 'blur' }
        ],
        checkPass: [
         /*{required: true, message: '确认密码不能为空'},*/
          { validator: validatePass2, trigger: 'blur' ,required: true }
        ],
      }
    }
  },
  mounted(){
    this.getAllSchool();
  },
 props:{
   activeToLogin:{
     type:String,
     required:true,
   }
 },


  methods:{
    //验证学生姓名
    isvalidUsername(str) {
      //const reg = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
      const reg = /^[a-zA-Z\u4E00-\u9FA5\uf900-\ufa2d·s]{2,20}$/;

      return reg.test(str);
    },
    //验证学号
    isvalidUserId(str) {
      const reg = /^[1-9][0-9]{9,12}$/;
      return reg.test(str);
    },
    //改变父组件的activeName属性 从而实现切换到登录页面
    toLogin(){
      this.$emit('update:activeToLogin','first');
    },
    //注册
    doRegister(formName) {
      //alert('submit!');
      this.$refs.ruleForm.validate((valid) => {
        // alert(valid)
        if (valid) {
          if (this.ruleForm.sex=="男"|this.ruleForm.sex==0){
            this.ruleForm.sex=0;
          }else if (this.ruleForm.sex=="女"|this.ruleForm.sex==1){
            this.ruleForm.sex=1;
          }
          let params={sex:this.ruleForm.sex,studentid:this.ruleForm.studentid,password:this.ruleForm.pass,name:this.ruleForm.name,schoolid:this.schools.schoolid};
          console.log(params)
          this.$http.post("user/register",params).then((resp)=>{

            if (resp.data.code !=100 ){
                if (this.ruleForm.sex=="0"){
                  this.ruleForm.sex="男";
                }else if (this.ruleForm.sex=='1'){
                  this.ruleForm.sex="女";
                }
                this.$message({
                type: 'error',
                showClose: true,
                message: resp.data.msg
              });

            }else{
              //注册成功，性别默认为男
              this.ruleForm.sex="男";
              this.resetRegForm("ruleForm")
              this.toLogin();
              this.$message({
                type: 'success',
                showClose: true,
                message: resp.data.extend.msg
              });

              //_this.activeName="first";
            }
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },

    //注册前查询所有学校
    getAllSchool(){
      let _this=this;
      this.$http.get("admin/getAllSchool").then((resp)=>{
        _this.schools=resp.data.extend.schoolList;
        console.log(_this.schools);

      })
    },
  //重置表单
    resetRegForm() {
        this.$nextTick(()=>{
          this.$refs.ruleForm.resetFields();
        })
    }
  }
}
</script>

<style scoped>

</style>
