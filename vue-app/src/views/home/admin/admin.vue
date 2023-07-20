<template>
  <div class="index">
<!--    <el-row>

      <el-col  :offset="17"><h4>当前管理员账户：<el-tag effect="dark">{{currentAdminAccount}}</el-tag></h4></el-col>
      <el-col  :offset="19" style="margin-top: 10px"><el-link  type="primary" @click.native="logout()">退出登录</el-link></el-col>
    </el-row>-->


      <el-button type="success" size="samll" @click="dialogVisible = true">添加</el-button>
  <el-table
    :data="tableData"
    style="width: 90%">
    <el-table-column

      prop="aid"
      label="管理员编号"
      width="150">
    </el-table-column>
    <el-table-column
      prop="account"
      label="账户名"
      width="150">
    </el-table-column>
    <el-table-column
      prop="name"
      label="姓名"
      width="150">
    </el-table-column>
    <el-table-column
      prop="password"
      label="密码"
      width="150">
    </el-table-column>
    <el-table-column
      label="添加时间"
      width="200">
      <template slot-scope="scope">
        <i class="el-icon-time"></i>
        <span style="margin-left: 10px">{{ scope.row.addtime | dateFormat }}</span>
      </template>
    </el-table-column>
    <el-table-column
      label="状态"
      width="120">
      <template slot-scope="scope">
        <el-tag size="medium" v-if="scope.row.state==0">良好</el-tag>
        <el-tag size="medium" type="danger" v-if="scope.row.state==1">被限制了呜呜呜</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作" width="180">
      <template slot-scope="scope">
        <el-button
          size="mini"
          @click="editAdmin(scope.row.aid)">编辑</el-button>
        <el-button
          size="mini"
          type="danger"
          @click="handleDelete(scope.$index, scope.row)">删除</el-button>
      </template>
    </el-table-column>
  </el-table>


      <!-- 添加管理员 -->
      <el-dialog
        title="添加管理员"
        :visible.sync="dialogVisible"
        width="30%">

        <el-form ref="form1" label-width="100px" @submit.native.prevent>
          <el-form-item label="管理员账号">
            <el-input v-model="addAdmin.account"></el-input>
          </el-form-item>
          <el-form-item label="管理员姓名">
            <el-input v-model="addAdmin.name"></el-input>
          </el-form-item>
          <el-form-item style="text-align: right">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" native-type="submit" @click="doAddAdmin()">确 定</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
    <!-- 编辑管理员 -->
    <el-dialog
        title="编辑管理员"
        :visible.sync="dialogVisibleEdit"
        width="30%">
      <el-form ref="form" :model="form" label-width="100px" @submit.native.prevent>
        <el-form-item label="管理员编号" >
          <el-input v-model="form.aid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="账户名">
          <el-input v-model="form.account"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <template slot-scope="scope">
            <el-switch v-model="form.state"
                       active-color="#13ce66"
                       inactive-color="#ff4949"
                       active-text="良好"
                       :active-value="0"
                       inactive-text="限制"
                       :inactive-value="1"></el-switch>
          </template>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisibleEdit = false">取 消</el-button>
          <el-button type="primary" native-type="submit"  @click="doEditAdmin()">确 定</el-button>
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
    .el-table__row{
      text-align: center;
    }
</style>



<script>



  import axios from "axios";

  export default {
    data() {
      return {
        // 查询loading状态
        checkState:false,
        oldPass:"",
        addAdmin:{
          name: '',
          account:"",
        },
        //管理员修改表单
        form: {
          name: '',
          aid:"",
          addtime:"",
          account:"",
          password:"",
          state:0,
        },

        tableData: [{
                aid:'',
                account:"",
                password: '',
                name: '',
                addtime: '',
                state:'',
              }],
        page: {
                currentPage:1,
                pageSize:5,
                total:0,
                pages:0
            },

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
        checkIds:[],
        /*currentAdminAccount:"",*/
      }
    },
    filters:{
     /* stateFilter(value){
          if(value==0){
              return "良好"
          }else if(value==1){
              return "被限制了呜呜呜~"
          }
      }*/
    },
  mounted() {
      this.getAllAdmins();
  },
    methods: {
      //查询所有管理员
      getAllAdmins(){
        this.currentAdminAccount=window.sessionStorage.getItem('currentAdminAccount');
      /*  alert("当前账户："+this.currentAdminAccount)*/
        var _this=this;
        this.$http.get("admin/getAllAdmin").then((resp)=>{
          _this.tableData=resp.data.extend.adminList;
        })
      },
      //修改管理员之数据回显
      editAdmin(id){
        console.log(id);
        this.$http.get("admin/getAdmin/"+id).then((resp)=>{
          this.form = resp.data.extend.admin;
          this.oldPass=this.form.password;
          this.dialogVisibleEdit = true;
        });
      },
      //执行修改管理员(同时还带有修改密码的功能，修改密码后要重新登录)
      doEditAdmin(){
        this.$http.put("admin/updateAdmin",this.form).then((resp)=>{
          if (resp.data.code===100){
            this.dialogVisibleEdit = false;
            if(this.oldPass===this.form.password){
              /*alert("----->"+this.oldPass+"<----"+this.form.password);*/
              this.form = {};
              this.getAllAdmins();
              this.$message({
                type: 'success',
                showClose: true,
                message: resp.data.msg
              })
            }else{
              this.$router.push("/login")
              this.$message({
                type: 'success',
                showClose: true,
                message: "修改成功,请重新登录"
              })
            }
          }else{
            this.$message({
              type: 'error',
              showClose: true,
              message: resp.data.msg
            })
          }


        })
      },
      //添加管理员
      doAddAdmin(){
        if ( this.addAdmin.name!==''&&this.addAdmin.account!==''){
          this.$http.post("admin/addAdmin",
              this.addAdmin).then((resp)=>{
            if (resp.data.code==100){
              this.dialogVisible = false
              this.addAdmin ="";
              this.getAllAdmins();
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
            message: "账户名或姓名不能为空"
          })
        }

      },
     /* //退出登录
      logout(){
        sessionStorage.removeItem("currentAdminAccount");
        this.$router.push("/login");
      },*/
      //删除管理员
      handleDelete(index, row) {
        alert(index)
        this.$confirm('此操作将永久删除该管理员, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
          center: true
        }).then(() => {
          this.$http.delete("admin/delAdmin/"+row.aid).then(resp=>{
            this.getAllAdmins();
            this.$message({
              type: 'success',
              showClose: true,
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
    },

  }
</script>
