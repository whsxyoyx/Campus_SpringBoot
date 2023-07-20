<template>
  <div class="index">


    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>用户权限修改</span>
        <el-button v-if="showBtn>0" style="float: right; padding: 3px 0" type="primary" @click="unLimitUsers">全部解除限制</el-button>
      </div>
      <el-table
          :data="tableData"
          style="width: 100%">
        <el-table-column
            prop="name"
            label="用户名"
            width="190">
        </el-table-column>
        <el-table-column
            prop="schoolid"
            label="学院编号"
            width="190">
        </el-table-column>
        <el-table-column
            label="用户状态"
            width="180">
          <template slot-scope="scope">
            <el-tag type="danger" v-if="scope.row.state==1">被限制</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
                size="mini"
                type="danger"
                @click="unLimitUser(scope.$index, scope.row)">解除限制</el-button>
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

    </el-card>






  </div>
</template>
<style scoped>
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
  width: 780px;
}
</style>

<script>
import axios from "axios";
export default {
  data() {
    return {
      // 查询loading状态
      checkState:false,
      showBtn:0,



      page: {
        currentPage:1,
        pageSize:5,
        total:0,
        pages:0
      },
      tableData: [{
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

    //查询到所有被限制的用户
   /* getLimitedUsers(){
      var _this=this;
      axios.get("http://localhost:8080/Campus_Help/admin/getLimitedUsers").then((resp)=>{
        _this.tableData=resp.data.extend.limitedUsers;
        if (_this.tableData.length>0){
          _this.showBtn=1;
        }
        //设置表格中没数据的时候，批量删除按钮会隐藏
        if (this.tableData.length==0){
          this.showBtn=-1;
        }
      })
    },*/
    //解除被限制的用户
    unLimitUser(index,row){

      axios.put("http://localhost:8080/Campus_Help/admin/openUser/"+row.stuid).then((resp)=>{
        if (resp.data.code==100){
          this.showCurrentPage();
          console.log(index, row);
          console.log("after:"+this.tableData.length);

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
    //解除所有被限制的用户
    unLimitUsers(index, row){
    /*  console.log(index, row);*/
      this.$confirm('此操作将解除所有学生限制, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        center: true
      }).then(() => {
        axios.put("http://localhost:8080/Campus_Help/admin/openAllUsers").then((resp)=>{
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
      }).catch(() => {
        this.$message({
          type: 'info',
          showClose:true,
          message: '已取消删除'
        });
      });
    },

    showCurrentPage() {
      var _this=this;
      //alert(" showCurrentPage()-->currentPage"+this.page.currentPage)
      this.$http.get("admin/getLimitedUsers/"+_this.page.currentPage+"/"+_this.page.pageSize).then(resp=>{
        console.log(resp.data);
        if (_this.tableData.length>0){
          _this.showBtn=1;
        }
        //设置表格中没数据的时候，批量删除按钮会隐藏
        if (this.tableData.length==0){
          this.showBtn=-1;
        }
        _this.tableData = resp.data.extend.limitedUsers.list;
        _this.page.currentPage = resp.data.extend.limitedUsers.pageNum;
        _this.page.pageSize = resp.data.extend.limitedUsers.pageSize;
        _this.page.total = resp.data.extend.limitedUsers.total;
        _this.page.pages = resp.data.extend.limitedUsers.pages;
        _this.page.size = resp.data.extend.limitedUsers.size;
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











   /* showPageNo1() {
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
