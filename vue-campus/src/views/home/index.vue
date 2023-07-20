<template>
  <div id="module">


    <el-container>

      <!-- 左侧导航 -->
      <el-aside width="200px">
        <!-- ①引入其他页面类容 -->
        <nav-menu/>
      </el-aside>
      <el-container>

        <!-- 头部 -->
        <el-header>
          <navHeader></navHeader>
        </el-header>


        <!-- 主要内容 -->
        <el-main>
          <breadcrumb/>
          <!-- navMenu.vue 中的表单中router属性，点击导航标签时，根据index=“XXX”跳转页面，但我们要告诉程序点击出现在哪一块  <router-view/>所在的位置就是出现的位置-->
          <router-view/>
        </el-main>

      </el-container>
    </el-container>
  </div>
</template>

<script>
import Breadcrumb from './breadcrumb.vue'
//②引入其他页面类容
import navMenu from './navMenu.vue'
import navHeader from "./navHeader.vue";


export default {
  name: 'indexPage',
  //  ③引入其他页面类容
  components: {navHeader, navMenu, Breadcrumb},
/* beforeRouteEnter: (to, from, next) => {
    console.log("准备进入个人信息页");
    let islogin = sessionStorage.getItem("currentUserId")
    if(!islogin){
      next({path:'/login'});
    }
    next();
  },*/

  data() {
    return {

      currentUserId:"",
    }
  },
  created() {

  },
  methods: {
  }
}
</script>


<style scoped>

/*#module .el-header{
  font-family:  Arial, sans-serif;
  font-size: 20px;
  text-align: center;
  padding: 10px 30px 10px 30px;
  position: fixed;
  justify-content: space-between;
  background-color: #42b983;
  width: 100%;
}*/
.el-header {
  background-color: #42b983;
  color: #fff;
  align-items: center;
  font-size: 30px;
  padding-top: 5px;
  position: fixed;
  width: 100%;
  top: 0;
  z-index:100

}
</style>
