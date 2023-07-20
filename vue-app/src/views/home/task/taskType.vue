<template>
  <div class="index">


    <el-row>
        <el-button type="success" size="samll" @click="dialogVisible = true">添加</el-button>
    </el-row>
      <el-table
    :data="tableData"
    style="width: 100%">
    <el-table-column
      label="添加日期"
      width="190">
      <template slot-scope="scope">
        <i class="el-icon-time"></i>
        <span style="margin-left: 10px">{{ scope.row.addtime | dateFormat }}</span>
      </template>
    </el-table-column>
    <el-table-column
      label="任务类型"
      width="180">
      <template slot-scope="scope">

          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.tasktype }}</el-tag>
          </div>

      </template>
    </el-table-column>
    <el-table-column label="操作">
      <template slot-scope="scope">
        <el-button
          size="mini"
          @click="editTaskType(scope.row.tasktype)">编辑</el-button>
        <el-button
          size="mini"
          type="danger"
          @click="handleDelete(scope.$index, scope.row)">删除</el-button>
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

      <!-- 添加任务类型 -->
      <el-dialog
        title="添加任务类型"
        :visible.sync="dialogVisible"
        width="30%">
        <el-form ref="form1" label-width="100px" @submit.native.prevent>
          <el-form-item label="任务类型">
            <el-input v-model="tasktype"></el-input>
          </el-form-item>
          <el-form-item style="text-align: right">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" native-type="submit" @click="doAddTaskType()">确 定</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
    <!-- 编辑任务类型 -->
    <el-dialog
        title="编辑任务类型"
        :visible.sync="dialogVisibleEdit"
        @submit.native.prevent
        width="30%">
      <el-form ref="form"  label-width="100px">
        <el-form-item label="任务类型" >
          <el-input v-model="tasktype"></el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisibleEdit = false">取 消</el-button>
          <el-button type="primary" native-type="submit" @click="doEditTaskType()">确 定</el-button>
        </el-form-item>
      </el-form>

    </el-dialog>
  </div>
</template>
<style>
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
        // 查询loading状态
            checkState:false,
            tasktype:"",
            taskName:"",
            page: {
                currentPage:1,
                pageSize:5,
                total:0,
                pages:0
            },
            tableData:[{
              addtime: "",
              tasktype: "",
            }],
            multipleSelection: [],
            formInline: {
                username: "",
                sex: "男"
            },
            disabled:true,
            user: {
                username: "",
                birthday:"",
                sex: "",
                address:""
            },
            dialogVisible: false,
            dialogVisibleEdit: false,
            labelPosition: 'right',
            checkIds:[],
      }
    },
    mounted() {
      this.showCurrentPage()
    },
    methods: {

      //查询所有任务类型
     /* getAllTaskTypes(){
        var _this=this;
        axios.get("http://localhost:8080/Campus_Help/admin/getAllTaskType").then((resp)=>{
          _this.tableData=resp.data.extend.taskTypes;
          console.log(_this.tableData)
        })
      },*/

      //执行任务类型添加
      doAddTaskType(){
        if ( this.tasktype!==''){
          this.$http.post("taskType/addTaskType",
              {tasktype:this.tasktype}).then((resp)=>{
            if (resp.data.code==100){
              this.dialogVisible = false
              this.tasktype ="";
              if (this.page.size==this.page.pageSize){
                this.page.currentPage=this.page.pages+1;
              }
              this.showCurrentPage();
              this.$message({
                type: 'success',
                showClose: true,
                message: resp.data.msg
              })
            }else{
              this.$message({
                type: 'error',
                showClose: true,
                message: resp.data.msg
              })
            }
          })
        }else{
          this.$message({
            type: 'error',
            showClose: true,
            message: "任务类型不能为空"
          })
        }
      },

      //表格删除按钮事件,删除任务类型
      handleDelete(index, row) {
        this.$confirm('此操作将永久删除该任务类型, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
          center: true
        }).then(() => {
          this.$http.delete("taskType/delTaskType/"+row.tasktype).then(resp=>{
            this.showCurrentPage();
            this.$message({
              type: 'success',
              showClose:true,
              message: resp.data.msg,
            });
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            showClose:true,
            message: '已取消删除'
          });
        });
      },

      //修改任务类型信息之回显数据
      editTaskType(name){
        this.tasktype=name;
        this.taskName=this.tasktype;
        this.dialogVisibleEdit = true;
      },
      //执行修改任务类型
      doEditTaskType(){
        this.$http.put("taskType/updateTaskType",{
          name:this.tasktype,oldName:this.taskName}).then((resp)=>{
          if (resp.data.code==100){
            this.dialogVisibleEdit = false;
            this.tasktype ="";
            this.taskName ="";
            this.showCurrentPage();
            this.$message({
              type: 'success',
              showClose: true,
              message: resp.data.msg
            })
          }else{
            this.$message({
              type: 'error',
              showClose: true,
              message: resp.data.msg
            })
          }
        })
      },

      showCurrentPage() {
        var _this=this;
        this.$http.get("taskType/getAllTaskType/"+_this.page.currentPage+"/"+_this.page.pageSize).then(resp=>{
          console.log(resp.data);
          _this.tableData = resp.data.extend.taskTypes.list;
          _this.page.currentPage = resp.data.extend.taskTypes.pageNum;
          _this.page.pageSize = resp.data.extend.taskTypes.pageSize;
          _this.page.total = resp.data.extend.taskTypes.total;
          _this.page.pages = resp.data.extend.taskTypes.pages;
          _this.page.size = resp.data.extend.taskTypes.size;
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


























      /*showPageNo1() {
                var _this=this;
                //alert(" showPageNo1()-->currentPage"+this.page.currentPage)
                axios.get("user/page/"+_this.page.currentPage+"/"+_this.page.pageSize).then(resp=>{
                    console.log(resp.data);
                    _this.dates = resp.data.data.records;
                    _this.page.currentPage = resp.data.data.current;
                    _this.page.pageSize = resp.data.data.size;
                    _this.page.total = resp.data.data.total;
                    _this.page.pages = resp.data.data.pages;
                })
            },
            handleCurrentChange(val) {
                console.log("当前页:"+val);
                //alert("@current-change"+val)
                this.page.currentPage=val;
                this.showPageNo1();
            },

            handleSizeChange(val) {
                console.log("每页:"+val+"条");
                this.page.pageSize=val;
                this.page.currentPage=1;
                this.showPageNo1();

            },
            addUser(){
                if (this.page.total%this.page.pageSize==0){
                    this.page.currentPage=this.page.pages+1;
                }else{
                    this.page.currentPage=this.page.pages;
                }
                this.addUserStep2();
            },
            addUserStep2(){
                var _this=this;
                console.log(this.user);
                axios.post("http://localhost:8080/user",_this.user).then(resp=>{
                    _this.dialogVisible = false;
                    _this.showPageNo1();
                    _this.user={};
                    _this.$message({
                        type: 'success',
                        showClose: true,
                        message: '操作成功'
                    })
                })
            },
            delUsers(){
                var _this=this;
                var str="";
                for (var i=0;i<_this.checkIds.length;i++){
                    if (i!=_this.checkIds.length-1){
                        str+=_this.checkIds[i]+"-";
                    }else{
                        str+=_this.checkIds[i];
                    }
                }
                //alert(str);
                _this.$confirm('确定要删除'+this.checkIds+'吗?','提示',{
                    type:'info'
                }).then(()=>{
                    axios.delete("http://localhost:8080/user/delUsers/"+str).then(resp=>{
                        _this.showPageNo1();
                        _this.checkIds=[],
                        _this.disabled=true,
                        _this.$message({
                            type:'success',
                            message:'删除成功'
                        })
                    })
                }).catch(()=>{
                    _this.checkIds=[];
                    _this.$message({
                        type: 'info',
                        showClose: true,
                        message: '当前操作取消'

                    })
                })


            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
                //console.log(this.multipleSelection)
                for (let i=0;i<this.multipleSelection.length;i++){
                    this.checkIds[i]=this.multipleSelection[i].id;
                };
                if(this.multipleSelection.length>0){
                   this.disabled=false;
                }else{
                   this.disabled=!this.disabled;
                }

                console.log(this.checkIds);
                //this.showPageNo1();
            },

            // 搜索栏提交
            onSubmit() {
                console.log(this.formInline);
                var _this=this;
                this.checkState=true;
                axios.get("http://localhost:8080/user/search?username="+_this.formInline.username+"&sex="+_this.formInline.sex)
                .then(resp=>{
                    _this.dates = resp.data.data;

                    _this.formInline.username="";
                    _this.formInline.sex="";

                    _this.showPageNo1();
                })
            },

            tableRowClassName({row, rowIndex}) {
                if (rowIndex%2==0) {
                    return 'warning-row';
                } else if (rowIndex%2!=0) {
                    return 'success-row';
                }
                return '';
            },
            delUser(id){
                console.log(id);
                this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    axios.delete("/user/"+id.id).then(resp=>{
                        this.showPageNo1();
                        this.$message({
                            type: 'success',
                            message: '删除成功!'
                        });
                    })

                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            updateUserStep1(id){
                console.log(id);
                var _this=this;
                axios.get("/user/"+id.id).then((resp)=>{
                    _this.user = resp.data.data;
                    this.dialogVisibleEdit = true;
                });
            },
            updateUserStep2(){
                var _this=this;
                axios.put("/user",_this.user).then((resp)=>{
                    _this.user = {};
                    this.dialogVisibleEdit = false;
                    _this.showPageNo1();
                });
            },


            cancel(){
                this.dialogVisible = false;
                this.dialogVisibleEdit = false;
                this.user={};
                this.$message({
                    type: 'info',
                    showClose: true,
                    message: '当前操作取消'
                });
                /!* this.$message.info("当前操作取消");*!/
            },



*/
    },

  }
</script>
