<template>
  <div class="bread-crumb">
    <el-row :gutter="40">
      <el-col :span="8">
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item v-for="(item,index) in list" :key="item.path">
            <a v-if="index==0" :href="'#'+item.path+'/index'">{{ item.meta.title }}</a>
            <span v-else> {{ item.meta.title }}</span>
          </el-breadcrumb-item>

        </el-breadcrumb>
      </el-col>
      <el-col :span="8" :offset="8">
        <h4>当前管理员账户：
          <el-tag effect="dark" style="margin-top: 20px">{{ currentAdminAccount }}</el-tag>
          <el-link style="margin-left: 20px" type="primary" @click.native="logout()">退出登录</el-link>
        </h4>
      </el-col>
    </el-row>

  </div>
</template>

<script>
export default {
  data() {
    return {
      list: [],
      currentAdminAccount: "",
    }
  },
  //watch监听
  watch: {
    $route(to, from) {//to:将要进入的路由对象 from：
      //路由改变，重新获取路由数据信息
      this.list = to.matched;
    }
  },
  methods: {
    //退出登录
    logout() {
      sessionStorage.removeItem("currentAdminAccount");
      this.$router.push("/login");
    },

  }, mounted() {
    //获取路由数据信息
    this.list = this.$route.matched;
    this.currentAdminAccount = window.sessionStorage.getItem('currentAdminAccount');
  },
}
</script>