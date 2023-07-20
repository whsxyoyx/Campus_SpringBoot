<template>
  <div class="index">


    <el-row>
      <el-col :span="5">
        <el-button type="danger" size="samll" @click="delUsers" :disabled="disabled">批量删除</el-button>
      </el-col>
      <el-col :span="18">
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
          <el-form-item label="姓名">
            <el-input v-model="formInline.username" placeholder="姓名"></el-input>
          </el-form-item>
          <el-form-item label="学院id">
            <el-input v-model="formInline.schoolid" placeholder="学院id"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary"  :loading="checkState" @click="onSubmit">查询用户</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
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
               width="60"
           >
             <template slot-scope="scope">

               <div class="demo-image__preview">

                 <el-image v-if="scope.row.photo===''"
                           :src="circleUrl"
                           width="100%"
                           fit="scale-down"
                           :preview-src-list="['https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png']"
                           class="demonstration"></el-image>
                 <el-image v-else :src="scope.row.photo"
                           width="100%"  fit="scale-down"
                           :preview-src-list="srcList"
                           @click="vbs(scope.row.photo)"
                           class="demonstration"></el-image>
               </div>

             </template>
           </el-table-column>
            <el-table-column
                    prop="stuid"
                    align="center"
                    label="stuid"
                    width="60"
                    >
            </el-table-column>
            <el-table-column
                    prop="studentid"
                    align="center"
                    label="学号"
                    width="175"
                   >
            </el-table-column>
            <el-table-column
                    prop="name"
                    align="center"
                    label="姓名"
                    width="75"
                    >
            </el-table-column>
            <el-table-column
                    prop="sex"
                    align="center"
                    label="性别"
                    width="45"
                    :formatter="sexFormate"
                    >
            </el-table-column>

            <el-table-column
                    prop="password"
                    align="center"
                    label="密码"
                    width="150"
                    >
            </el-table-column>
            <el-table-column
                    prop="schoolid"
                    align="center"
                    label="学院编号"
                    width="55"
                   >
            </el-table-column>
            <el-table-column
                    align="center"
                    label="注册时间"
                    width="190"
                    >
              <template slot-scope="scope">
                <span style="margin-left: 10px">{{scope.row.registertime | dateFormat }}</span>
              </template>
            </el-table-column>
            <el-table-column
                    prop="money"
                    align="center"
                    label="余额"
                    width="70"
                    >
            </el-table-column>
            <el-table-column
                    align="center"
                    label="状态"
                    width="100"
                    >
                    <template slot-scope="scope">
                      <el-tag type="success"  v-if="scope.row.state==0">良好</el-tag>
                      <el-tag type="danger"  v-if="scope.row.state==1">被限制</el-tag>
                    </template>
            </el-table-column>
            <el-table-column
                    label="操作"
                    align="center"
                    width="250">
                <template slot-scope="scope">
                     <el-button type="error" v-if="scope.row.state==0" size="small" @click="limitUser(scope.row)">限制</el-button>
                    <el-button type="primary" size="small" @click="editUser(scope.row)">编辑</el-button>
                    <el-button type="danger" size="small" @click="delUser(scope.row)">删除</el-button>
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

    <!-- 编辑用户对话框   -->
    <el-dialog
        title="编辑用户"
        :visible.sync="dialogVisibleEdit"
        width="30%">
      <el-form ref="form" :model="form" label-width="80px"  @submit.native.prevent>
        <el-form-item label="用户编号">
          <el-input v-model="form.stuid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="学号">
          <el-input v-model="form.studentid"></el-input>
        </el-form-item>
        <el-form-item label="性别" >
          <el-select style="width:100%" v-model="form.sex" placeholder="请选择性别">
            <el-option label="男" value="0"></el-option>
            <el-option label="女" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item label="学院编号">
          <el-input v-model="form.schoolid"></el-input>
        </el-form-item>
        <el-form-item label="余额">
          <el-input v-model="form.money"></el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisibleEdit = false">取 消</el-button>
          <el-button type="primary" @click="doEditUser" native-type="submit">确 定</el-button>
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
        circleUrl: "https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png",
        srcList: [],
        //用于区分当前是搜索分页还是全部数据分页
        pageIsOrNot:false,
        //修改用户对话框内容
        form: {
          name: '',
          stuid: '',
          password: '',
          sex: '',
          schoolid:"",
          studentid:"",
          money:""
        },

        // 查询loading状态
            checkState:false,
            page: {
                currentPage:1,
                pageSize:5,
                total:0,
                pages:0
            },
          //表格数据
          dates:[{
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
          }],

            //搜索栏查询
            formInline: {
                username: "",
               schoolid:""
            },
            //批量删除按钮显示与否
            disabled:true,

            user: {
                username: "",
                birthday:"",
                sex: "",
                address:""
            },
            // 编辑对话框
            dialogVisibleEdit: false,

            //用于批量删除
            checkIds:[],
            delUserNames:[],
            multipleSelection: [],
      }
    },
  mounted() {
    this.showCurrentPage();
  },
    methods: {

      //查询所有用户
      /*getAllUsers(){
        var _this=this;
        axios.get("http://localhost:8080/Campus_Help/admin/getUsers").then((resp)=>{
          _this.dates=resp.data.extend.userList;
        })
      },*/
      //修改用户数据回显
      editUser(row){
        this.dialogVisibleEdit = true;
        this.$http.get("admin/getCurrentUser/"+row.studentid).then((resp)=>{
          this.form=resp.data.extend.user;
          if (this.form.sex==0){
            this.form.sex="男";
          }else{
            this.form.sex="女";
          }
        })
      },
      //执行修改用户操作
      doEditUser(){
        if (this.form.sex=="男"|this.form.sex==0){
          this.form.sex=0;
        }else if (this.form.sex=="女"|this.form.sex==1){
          this.form.sex=1;
        }
        this.$http.put("admin/updateUser",this.form).then((resp)=>{
          if (resp.data.code==100){
            this.dialogVisibleEdit = false;
            this.form = {};
            this.showCurrentPage();
            this.$message({
              type: 'success',
              showClose: true,
              message: resp.data.msg
            })
          }else{
            if (this.form.sex=="0"){
              this.form.sex="男";
            }else if (this.form.sex=='1'){
              this.form.sex="女";
            }
            this.$message({
              type: 'error',
              showClose: true,
              message: resp.data.msg
            })
          }
        })

      },
      //每选中一个都会调用该方法
      handleSelectionChange(val) {
        this.multipleSelection = val;
        //console.log(this.multipleSelection)
        for (let i=0;i<this.multipleSelection.length;i++){
          console.log(this.multipleSelection.length);
          //获取每个选择的行的信息
          this.checkIds[i]=this.multipleSelection[i].stuid;
          this.delUserNames[i]=this.multipleSelection[i].name;
        };
        if(this.multipleSelection.length>0){
          this.disabled=false;
        }else{
          this.disabled=!this.disabled;
          this.checkIds=[];
          this.delUserNames=[];
        }
      },
      //批量删除任务
      delUsers(){
        var str="";
        for (var i=0;i<this.checkIds.length;i++){
          if (i!=this.checkIds.length-1){
            str+=this.checkIds[i]+"-";
          }else{
            str+=this.checkIds[i];
          }
        }
        this.$confirm('确定要删除【'+this.delUserNames+'】这些用户吗?','提示',{
          type:'info'
        }).then(()=>{
          this.$http.delete("admin/delUsers/"+str).then((resp)=>{
            this.showCurrentPage();
            this.checkIds=[],
            this.delUserNames=[];
            this.disabled=true,
            this.$message({
              type:'success',
              showClose: true,
              message:resp.data.msg,
            })
          })
        }).catch(()=>{
          this.checkIds=[];
          this.delUserNames=[];
          this.$message({
            type: 'info',
            showClose: true,
            message: '当前操作取消'
          })
        })


      },
      //删除用户
      delUser(row){
        console.log(row);
        this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
          center: true
        }).then(() => {
          this.$http.delete("admin/delUser/"+row.stuid).then(resp=>{
            this.showCurrentPage();
            this.$message({
              type: 'success',
              message: resp.data.msg,
            });
          })

        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });
      },

      //限制用户
      limitUser(row){
        this.$http.put("admin/limitUser/"+row.stuid).then((resp)=>{
          if (resp.data.code==100){
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

      vbs(val) {
        this.srcList = []
        this.srcList.push(val)
      },
      // 搜索栏提交
      onSubmit() {
        var _this=this;
        this.pageIsOrNot=true;
        //用户名和学校id都为空 即为查询所有
        if(this.formInline.username===''&&this.formInline.schoolid===''){
          this.checkState=true;
         this.showCurrentPage();
          this.checkState=false;
          //查询都不为空的情况
        }else if (this.formInline.username!==''&&this.formInline.schoolid!==''){
          this.checkState=true;
          this.$http.get("admin/search/"+this.page.currentPage+"/"+this.page.pageSize+"?name="+_this.formInline.username+"&schoolid="+_this.formInline.schoolid)
              .then((resp)=>{
                if (resp.data.code===100){
                  this.checkState=false;
                  this.dates = resp.data.extend.users.list;
                  this.page.currentPage = resp.data.extend.users.pageNum;
                  this.page.pageSize = resp.data.extend.users.pageSize;
                  this.page.total = resp.data.extend.users.total;
                  this.page.pages = resp.data.extend.users.pages;
                  this.$message({
                    type: 'success',
                    showClose: true,
                    message: resp.data.msg
                  })
                }else{
                  _this.dates=[];
                  this.checkState=false;
                  this.$message({
                    type: 'error',
                    showClose: true,
                    message: resp.data.msg
                  })
                }
              })
          //查询name不为空，schoolid为空的情况
        }else if (this.formInline.username!==''&&this.formInline.schoolid===''){
          this.$http.get("admin/search/"+this.page.currentPage+"/"+this.page.pageSize+"?name="+_this.formInline.username+"&schoolid="+_this.formInline.schoolid)
              .then((resp)=>{
                if (resp.data.code===100){
                  this.checkState=false;
                  this.dates = resp.data.extend.users.list;
                  this.page.currentPage = resp.data.extend.users.pageNum;
                  this.page.pageSize = resp.data.extend.users.pageSize;
                  this.page.total = resp.data.extend.users.total;
                  this.page.pages = resp.data.extend.users.pages;
                  this.$message({
                    type: 'success',
                    showClose: true,
                    message: resp.data.msg
                  })

                }else{
                  _this.dates=[];
                  this.checkState=false;
                  this.$message({
                    type: 'error',
                    showClose: true,
                    message: resp.data.msg
                  })
                }
              })
        }else{
          this.$http.get("admin/search/"+this.page.currentPage+"/"+this.page.pageSize+"?name="+_this.formInline.username+"&schoolid="+_this.formInline.schoolid)
              .then((resp)=>{
                if (resp.data.code===100){
                  this.checkState=false;
                  this.dates = resp.data.extend.users.list;
                  this.page.currentPage = resp.data.extend.users.pageNum;
                  this.page.pageSize = resp.data.extend.users.pageSize;
                  this.page.total = resp.data.extend.users.total;
                  this.page.pages = resp.data.extend.users.pages;
                  this.$message({
                    type: 'success',
                    showClose: true,
                    message: resp.data.msg
                  })

                }else{
                  _this.dates=[];
                  this.checkState=false;
                  this.$message({
                    type: 'error',
                    showClose: true,
                    message: resp.data.msg
                  })
                }
              })
        }
      },

      showCurrentPage() {
        var _this=this;
        //alert(" showCurrentPage()-->currentPage"+this.page.currentPage)
        this.$http.get("admin/getUsers/"+_this.page.currentPage+"/"+_this.page.pageSize).then(resp=>{
          console.log(resp.data);
          _this.dates = resp.data.extend.userList.list;
          _this.page.currentPage = resp.data.extend.userList.pageNum;
          _this.page.pageSize = resp.data.extend.userList.pageSize;
          _this.page.total = resp.data.extend.userList.total;
          _this.page.pages = resp.data.extend.userList.pages;
        })
      },
      handleCurrentChange(val) {
        console.log("当前页:"+val);
        this.page.currentPage=val;
        if (!this.pageIsOrNot){
          this.showCurrentPage();
        }else{
          this.onSubmit();
        }

      },
      handleSizeChange(val) {
        console.log("每页:"+val+"条");
        this.page.pageSize=val;
        this.page.currentPage=1;
        this.showCurrentPage();

      },

      tableRowClassName({row, rowIndex}) {
        if (rowIndex%2==0) {
          return 'warning-row';
        } else if (rowIndex%2!=0) {
          return 'success-row';
        }
        return '';
      },

      sexFormate(row,index){
        if (row.sex == 0) {
          return "男";
        } else if(row.sex ==1){
          return "女";
        }
      },










    /*
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
