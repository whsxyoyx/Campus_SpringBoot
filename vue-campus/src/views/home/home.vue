<template>
  <div>
    主页


<!--    toUserInfoPath
    stuId:"",
    toUserInfoPath:"",
    mounted(){
    this.getCurrentUser()
    },
    methods:{
    getCurrentUser(){

    alert("<-&#45;&#45;navMenu-&ndash;&gt;"+this.$route.params.currentUser);
    this.stuId=this.$route.params.currentUser;
    this.toUserInfoPath="/user/userInfo/"+this.stuId;
    alert(this.toUserInfoPath);
    },
    }-->

    <button type="button" ref="pro" @click="btn('pro')">dianji</button>
  </div>
</template>

<script>
export default {
  name: "home",
  methods:{
    btn(pro){
      this.$refs[pro].innerHTML="你好世界";
    }
  }
}
</script>

<style scoped>

</style>
