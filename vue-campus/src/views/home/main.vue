<template>
  <div class="index">
    <span style="font-size: 100px;color: #333333;margin-top: 80px">欢迎使用本系统</span>
    <div style="font-size: 20px;color: #333333;margin-top: 80px">
      本系统注册就送50
      <span style="color: #42b983">花花币</span>。
    </div>
    <div style="font-size: 20px;color: #333333;margin-top: 10px">
      <span style="color: #42b983">花花币</span>不够的同学，请联系管理员，管理员电话：027-111111111

    </div>
  </div>
</template>
<style scoped>
.index{
  text-align: center;
}
</style>



<script>



export default {
    data() {
      return {
        currentUserId:"",
      }
    },

  mounted(){
    this.getCurrentUser()
  },
  methods:{
    getCurrentUser(){
      this.currentUserId= window.sessionStorage.getItem('currentUserId');
    },


  }
}
</script>
