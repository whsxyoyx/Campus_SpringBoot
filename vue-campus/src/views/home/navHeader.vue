<template>
  <div class="navHeader">
    <el-row>
      <el-col :span="4">
        <span class="hidden-sm-and-down">校园互助平台</span>
      </el-col>
      <el-col :span="4" :offset="15">
        <el-link v-if="user.studentid===undefined " @click="login()">登录</el-link>
        <el-popover
          v-else
          placement="top-start"
          title="个人中心"
          width="200"
          trigger="hover"
        >
          <!--头部头像-->
          <!--          <el-avatar v-if="user.photo==null" :size="45" fit="fill" :src="circleUrl" slot="reference"></el-avatar>
                    <el-avatar v-else :size="45" fit="fill" :src="require('@/assets/imgs/'+user.photo)" slot="reference"></el-avatar>-->
          <el-avatar  :size="45" fit="fill" :src="user.photo" slot="reference"></el-avatar>
          <div class="grid-content bg-purple">
            <div class="block">
              <el-row>
                <el-col :span="4" :offset="10">
                  <!--                    <el-avatar v-if="user.photo==null" :size="45" :fit="fit" :src="circleUrl"></el-avatar>
                                      <el-avatar v-else :size="45" :fit="fit" :src="require('@/assets/imgs/'+user.photo)"></el-avatar>-->
                  <el-avatar v-if="user.photo" :size="45" :fit="fit" :src="user.photo"></el-avatar>
                </el-col>
              </el-row>
            </div>
            <div>
              <span>学号：{{user.studentid}} </span>
            </div>
            <div>
              <span>姓名：{{user.name}} </span>
            </div>
            <div >
              <span>性别:&nbsp; <span v-if="user.sex==0"> 男</span><span v-else> 女</span></span>
            </div>
            <div>
              <span>学校：{{user.schoolName}} </span>
            </div>
            <div>
              <span>余额：{{user.money}} <span style="color: #42b983">花花币</span> </span>
            </div>
            <div>
                <span>状态:&nbsp;
                  <el-tag size="medium" type="success" v-if="user.state==0">良好</el-tag>
                  <el-tag size="medium" type="danger" v-else>被限制</el-tag>
                </span>
            </div>
            <el-divider></el-divider>
            <div style="text-align: center">
               <span >
                   注册时间:{{user.registertime | dateFormat }}
              </span>
              <el-link @click="logout()"   type="primary">退出登录</el-link>
            </div>
          </div>
        </el-popover>
      </el-col>
    </el-row>

  </div>

</template>

<script>
import 'element-ui/lib/theme-chalk/display.css';
import axios from "axios";
export default {
  name: "navHeader",
  data(){
    return{
      fit:"scale-down",
      circleUrl: "http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg",
      formInline: {
        schoolId: '',
        taskType: ''
      },

      user:{
        stuid:"",
        studentid:"",
        password:"",
        schoolid:"",
        sex:"",
        name:"",
        registertime:"",
        money:"",
        state:"",
        photo:"",
        schoolName:"",
      },
    }
  },
  mounted() {
    this.getCurrentUser();
    this.getCurrentUserInfo();
  },
//watch监听
  //没登陆时，路由变化就跳转登录页面
  /* watch:{
     $route(to,from){//to:将要进入的路由对象 from：
       if (this.user.studentid==null){
         this.$router.push("/login");
         this.$message.error("请先登录");
       }
     }
   },*/
  methods:{

    //获取当前用户学号
    getCurrentUser(){
      this.user.studentid = window.sessionStorage.getItem('currentUserId');
    },
    getCurrentUserInfo(){
      if (this.user.studentid!=''){
        this.$http.get("user/getCurrentUser?studentid="+this.user.studentid).then((resp)=>{
          if (resp.data.code!=100){
            console.log(resp.data.msg)
          }else{
            this.user = resp.data.extend.user;
            this.user.schoolName = resp.data.extend.schoolName;
          }
        })
      }else{
        this.$message.error("出错啦!!!")
      }

    },
    logout(){
      sessionStorage.removeItem("currentUserId");
      this.$router.push("/login")
    },
    login(){
      this.$router.push("/login");
    },



















    handleCommand(command) {
      this.$message('click on item ' + command);
    },


    /*----搜索框提交-----*/
    onSubmit() {
      console.log('submit!');
    },
  }
}
</script>

<style scoped>
.navHeader{
  margin-top: 5px;

}
</style>
