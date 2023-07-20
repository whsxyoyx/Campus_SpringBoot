<template>
  <div>
    主页
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
