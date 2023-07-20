<template>
  <el-aside width="200px">
    <el-menu
      default-active="1"
      class="el-menu-vertical-demo"
      router>
      <el-menu-item index="/home">
        <i class="el-icon-location"></i>
        <span slot="title">首页</span>
      </el-menu-item>
      <el-menu-item index="/home/center">
        <i class="el-icon-menu"></i>
        <span slot="title">任务中心</span>
      </el-menu-item>



      <el-submenu index="/task">
        <template slot="title">
          <i class="el-icon-s-order"></i>
          任务管理
        </template>
        <el-menu-item index="/task/addTask">发布任务</el-menu-item>
        <el-menu-item index="/task/publicedTask">已发布任务</el-menu-item>
        <el-menu-item index="/task/acceptedTask">已接受任务</el-menu-item>
      </el-submenu>

      <el-submenu index="/user">
        <template slot="title">
          <i class="el-icon-s-custom"></i>
          个人中心
        </template>
        <el-menu-item @click="toUserInfo()">学生信息管理</el-menu-item>
        <el-menu-item index="/user/userPass">学生密码修改</el-menu-item>
        <el-menu-item index="/user/userDaily">学生日志</el-menu-item>
      </el-submenu>
    </el-menu>


  </el-aside>

</template>
<style>
.el-submenu .el-menu-item{
  text-align:center;
}
/*.el-aside::-webkit-scrollbar {
  display: none;
}*/
</style>

<script>

export default {
  data(){
    return{
      currentUserId:''
    }
  },
  methods:{
        toUserInfo(){
          this.$router.push("/user/userInfo");
        }

  }
}
</script>


