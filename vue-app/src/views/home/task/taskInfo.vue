<template>
  <div class="index">
    <el-row>
      <el-col :span="5">
        <el-button type="danger" size="samll" @click="delTasks" :disabled="disabled">批量删除</el-button>
      </el-col>
      <el-col :span="18">
        <!-- 搜索栏 -->
        <el-form :inline="true" class="demo-form-inline" ref="searchForm">

          <el-form-item label="发布者学院名">
            <el-select v-model="schools.schoolid" placeholder="发布者学院名">
              <el-option v-for="(item,index) in schools" :key="index" :label="item.name"
                         :value="item.schoolid"></el-option>

            </el-select>
          </el-form-item>
          <el-form-item label="任务类型">
            <el-select v-model="taskTypes.tasktype" placeholder="任务类型">
              <el-option v-for="(item,index) in taskTypes" :key="index" :label="item.tasktype"
                         :value="item.tasktype"></el-option>

            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="onSubmit" :loading="checkState">查询</el-button>
            <el-button type="info" @click="$router.go(0)">重置</el-button>
            <!--
                        <el-button type="primary" @click="resetSearchInput('searchForm')" :loading="checkState">重置</el-button>
            -->
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

    <!-- 任务表单信息 -->
    <el-table

        :data="dates"
        style="width: 100%"
        :row-class-name="tableRowClassName"
        @selection-change="handleSelectionChange">
      <el-table-column
          type="selection"
          align="center"
          width="55">
      </el-table-column>
      <el-table-column
          align="center"
          label="img"
          width="63"
      >
        <template slot-scope="scope">
          　　　　
          <div class="demo-image__preview">


            <!--                  <el-image  :src="scope.row.img"
                                        width="100%"  fit="scale-down"
                                        :preview-src-list="srcList"
                                        @click="vbs(scope.row.img)"
                                        class="demonstration"></el-image>-->

            <el-image :src="scope.row.img"
                      width="100%" fit="scale-down"
                      :preview-src-list="scope.row.srcList"
                      class="demonstration"></el-image>

          </div>


          　　
        </template>
      </el-table-column>

      <el-table-column
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
      </el-table-column>
      <el-table-column
          prop="publishUserName"
          align="center"
          label="发布者姓名"
      >
      </el-table-column>
      <el-table-column
          prop="publishSchoolId"
          align="center"
          label="发布者学院编号"
          width="63"
      >
      </el-table-column>
      <el-table-column
          prop="acceptUserId"
          align="center"
          label="接受者编号"
          width="63"
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
      >
      </el-table-column>
      <el-table-column
          prop="reward"
          align="center"
          label="报酬"
      >
      </el-table-column>
      <el-table-column
          align="center"
          label="添加时间"
      >
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.addtime | dateFormat }}</span>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="状态"
      >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.state==0">待解决</el-tag>
          <el-tag type="danger" v-if="scope.row.state==1">任务关闭</el-tag>
          <el-tag type="info" v-if="scope.row.state==2">解决中</el-tag>
          <el-tag type="success" v-if="scope.row.state==3">已完成</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          label="操作"
          align="center"
          width="150">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click="taskEdit(scope.row.taskid)">编辑</el-button>
          <el-button type="danger" size="small" @click="delTask(scope.row)">删除</el-button>
          <!-- <el-button type="danger" size="small" @click="delUser">删除</el-button>-->
        </template>
      </el-table-column>
    </el-table>

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

    <!--      任务编辑对话框-->
    <el-dialog
        title="编辑任务"
        :visible.sync="dialogVisibleEdit"
        width="45%">

      <el-form ref="form" :model="form" label-width="100px" @submit.native.prevent>
        <el-form-item label="任务编号">
          <el-col :span="9">
            <el-input v-model="form.taskid" :disabled="true"></el-input>
          </el-col>
          <el-col class="line" :span="3" :offset="1"> 发布者id</el-col>
          <el-col :span="9">
            <el-input v-model="form.publishUserId"></el-input>
          </el-col>
        </el-form-item>
        <el-form-item label="发布者姓名">
          <el-col :span="9">
            <el-input v-model="form.publishUserName"></el-input>
          </el-col>
          <el-col class="line" :span="3" :offset="1">接受者id</el-col>
          <el-col :span="9">
            <el-input v-model="form.acceptUserId"></el-input>
          </el-col>
        </el-form-item>
        <!--            <el-form-item label="接受者编号">
                      <el-input v-model="form.acceptUserId" ></el-input>
                    </el-form-item>-->
        <el-form-item label="任务名">
          <el-input v-model="form.taskname"></el-input>
        </el-form-item>
        <el-form-item label="任务类型">
          <el-select v-model="form.tasktype" placeholder="任务类型">
            <el-option v-for="(item,index) in taskTypes" :key="index" :label="item.tasktype"
                       :value="item.tasktype"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="任务状态">
          <el-radio-group v-model="form.state">
            <el-radio label="0" size="mini" border>待解决</el-radio>
            <el-radio label="1" size="mini" border>任务关闭</el-radio>
            <el-radio label="2" size="mini" border>解决中</el-radio>
            <el-radio label="3" size="mini" border>已完成</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="任务描述">
          <el-input type="textarea" v-model="form.taskcontext"></el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisibleEdit = false">取消</el-button>
          <el-button type="primary" @click="doTaskEdit()" native-type="submit">编辑</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
<style scoped>
.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}
</style>

<script>
import axios from "axios";

export default {
  data() {
    return {
      circleUrl: "https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png",
      /*任务编辑对话框数据*/
      form: {
        taskid: '',
        publishUserName: '',
        publishUserId: '',
        acceptUserId: '',
        reward: "",
        taskname: "",
        taskcontext: '',
        state: "",
        tasktype: '',
      },

      //用于区分当前是搜索分页还是全部数据分页
      pageIsOrNot: false,

      schools: "",
      taskTypes: [{
        addtime: "",
        tasktype: ""
      }],
      // 查询loading状态
      checkState: false,
      page: {
        currentPage: 1,
        pageSize: 5,
        total: 0,
        pages: 0
      },
      dates: [{
        taskid: "",
        publishUserId: "",
        publishUserName: "",
        publishSchoolId: "",
        acceptUserId: "",
        reward: "",
        addtime: "",
        taskname: "",
        taskcontext: "",
        state: "",
        img: "",
        tasktype: "",
        srcList: [{}]
      }],
      multipleSelection: [],
      taskSearch: {
        schoolName: [],
        tasktype: [],
      },
      disabled: true,
      user: {
        username: "",
        birthday: "",
        sex: "",
        address: ""
      },
      // 对话框展示
      dialogVisible: false,
      dialogVisibleEdit: false,

      labelPosition: 'right',
      checkIds: [],
    }
  },
  mounted() {
    this.showCurrentPage();
    this.getAllTaskType();
    this.getAllSchool();
  },
  methods: {

    //查询所有任务
    /* getAllTasks(){
       var _this=this;
       axios.get("http://localhost:8080/Campus_Help/admin/getAllTask").then((resp)=>{
         _this.dates=resp.data.extend.taskList;
       })
     },*/
    //每选中一个都会调用该方法
    handleSelectionChange(val) {
      this.multipleSelection = val;
      //console.log(this.multipleSelection)
      for (let i = 0; i < this.multipleSelection.length; i++) {
        //获取每个选择的行的信息
        this.checkIds[i] = this.multipleSelection[i].taskid;
      }
      ;
      if (this.multipleSelection.length > 0) {
        this.disabled = false;
      } else {
        this.disabled = !this.disabled;
        this.checkIds = [];
      }
    },
    //批量删除任务
    delTasks() {
      var _this = this;
      var str = "";
      for (var i = 0; i < _this.checkIds.length; i++) {
        if (i != _this.checkIds.length - 1) {
          str += _this.checkIds[i] + "-";
        } else {
          str += _this.checkIds[i];
        }
      }
      _this.$confirm('确定要删除任务编号为：' + this.checkIds + '的任务吗?', '提示', {
        type: 'info'
      }).then(() => {
        this.$http.delete("admin/delTasks/" + str).then(resp => {
          _this.showCurrentPage();
          _this.checkIds = [],
              _this.disabled = true,
              _this.$message({
                type: 'success',
                showClose: true,
                message: resp.data.msg,
              })
        })
      }).catch(() => {
        _this.checkIds = [];
        _this.$message({
          type: 'info',
          showClose: true,
          message: '当前操作取消'
        })
      })


    },
    //删除任务
    delTask(row) {
      console.log(row);
      this.$confirm('此操作将永久删除该任务, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        center: true
      }).then(() => {
        this.$http.delete("admin/delTask/" + row.taskid).then(resp => {
          this.showCurrentPage();
          this.$message({
            type: 'success',
            message: resp.data.msg,
          });
        })

      }).catch(() => {
        this.$message({
          type: 'info',
          showClose: true,
          message: '已取消删除'

        });
      });
    },
    //查询所有任务类型
    getAllTaskType() {
      this.$http.get("taskType/getAllTaskType").then((resp) => {
        this.taskTypes = resp.data.extend.taskTypes;
      })

    },

    //查询所有学校
    getAllSchool() {
      this.$http.get("admin/getAllSchool").then((resp) => {
        this.schools = resp.data.extend.schoolList;
      })
    },

    // 搜索栏提交
    onSubmit() {
      this.pageIsOrNot = true;
      if (this.schools.schoolid === undefined && this.taskTypes.tasktype === undefined) {
        this.checkState = true;
        this.showCurrentPage();
        this.checkState = false;
        //查询都不为空的情况
      } else if (this.schools.schoolid !== undefined && this.taskTypes.tasktype !== undefined) {
        this.$http.get("admin/getTaskByCondition/" + this.page.currentPage + "/" + this.page.pageSize + "?schoolid=" + this.schools.schoolid + "&taskType=" + this.taskTypes.tasktype)
            .then(resp => {
              if (resp.data.code === 100) {
                this.dates = resp.data.extend.list.list;
                //用于显示指定任务包含的图片
                for (let i = 0; i < this.dates.length; i++) {
                  this.dates[i].srcList = this.dates[i].img.split(" ");
                  if (this.dates[i].srcList.length > 1) {
                    this.dates[i].img = this.dates[i].srcList[0];
                  }
                }
                this.page.currentPage = resp.data.extend.list.pageNum;
                this.page.pageSize = resp.data.extend.list.pageSize;
                this.page.total = resp.data.extend.list.total;
                this.page.pages = resp.data.extend.list.pages;
                this.checkState = false;
              } else {
                this.dates = [];
                this.checkState = false;
              }
            })
        //查询都name不为空，schoolid为空的情况
      } else if (this.schools.schoolid !== undefined && this.taskTypes.tasktype === undefined) {
        this.$http.get("admin/getTaskByCondition/" + this.page.currentPage + "/" + this.page.pageSize + "?schoolid=" + this.schools.schoolid + "&taskType=" + this.taskTypes.tasktype)
            .then((resp) => {
              if (resp.data.code === 100) {
                this.checkState = false;
                this.dates = resp.data.extend.list.list;
                //用于显示指定任务包含的图片
                for (let i = 0; i < this.dates.length; i++) {
                  this.dates[i].srcList = this.dates[i].img.split(" ");
                  if (this.dates[i].srcList.length > 1) {
                    this.dates[i].img = this.dates[i].srcList[0];
                  }
                }
                this.page.currentPage = resp.data.extend.list.pageNum;
                this.page.pageSize = resp.data.extend.list.pageSize;
                this.page.total = resp.data.extend.list.total;
                this.page.pages = resp.data.extend.list.pages;
              } else {
                this.dates = [];
                this.checkState = false;
              }
            })
      } else {
        this.$http.get("admin/getTaskByCondition/" + this.page.currentPage + "/" + this.page.pageSize + "?schoolid=" + this.schools.schoolid + "&taskType=" + this.taskTypes.tasktype)
            .then((resp) => {
              if (resp.data.code === 100) {
                this.checkState = false;
                this.dates = resp.data.extend.list.list;
                //用于显示指定任务包含的图片
                for (let i = 0; i < this.dates.length; i++) {
                  this.dates[i].srcList = this.dates[i].img.split(" ");
                  if (this.dates[i].srcList.length > 1) {
                    this.dates[i].img = this.dates[i].srcList[0];
                  }
                }
                const list = resp.data.extend.list;
                const page = this.page
                page.currentPage = list.pageNum;
                page.pageSize = list.pageSize;
                page.total = list.total;
                page.pages = list.pages;
              } else {
                this.dates = [];
                this.checkState = false;
              }
            })
      }
    },
    //修改任务之数据回显
    taskEdit(id) {
      this.dialogVisibleEdit = true;
      this.$http.get("admin/getTaskInfo/" + id).then((resp) => {
        this.form = resp.data.extend.taskInfo;
        this.form.state = this.form.state.toString();
      })

    },
    //执行任务修改
    doTaskEdit() {
      console.log(this.form);

      this.$http.put("admin/updateTask", this.form).then((resp) => {
        if (resp.data.code === 100) {
          this.dialogVisibleEdit = false;
          this.form = {};
          this.$message({
            type: 'success',
            showClose: true,
            message: resp.data.msg
          });
          this.showCurrentPage();
        } else {
          this.$message({
            type: 'error',
            showClose: true,
            message: resp.data.msg
          })
        }

      })
    },


    showCurrentPage() {
      this.$http.get("admin/getAllTask/" + this.page.currentPage + "/" + this.page.pageSize).then(resp => {

        this.dates = resp.data.extend.taskList.list;
        //用于显示指定任务包含的图片
        for (let i = 0; i < this.dates.length; i++) {
          this.dates[i].srcList = this.dates[i].img.split(" ");
          if (this.dates[i].srcList.length > 1) {
            this.dates[i].img = this.dates[i].srcList[0];
          }
        }

        const page = this.page
        const taskLink = resp.data.extend.taskList;
        page.currentPage = taskLink.pageNum;
        page.pageSize = taskLink.pageSize;
        page.total = taskLink.total;
        page.pages = taskLink.pages;
      })
    },
    handleCurrentChange(val) {
      this.page.currentPage = val;
      if (!this.pageIsOrNot) {
        this.showCurrentPage();
      } else {
        this.onSubmit();
      }

    },
    handleSizeChange(val) {
      console.log("每页:" + val + "条");
      this.page.pageSize = val;
      this.page.currentPage = 1;
      this.showCurrentPage();

    },
    tableRowClassName({rowIndex}) {
      if (rowIndex % 2 === 0) {
        return 'warning-row';
      } else if (rowIndex % 2 !== 0) {
        return 'success-row';
      }
      return '';
    },

    cancel() {
      this.dialogVisible = false;
      this.dialogVisibleEdit = false;
      this.user = {};
      this.$message({
        type: 'info',
        showClose: true,
        message: '当前操作取消'
      });
    },


  },

}
</script>
