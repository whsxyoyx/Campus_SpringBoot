<template>
      <el-aside width="200px">
        <el-menu
            default-active="2"
            class="el-menu-vertical-demo"
            router>
                  <el-menu-item >
                    <span >校园互助后台管理系统</span>
                  </el-menu-item>
                 <el-menu-item index="/home/index">
                    <i class="el-icon-location"></i>
                    <span slot="title">首页</span>
                </el-menu-item>
                <el-menu-item index="/school">
                    <i class="el-icon-menu"></i>
                    <span slot="title">学院管理</span>
                </el-menu-item>

                <el-submenu index="/user">
                    <template slot="title">
                        <i class="el-icon-s-custom"></i>
                        学生管理
                    </template>
                    <el-menu-item index="/user/userInfo" >学生信息管理</el-menu-item>
                    <el-menu-item index="/user/userRoot">学生权限修改</el-menu-item>
                </el-submenu>

                 <el-submenu index="/task">
                    <template slot="title">
                        <i class="el-icon-s-order"></i>
                        任务管理
                    </template>
                    <el-menu-item index="/task/taskInfo">任务信息管理</el-menu-item>
                    <el-menu-item index="/task/taskType">任务类型管理</el-menu-item>
                </el-submenu>

                  <el-menu-item index="/admin">
                    <i class="el-icon-user-solid"></i>
                    <span slot="title">管理员管理</span>
                </el-menu-item>
        </el-menu>


      </el-aside>

</template>
<style>
  .el-submenu .el-menu-item{
        text-align:center;
  }
</style>

<script>

export default {
    data(){
        return{

             }
    },
    methods:{

    }
}
</script>


