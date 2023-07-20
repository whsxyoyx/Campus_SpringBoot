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
import login from "@/views/login/Login";
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
    //解除被限制的用户
    unLimitUser(index,row){
      this.$http.put("admin/openUser/"+row.stuid).then((resp)=>{
        if (resp.data.code === 100){
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
    //解除所有被限制的用户
    unLimitUsers(){
      this.$confirm('此操作将解除所有学生限制, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        center: true
      }).then(() => {
        this.$http.put("admin/openAllUsers").then((resp)=>{
          if (resp.data.code === 100){
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
      this.$http.get("admin/getLimitedUsers/"+this.page.currentPage+"/"+this.page.pageSize).then(resp=>{
        if (this.tableData.length>0){
          this.showBtn=1;
        }
        //设置表格中没数据的时候，批量删除按钮会隐藏
        if (this.tableData.length === 0){
          this.showBtn=-1;
        }
        const limitedUsers = resp.data.extend.limitedUsers;
        this.tableData = limitedUsers.list;
        this.page.currentPage = limitedUsers.pageNum;
        this.page.pageSize = limitedUsers.pageSize;
        this.page.total = limitedUsers.total;
        this.page.pages = limitedUsers.pages;
        this.page.size = limitedUsers.size;
      })
    },
    handleCurrentChange(val) {
      this.page.currentPage=val;
      this.showCurrentPage();
    },
    handleSizeChange(val) {
      this.page.pageSize=val;
      this.page.currentPage=1;
      this.showCurrentPage();

    },
  },

}
</script>
