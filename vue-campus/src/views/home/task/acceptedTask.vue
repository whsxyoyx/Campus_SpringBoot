<template>
  <div class="index">
    <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span style="font-size: 20px">所有已接受的任务</span>
    </div>
      <el-table
        :data="tableData"
        style="width: 100%">
<!--        <el-table-column
          prop="taskid"
          align="center"
          label="任务编号"
          width="63"
        >
        </el-table-column>
        <el-table-column
          prop="publishUserId"
          align="center"
          label="发布者id"
          width="63"
        >
        </el-table-column>-->
        <el-table-column
          prop="publishUserName"
          align="center"
          label="发布者姓名"
        >
        </el-table-column>
        <el-table-column
          prop="taskname"
          align="center"
          label="任务名"
        >
        </el-table-column>
        <el-table-column
          align="center"
          label="任务类型"
        >
          <template slot-scope="scope">

            <div slot="reference" class="name-wrapper">
              <el-tag type="warning" size="medium">{{ scope.row.tasktype }}</el-tag>
            </div>

          </template>
        </el-table-column>

        <el-table-column
          prop="taskcontext"
          align="center"
          label="任务描述"
          width="180"
        >
        </el-table-column>

        <el-table-column
          align="center"
          label="添加时间"
          width="180"
        >
          <template slot-scope="scope">
            <span style="margin-left: 10px">{{scope.row.addtime | dateFormat }}</span>
          </template>
        </el-table-column>
        <el-table-column
          align="center"
          label="状态"
        >
          <template slot-scope="scope">
            <el-tag  v-if="scope.row.state==0" >待解决</el-tag>
            <el-tag type="danger"  v-if="scope.row.state==1">任务关闭</el-tag>
            <el-tag type="info" v-if="scope.row.state==2">解决中</el-tag>
            <el-tag type="success"  v-if="scope.row.state==3">已完成</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="reward"
          align="center"
          label="报酬"
        >
        </el-table-column>
        <el-table-column
          label="操作"
          align="center"
          width="250">
          <template slot-scope="scope">
            <el-button type="danger" size="small" round @click="cancelTask(scope.row.taskid)">放弃任务</el-button>
            <!-- <el-button type="danger" size="small" @click="delUser">删除</el-button>-->
          </template>
        </el-table-column>
      </el-table>
    </el-card>


    <!-- 分页 -->
    <div class="block">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="page.currentPage"
        :page-sizes="[5, 10, 15, 20]"
        :page-size="page.pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="page.total">
      </el-pagination>
    </div>

    <!-- 添加任务 -->
    <el-dialog
      title="提示"
      :visible.sync="dialogVisible"
      width="30%">
      <span>这是一段信息</span>
      <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
        </span>
    </el-dialog>
  </div>
</template>




<script>
import axios from "axios";

export default {
  data() {
    return {
      // 查询loading状态
      checkState:false,
      tableData: [{
        taskid: "",
        publishUserId: "",
        publishUserName: "",
        publishSchoolId: "",
        acceptUserId: "",
        reward: "",
        addtime: "",
        endtime: "",
        taskname: "",
        taskcontext: "",
        state: "",
        img: "",
        taskType: "",
      }],
      page: {
        currentPage:1,
        pageSize:5,
        total:0,
        pages:0
      },

      disabled:true,
      user:{
        stuid:"",
        studentid:"",
        password:"",
        schoolid:"",
        sex:"",
        name:"",
        registertime:"",
        money:"",
        state:"",
        photo:"",
        schoolName:"",
      },
      dialogVisible: false,
      dialogVisibleEdit: false,
    }
  },
  created() {
    this.getCurrentUser()
    this.getCurrentUserInfo()
    setTimeout(()=>{this.showCurrentPage()},100)
    // this.showCurrentPage()
  },
  methods: {
    getCurrentUser(){
      this.user.studentid = window.sessionStorage.getItem('currentUserId');
    },
    getCurrentUserInfo(){
      if (this.user.studentid!=''){
        this.$http.get("user/getCurrentUser?studentid="+this.user.studentid).then((resp)=>{
          if (resp.data.code!=100){
            console.log(resp.data.msg)
          }else{
            this.user = resp.data.extend.user;
            this.user.schoolName = resp.data.extend.schoolName;
          }
        })
      }else{
        this.$message.error("出错啦!!!")
      }

    },
    /*分页操作------start-------*/
    showCurrentPage() {
      var _this=this;
     console.log("this.user.stuid",_this.user.stuid)
      this.$http.get("task/taskHasAccepted/"+_this.user.stuid+"/"+_this.page.currentPage+"/"+_this.page.pageSize).then(resp=>{
        console.log(resp.data);
        _this.tableData = resp.data.extend.acceptedTasks.list;
        _this.page.currentPage = resp.data.extend.acceptedTasks.pageNum;
        _this.page.pageSize = resp.data.extend.acceptedTasks.pageSize;
        _this.page.total = resp.data.extend.acceptedTasks.total;
        _this.page.pages = resp.data.extend.acceptedTasks.pages;
        _this.page.size = resp.data.extend.acceptedTasks.size;
        console.log("查询到的数据", _this.tableData)
      })
    },
    handleCurrentChange(val) {
      console.log("当前页:"+val);
      //alert("@current-change"+val)
      this.page.currentPage=val;
      this.showCurrentPage();
    },
    handleSizeChange(val) {
      console.log("每页:"+val+"条");
      this.page.pageSize=val;
      this.page.currentPage=1;
      this.showCurrentPage();

    },
    /*分页操作------end-------*/

    //放弃任务
    cancelTask(id){
      this.$http.put("task/cancelTask/"+id).then((resp)=>{
        if (resp.data.code===100){
          this.showCurrentPage();
          this.$message({
            type: 'success',
            message: resp.data.msg,
          });
        }else{
          this.$message({
            type: 'error',
            message: resp.data.msg,
          });
        }
      })
    }


  },

}
</script>

<style scoped>
.block{
  text-align: center;
}
.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

.box-card {
  width: 1280px;
}
</style>
