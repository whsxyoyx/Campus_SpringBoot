<template>
  <div class="index">

    <!-- :gutter指定每栏之间的间隔
       :xs="8" :sm="6" :md="4" :lg="3" :xl="1" 设置响应式布局（不同屏幕分辨率显示的行数占比，一行24）
    -->

    <el-input placeholder="请输入关键字" type="text" v-model="searchCondition.keys" class="input-with-select">
      <el-select v-model="searchCondition.schoolid" slot="prepend" placeholder="请选择学校">
        <el-option v-for="(item,index) in schools" :key="index" :label="item.name" :value="item.schoolid"></el-option>
      </el-select>
      <el-select v-model="searchCondition.tasktype" slot="prepend" placeholder="请选择任务类型">
        <el-option v-for="(item,index) in taskTypes" :key="index" :label="item.tasktype"
                   :value="item.tasktype"></el-option>
      </el-select>
      <el-button slot="append" @click="$router.go(0)" type="warning" round>重置&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|</el-button>
      <el-button slot="append" @click="searchTasks" icon="el-icon-search"></el-button>
    </el-input>
    <el-row :gutter="20" class="row-box">
      <el-col :xs="24" :sm="12" :md="4" v-for="(item,index) in taskLists" :key="index">
        <el-card style="cursor:pointer;" :body-style="{ padding: '0px' }" shadow="hover"
                 @click.native="clickCard(item)">
          <!--           <img v-if="item.img===''" :src="url" class="image">-->
          <div class="con_img">
            <!--              20230404修改-->
            <img :src="item.img" class="image">
            <!--             <img v-else="item.img" :src="require('@/assets/imgs/'+item.img)" class="image">-->
            <span class="ms">
                <span style="color:white;float: right;margin-right: 5px;margin-top: 2px">
                  <span style="color: blue">任务奖励：</span>{{ item.reward }}&nbsp;花花币
                </span>
              </span>
          </div>
          <!--            <img v-if="item.img" :src="require('@/assets/imgs/'+item.img)" class="image">-->
          <div style="padding: 14px;">
            <span>{{ item.taskname }}</span>
            <div class="bottom clearfix">
              <time class="time">{{ item.addtime | dateFormat }}</time>
              <!--              <el-button type="text" class="button">操作按钮</el-button>-->
            </div>
          </div>
        </el-card>

      </el-col>
    </el-row>
    <!-- 分页 -->
    <div class="block">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="page.currentPage"
          :page-sizes="[12, 24, 36, 48]"
          :page-size="page.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="page.total">
      </el-pagination>
    </div>

  </div>


</template>
<script>
export default {


  data() {
    return {


      //用于区分当前是搜索分页还是全部数据分页
      pageIsOrNot: false,
      /*卡片对话框*/
      dialogVisible: false,
      // 查询loading状态
      checkState: false,
      //url:require('@/assets/imgs/3.jpg'),
      schools: "",
      taskTypes: [{
        addtime: "",
        tasktype: ""
      }],

      searchCondition: {
        tasktype: '',
        schoolid: '',
        keys: ''
      },

      data: "",
      currentDate: new Date(),
      taskLists: {
        taskid: "",
        publish_user_id: "",
        publish_user_name: "",
        publish_school_id: "",
        accept_user_id: "",
        reward: "",
        addtime: "",
        endtime: "",
        taskname: "",
        taskcontext: "",
        state: "",
        //img:require("@/assets/imgs/0.jpg"),
        img: "",
        taskType: "",
        schoolName: ""
      },
      page: {
        currentPage: 1,
        pageSize: 12,
        total: 0,
        pages: 0
      },


    }

  },
  mounted() {
    this.getAllSchool();
    this.getAllTaskType();
    this.showCurrentPage();
  },
  methods: {

    //查询所有未被接受的任务
    showCurrentPage() {

      this.$http.get("task/getAllTasks/" + this.page.currentPage + "/" + this.page.pageSize).then((resp) => {
        const tasks = resp.data.extend.tasks
        const page = this.page;
        this.taskLists = tasks.list;
        page.currentPage = tasks.pageNum;
        page.pageSize = tasks.pageSize;
        page.total = tasks.total;
        page.pages = tasks.pages;
        page.size = tasks.size;


      })
    },
    handleCurrentChange(val) {
      this.page.currentPage = val;
      if (!this.pageIsOrNot) {
        this.showCurrentPage();
      } else {
        this.searchTasks();
      }
    },
    handleSizeChange(val) {
      this.page.pageSize = val;
      this.page.currentPage = 1;
      this.showCurrentPage();

    },
    //查询所有任务类型
    getAllTaskType() {
      this.$http.get("task/getAllTaskType").then((resp) => {
        this.taskTypes = resp.data.extend.taskTypes;
      })
    },

    //查询所有学校
    getAllSchool() {
      this.$http.get("task/getAllSchool").then((resp) => {
        this.schools = resp.data.extend.schoolList;

      })
    },

    //点击卡片触发该事件
    clickCard(row) {
      //用户所点击的卡片信息
      let objData = JSON.stringify(row)
      //跳转到任务详情页面
      this.$router.push({
        path: '/home/taskDisplay/taskInfo',
        query: {taskInfo: encodeURIComponent(objData)}
      })

    },


    //任务中心搜索栏
    searchTasks() {
      this.pageIsOrNot = true;
      if (this.searchCondition.keys === '') {
        if (this.searchCondition.schoolid === '' && this.searchCondition.tasktype === '') {
          this.checkState = true;
          this.showCurrentPage();
          this.checkState = false;
          //查询都不为空的情况
        } else if (this.searchCondition.schoolid !== '' && this.searchCondition.tasktype !== '') {
          this.$http.get("task/getTaskByCondition/" + this.page.currentPage + "/" + this.page.pageSize + "?schoolid=" + this.searchCondition.schoolid + "&taskType=" + this.searchCondition.tasktype)
              .then(resp => {
                if (resp.data.code === 100) {
                  const page = this.page
                  const list = resp.data.extend.list
                  this.taskLists = list.list;
                  page.currentPage = list.pageNum;
                  page.pageSize = list.pageSize;
                  page.total = list.total;
                  page.pages = list.pages;
                  this.checkState = false;
                } else {
                  this.taskLists = [];
                  this.checkState = false;
                  this.$message({
                    type: 'error',
                    showClose: true,
                    message: "暂无数据"
                  })
                }
              })
          //查询都name不为空，schoolid为空的情况
        } else if (this.searchCondition.schoolid !== '' && this.searchCondition.tasktype === '') {
          this.$http.get("task/getTaskByCondition/" + this.page.currentPage + "/" + this.page.pageSize + "?schoolid=" + this.searchCondition.schoolid + "&taskType=" + this.searchCondition.tasktype)
              .then((resp) => {
                if (resp.data.code === 100) {
                  this.checkState = false;
                  const page = this.page
                  const list = resp.data.extend.list
                  this.taskLists = list.list;
                  page.currentPage = list.pageNum;
                  page.pageSize = list.pageSize;
                  page.total = list.total;
                  page.pages = list.pages;
                } else {
                  this.taskLists = [];
                  this.checkState = false;
                  this.$message({
                    type: 'error',
                    showClose: true,
                    message: "暂无数据"
                  })
                }
              })
        } else {
          this.$http.get("task/getTaskByCondition/" + this.page.currentPage + "/" + this.page.pageSize + "?schoolid=" + this.searchCondition.schoolid + "&taskType=" + this.searchCondition.tasktype)
              .then((resp) => {
                if (resp.data.code === 100) {
                  this.checkState = false;
                  const page = this.page
                  const list = resp.data.extend.list
                  this.taskLists = list.list;
                  page.currentPage = list.pageNum;
                  page.pageSize = list.pageSize;
                  page.total = list.total;
                  page.pages = list.pages;
                } else {
                  this.taskLists = [];
                  this.checkState = false;
                  this.$message({
                    type: 'error',
                    showClose: true,
                    message: "暂无数据"
                  })
                }
              })
        }
      } else if (this.searchCondition.keys !== '' && this.searchCondition.schoolid === '' && this.searchCondition.tasktype === '') {
        this.$http.get("task/getAllTasksLike/" + this.page.currentPage
            + "/" + this.page.pageSize + "?keys=" + this.searchCondition.keys).then((resp) => {
          if (resp.data.code === 100) {
            this.checkState = false;
            const page = this.page
            const list = resp.data.extend.list
            this.taskLists = list.list;
            page.currentPage = list.pageNum;
            page.pageSize = list.pageSize;
            page.total = list.total;
            page.pages = list.pages;
          } else {
            this.taskLists = [];
            this.checkState = false;
            this.$message({
              type: 'error',
              showClose: true,
              message: "暂无数据"
            })
          }
        })

      } else {
        this.$message.error("关键字搜索不可和另外两个下拉框一起使用")
      }

    },

  }
}
</script>

<style>

.con_img {
  position: relative;
  z-index: 250;
}

.ms {
  position: absolute;
  z-index: 200;
  top: 0;
  left: 0;
  width: 100%;
  height: 25px;
  background-color: #42b983
}


[v-cloak] {
  display: none;
}

.el-select .el-input {
  width: 160px;
  margin: 9px 22px 9px 25px;
}


/*下拉框*/
.input-with-select .el-input-group__prepend {
  background-color: #42b983;
  color: #fff;
  font-size: 16px;
}

.row-box {
  margin: 10px;
}

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
  margin-bottom: 0px;

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
  height: 50%;
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

