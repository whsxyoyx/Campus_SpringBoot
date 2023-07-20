<template>
  <div class="index">

    <div><span style="font-size: 80px;color: #333333;;margin-top: 75px">欢迎使用校园互助后台管理系统</span></div>
    <el-carousel :interval="4000" type="card">
      <el-carousel-item v-for="item in imgLists" :key="item">
        <img :src="item" alt="图片加载失败" class="image">
      </el-carousel-item>
    </el-carousel>

    <!-- :gutter指定每栏之间的间隔
       :xs="8" :sm="6" :md="4" :lg="3" :xl="1" 设置响应式布局（不同屏幕分辨率显示的行数占比，一行24）
    -->
    <el-row :gutter="20" class="row-box">
      <el-col :xs="24" :sm="12" :md="4" v-for="(item,index) in cardLists" :key="index">
        <el-card :body-style="{ padding: '0px' }">
          <img :src="item.showImgs" class="image">
        </el-card>
      </el-col>
    </el-row>
  </div>


</template>


<script>


export default {


  data() {
    return {
      data: "",
      currentDate: new Date(),
      imgLists: [
        // 使用require动态引入图片
        require("@/assets/imgs/0.jpg"),
        require("@/assets/imgs/1.jpg"),
        require("@/assets/imgs/2.jpg"),
        require("@/assets/imgs/3.jpg"),
        require("@/assets/imgs/4.png"),
        require("@/assets/imgs/5.jpg"),
        require("@/assets/imgs/6.jpg"),
      ],

      cardLists: [
        {title: "标题", showImgs: require("@/assets/imgs/0.jpg")},
        {title: "标题", showImgs: require("@/assets/imgs/1.jpg")},
        {title: "标题", showImgs: require("@/assets/imgs/2.jpg")},
        {title: "标题", showImgs: require("@/assets/imgs/2.jpg")},
        {title: "标题", showImgs: require("@/assets/imgs/1.jpg")},
        {title: "标题", showImgs: require("@/assets/imgs/0.jpg")},
      ],
    }

  },
}
</script>

<style>

/* 定义走马灯图片样式 */
.el-carousel__container {
  width: 100%;
}

.row-box {
  display: flex;
  flex-flow: wrap;
}

.row-box .el-card {
  min-width: 100%;
  height: 100%;
  margin-right: 20px;
  border: 0px;
  box-shadow: 0 3px 20px 2px rgba(0, 0, 0, .3);
}

.time {
  font-size: 13px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}

.image {
  width: 100%;

}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both
}

.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 200px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}


</style>

