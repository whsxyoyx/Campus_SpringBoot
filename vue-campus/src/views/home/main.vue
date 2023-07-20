<template>
  <div class="index">
<!--    <el-carousel :interval="4000" type="card" >
      <el-carousel-item v-for="item in imgLists" :key="item">
        <img :src="item" alt="" class="image">
      </el-carousel-item>
    </el-carousel>-->
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
        /* imgLists:[
         // 使用require动态引入图片
         require("@/assets/imgs/0.jpg"),
         require("@/assets/imgs/1.jpg"),
         require("@/assets/imgs/2.jpg"),
         require("@/assets/imgs/3.jpg"),
         require("@/assets/imgs/4.png"),
         require("@/assets/imgs/5.jpg"),
         require("@/assets/imgs/6.jpg"),
       ],*/
        currentUserId:"",
      }
    },

  mounted(){
    this.getCurrentUser()
  },
  methods:{
    getCurrentUser(){
      this.currentUserId= window.sessionStorage.getItem('currentUserId');
      /*alert("main中的currentUserId:"+this.currentUserId)*/
        /* if (this.$route.query.currentUser!=undefined|this.$route.query.currentUser!==''){
          this.currentUserId=this.$route.query.currentUser;
           alert("main中if里的的currentUserId:"+this.currentUserId)
          window.sessionStorage.setItem('currentUserId',this.currentUserId)//存入sessionStorage中
        }else{
           window.sessionStorage.setItem('currentUserId',this.currentUserId)
          alert("main中else里的currentUserId:"+this.a)
        }*/
    },


  }
}
</script>
