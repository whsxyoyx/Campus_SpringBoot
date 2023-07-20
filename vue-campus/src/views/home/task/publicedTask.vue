<template>
  <div class="index">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span style="font-size: 20px">所有已发布的任务</span>
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
          width="179"
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
          width="250"
        >
        </el-table-column>

        <el-table-column
          align="center"
          label="添加时间"
          width="179"
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
          width="60"
        >
        </el-table-column>
        <el-table-column
          align="center"
        >
          <template slot-scope="scope"  v-if="scope.row.state===2">
            <!-- 查看接受者信息 -->
            <el-button size="mini" @click="showAcceptInfo(scope.row.acceptUserId)" round>接受者信息</el-button>
          </template>


        </el-table-column>
        <el-table-column
          label="操作"
          align="center"
          width="240">
          <template slot-scope="scope">
            <span v-if="scope.row.state===1">
              <el-button type="primary" size="mini" @click="editTask(scope.row.taskid)">编辑任务</el-button>
              <el-button type="info" size="mini" @click="republicTask(scope.row.taskid)">重新发布</el-button>
              <el-button type="danger" size="mini" @click="cancelTask(scope.row.taskid)">移除任务</el-button>
            </span>
            <span v-else-if="scope.row.state==2">
               <el-button v-if="scope.row.state!==3 || scope.row.state!==1 " type="success" size="mini"  @click="finshedTask(scope.row)">任务完成</el-button>
               <el-button type="danger" size="mini" @click="cancelTask(scope.row.taskid)">移除任务</el-button>

            </span>
            <span v-else-if="scope.row.state===0">
<!--              <el-tag type="warning">该任务还没被人接受</el-tag>-->
              <el-button type="primary" size="mini" @click="editTask(scope.row.taskid)">编辑任务</el-button>
              <el-button type="danger" size="mini" @click="cancelTask(scope.row.taskid)">移除任务</el-button>

            </span>
            <span v-else>
              <el-tag type="success">该任务已完成啦</el-tag>
            </span>

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


    <el-dialog
      title="接受者信息"
      :visible.sync="dialogVisible"
      width="30%">
      <el-form ref="form" :model="acceptUser" label-width="80px"  @submit.native.prevent>
        <el-form-item label="学号">
          <el-input v-model="acceptUser.studentid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="acceptUser.name"  :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="性别" >
            <span v-if="acceptUser.sex===0">男</span>
            <span v-else>女</span>
        </el-form-item>
        <el-form-item label="学院">
          <el-input v-model="acceptUser.schoolName"  :disabled="true"></el-input>
        </el-form-item>
        <el-button @click="dialogVisible = false">取消</el-button>
      </el-form>
    </el-dialog>

    <!-- 编辑任务 -->
    <el-dialog
      title="编辑任务"
      :visible.sync="dialogVisibleEdit"
      width="30%">
      <el-form :model="form" :rules="rules" ref="form" label-width="100px" @submit.native.prevent class="demo-ruleForm">
        <el-form-item label="发布者姓名"   :disabled="true" >
          <el-input v-model="form.publishUserName"></el-input>
        </el-form-item>
        <el-form-item label="任务标题" disabled prop="taskname">
          <el-input v-model="form.taskname"></el-input>
        </el-form-item>
        <el-form-item label="任务描述" prop="taskcontext">
          <el-input type="textarea" maxlength="255"
                    show-word-limit v-model="form.taskcontext"></el-input>
        </el-form-item>
        <el-form-item label="任务类型" prop="tasktype">
          <el-select v-model="form.tasktype">
            <el-option v-for="(item,index) in taskTypes" :key="index" :label="item.tasktype" :value="item.tasktype"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="报酬" prop="reward">
          <el-select v-model="form.reward" placeholder="请选择报酬">
            <el-option label="0" value="0"></el-option>
            <el-option label="10" value="10"></el-option>
            <el-option label="20" value="20"></el-option>
            <el-option label="30" value="30"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisibleEdit = false">取消</el-button>
          <el-button type="primary" @click="doEditTask('form')" native-type="submit">编辑</el-button>
        </el-form-item>
      </el-form>
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
      //编辑表单
      form:{
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
      },
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
      taskTypes:[{
        addtime:"",
        tasktype:""
      }],
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
      acceptUser:{
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
      //定义规则
      rules: {
        taskname: [
          { required: true, message: '请输入任务标题', trigger: 'blur' },
          { min: 2, max: 18, message: '长度在 2 到 18 个字符', trigger: 'blur' }
        ],
        taskcontext: [
          { required: true, message: '请填写任务描述信息', trigger: 'change' },
          { min: 2, max: 255, message: '长度在 2 到 255 个字符', trigger: 'blur' }
        ],
        tasktype: [
          { required: true, message: '请选择任务类型', trigger: 'change' }
        ],
        reward: [
          { required: true, message: '请选择报酬', trigger: 'change' }
        ],
      }
    }
  },
  created() {
    this.getCurrentUser()
    this.getCurrentUserInfo()
    setTimeout(()=>{
      this.showCurrentPage()},100)
    this.getAllTaskType()
  },
  methods: {

    showAcceptInfo(id){
      this.dialogVisible=true
      //alert(id)
      if (id!=''){
        this.$http.get("user/getCurrentUser/"+id).then((resp)=>{
          if (resp.data.code!=100){
            console.log(resp.data.msg)
          }else{
            this.acceptUser = resp.data.extend.publicUser;
            this.acceptUser.schoolName = resp.data.extend.schoolName;

          }
        })
      }else{
        this.$message.error("出错啦!!!")
      }
    },

    //查询所有任务类型
    getAllTaskType(){
      let _this=this;
      this.$http.get("taskType/getAllTaskType").then((resp)=>{
        this.taskTypes=resp.data.extend.taskTypes;
        console.log(_this.taskTypes);
      })

    },

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
      console.log("你好啊，vue",_this.user)
      console.log("this.user.stuid"+_this.user.stuid)
      this.$http.get("task/taskHasPublished/"+_this.user.stuid+"/"+_this.page.currentPage+"/"+_this.page.pageSize).then(resp=>{
        console.log(resp.data);
        _this.tableData = resp.data.extend.publishedTasks.list;
        _this.page.currentPage = resp.data.extend.publishedTasks.pageNum;
        _this.page.pageSize = resp.data.extend.publishedTasks.pageSize;
        _this.page.total = resp.data.extend.publishedTasks.total;
        _this.page.pages = resp.data.extend.publishedTasks.pages;
        _this.page.size = resp.data.extend.publishedTasks.size;
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
    editTask(id){
      this.dialogVisibleEdit=true;
      this.$http.get("task/getTaskInfo",{params:{taskid: id}}).then((resp)=>{
        if (resp.data.code!=100){
          console.log(resp.data.msg)
        }else{
          this.form = resp.data.extend.taskInfo;
          console.log("表单信息回显",this.form)
        }
      })
    },
    //编辑
    doEditTask(formName){
      this.$refs[formName].validate((valid) => {
            if (valid) {
              if (this.user.money >= this.form.reward) {
                this.$http.put("task/editTask", this.form).then((resp) => {
                  if (resp.data.code === 100) {
                    this.showCurrentPage()
                    this.dialogVisibleEdit = false;
                    this.$message({
                      type: 'success',
                      message: resp.data.msg,
                    });
                  } else {
                    this.$message({
                      type: 'error',
                      message: resp.data.msg,
                    });
                  }
                })
              } else {
                this.$message({
                  type: 'error',
                  message: "余额不足,请联系管理员添加余额",
                });
              }
            }else{
              return false;
            }

      })

    },
    //重新发布
    republicTask(id){
      this.$http.put("task/rePublicTask/"+id).then((resp)=>{
        if (resp.data.code===100){
          this.showCurrentPage()
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
    },
    //取消任务
    cancelTask(id){
      this.$confirm('确定要取消任务吗? 该操作将会删除该任务','提示',{
        type:'warning'
      }).then(()=>{
        this.$http.delete("task/delTask/"+id).then((resp)=>{
            if (resp.data.code===100){
              this.showCurrentPage()
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
      }).catch(()=>{
        this.checkIds=[];
        this.$message({
          type: 'info',
          showClose: true,
          message: '当前操作取消'
        })
      })
    },
    //任务完成方法
    finshedTask(row){
      this.$confirm('确定要继续该操作? 该操作将视为任务已完成','提示',{
        type:'info'
      }).then(()=>{
        this.$http.put("task/finishedTask",row).then((resp)=>{
          if (resp.data.code===100){
            this.showCurrentPage()
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
      }).catch(()=>{
        this.checkIds=[];
        this.$message({
          type: 'info',
          showClose: true,
          message: '当前操作取消'
        })
      })
    },


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
  width: 1300px;
}
</style>
