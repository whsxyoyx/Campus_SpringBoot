<template>
<div id="module">
    <el-container>
<!-- 左侧导航 -->
      <el-aside width="200px">
        <!-- ①引入其他页面类容 -->
        <NavMenu/>
      </el-aside>

      <el-container>
<!-- 头部 -->
        <el-header>
           <Breadcrumb/>
        </el-header>
<!-- 主要内容 -->
        <el-main>
          <!-- NavMenu.vue 中的表单中router属性，点击导航标签时，根据index=“XXX”跳转页面，但我们要告诉程序点击出现在哪一块  <router-view/>所在的位置就是出现的位置-->
          <router-view/>
        </el-main>

      </el-container>
    </el-container>
  </div>
</template>

<script>
import Breadcrumb from '@/views/home/Breadcrumb'
 //②引入其他页面类容
import NavMenu from '@/views/home/NavMenu'
export default {
  name:'Index',
  //  ③引入其他页面类容
  components: { NavMenu, Breadcrumb}
}
</script>
