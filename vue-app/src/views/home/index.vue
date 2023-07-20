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
           <breadcrumb/>
        </el-header>
<!-- 主要内容 -->
        <el-main>
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

export default {
  //  ③引入其他页面类容
  components: { navMenu, Breadcrumb},


    data(){
        return{

             }
    },
    methods:{

    }
}
</script>


<style scoped>
</style>
