<template>
  <div class="main-box">
    <aside>
      <div class="head">
        校园互助后台管理系统
      </div>
      <!--左侧菜单区域-->
      <!--
      :default-active="$route.path"
      router
       <el-menu-item index="/index/welcome">
      开启路由模式:如果$route.path === index name当前菜单项就高亮
      -->
      <el-menu
          active-text-color="#ffd04b"
          background-color="#333"
          class="el-menu-vertical-demo"
          :default-active="$route.path"
          text-color="#fff"
          unique-opened
          router
      >

        <!--首页菜单-->
        <el-menu-item index="/index/welcome">
          <!--标题区域-->
          <el-icon>
            <location/>
          </el-icon>
          <span>首页</span>
        </el-menu-item>

        <!--学院管理菜单-->
        <el-menu-item index="/index/college">
          <el-icon>
            <icon-menu/>
          </el-icon>
          <span>学院管理</span>
        </el-menu-item>

        <!--学生管理菜单-->
        <el-sub-menu index="3">
          <!--标题区域-->
          <template #title>
            <el-icon>
              <UserFilled/>
            </el-icon>
            <span>学生管理</span>
          </template>

          <el-menu-item index="/index/studentInformationManagement">信息管理</el-menu-item>
          <el-menu-item index="/index/studentPermissionModification">权限修改</el-menu-item>

        </el-sub-menu>

        <!--任务管理菜单-->
        <el-sub-menu index="4">
          <!--标题区域-->
          <template #title>
            <el-icon>
              <List/>
            </el-icon>
            <span>任务管理</span>
          </template>

          <el-menu-item index="/index/taskInformationManagement">信息管理</el-menu-item>
          <el-menu-item index="/index/taskTypeManagement">类型管理</el-menu-item>

        </el-sub-menu>

        <!--管理员管理菜单-->
        <el-menu-item index="/index/adminAdministration">
          <el-icon>
            <avatar/>
          </el-icon>
          <span>管理员管理</span>
        </el-menu-item>
      </el-menu>
    </aside>
    <section>
      <header>
        <Top/>
      </header>
      <main>
        <RouterView/>
      </main>
    </section>
  </div>
</template>

<script setup>
import {
  Menu as IconMenu,
  Location,
  UserFilled,
  Avatar,
  List
} from '@element-plus/icons-vue'
// 导入Top组件
import Top from "@/components/Top.vue"
</script>

<style scoped lang="less">
.main-box {
  height: 100%;
  display: flex;

  aside {
    height: 100%;
    width: 230px;
    background-color: #333;

    .el-menu {
      border-right: none;
    }

    .head {
      color: #fff;
      text-align: center;
      line-height: 70px;
      font-size: 14px;
    }
  }

  section {
    background-color: #F3F3F3;
    width: 100%;
    height: 100%;

    header {
      padding: 0 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      height: 7%;
      background-color: #fff;
    }

    main {
      border-radius: 5px;
      margin: 15px;
      background-color: #fff;
      padding: 15px;
      max-height: 85%;
      overflow: auto;
    }
  }
}
</style>
