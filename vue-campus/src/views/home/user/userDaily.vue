<template>
  <div class="index">


    <el-row>
      <el-button type="success" size="samll"  @click="dialogVisible=true">添加日志</el-button>
    </el-row>
    <el-table
      :data="tableDate"
      style="width: 100%"
      :row-class-name="tableRowClassName">
      <el-table-column
        prop="id"
        align="center"
        label="日志编号"
        width="60"
      >
      </el-table-column>
      <el-table-column
        prop="question"
        align="center"
        label="今日疑惑"
        width="175"
      >
      </el-table-column>
      <el-table-column
        prop="suggest"
        align="center"
        label="如何解决"
        width="175"
      >
      </el-table-column>
      <el-table-column
        prop="gain"
        align="center"
        label="收获"
        width="175"
      >
      </el-table-column>
      <el-table-column
        align="subtime"
        label="添加时间"
        width="190"
      >
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{scope.row.subtime | dateFormat }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        align="center"
        width="250">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click="editDaily(scope.row)">编辑</el-button>
          <el-button type="danger" size="small" @click="delDaily(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <div class="block">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page.sync="page.currentPage"
        :page-sizes="[5, 10, 15, 20]"
        :page-size="page.pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="page.total">
      </el-pagination>
    </div>

    <!-- 编辑日志 -->
    <el-dialog
      title="编辑日志"
      :visible.sync="dialogVisibleEdit"
      width="30%">
      <el-form ref="form" :model="editForm" label-width="80px"  @submit.native.prevent>
        <el-form-item label="今日疑惑">
          <el-input
            type="textarea"
            :autosize="{ minRows: 2, maxRows: 4}"
            placeholder="请输入内容，最多输入255个字符"
            v-model="editForm.question">
          </el-input>
        </el-form-item>
        <el-form-item label="建议">
          <el-input
            type="textarea"
            :autosize="{ minRows: 2, maxRows: 4}"
            placeholder="请输入内容，最多输入255个字符"
            v-model="editForm.suggest">
          </el-input>
        </el-form-item>
        <el-form-item label="收获">
          <el-input
            type="textarea"
            :autosize="{ minRows: 2, maxRows: 4}"
            placeholder="请输入内容，最多输入255个字符"
            v-model="editForm.gain">
          </el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisibleEdit= false">取 消</el-button>
          <el-button type="primary" @click="doEditDaily" native-type="submit">确 定</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!-- 添加日志 -->
    <el-dialog
      title="日志添加"
      :visible.sync="dialogVisible"
      width="30%">
      <el-form ref="form" :model="form" label-width="80px"  @submit.native.prevent>
        <el-form-item label="今日疑惑">
          <el-input
            type="textarea"
            :autosize="{ minRows: 2, maxRows: 4}"
            placeholder="请输入内容，最多输入255个字符"
            v-model="form.question">
          </el-input>
        </el-form-item>
        <el-form-item label="建议">
          <el-input
            type="textarea"
            :autosize="{ minRows: 2, maxRows: 4}"
            placeholder="请输入内容，最多输入255个字符"
            v-model="form.suggest">
          </el-input>
        </el-form-item>
        <el-form-item label="收获">
          <el-input
            type="textarea"
            :autosize="{ minRows: 2, maxRows: 4}"
            placeholder="请输入内容，最多输入255个字符"
            v-model="form.gain">
          </el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisible= false">取 消</el-button>
          <el-button type="primary" @click="doAddDaily" native-type="submit">确 定</el-button>
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
      checkState: false,
      editForm:{
        gain: '',
        question: '',
        suggest: '',
      },
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
      form:{
        id: 0,
        gain: '',
        question: '',
        suggest: '',
        subtime: "",
        lastupdatetime: '',
        sid: ""
      },
      tableDate: [{
        id: 0,
        gain: '',
        question: '',
        suggest: '',
        subtime:"",
        lastupdatetime: '',
        sid: ""
      }],
      page: {
        currentPage: 1,
        pageSize: 5,
        total: 0,
        pages: 0
      },
      multipleSelection: [],
      disabled: true,
      dialogVisible: false,
      dialogVisibleEdit: false,
      checkIds: [],
      sid:0
    }
  },
  beforeMount() {

  },
  mounted() {
    this.getCurrentUser()
    this.getCurrentUserInfo()
    this.showCurrentPage()
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
            console.log(this.user)
          }
        })
      }else{
        this.$message.error("出错啦!!!")
      }

    },

    //添加日志
    doAddDaily() {
      this.dialogVisible = true
      this.form.sid=this.user.stuid;
      this.$http.post("daily/addDaily", this.form).then(resp => {
        if (resp.data.code == 100) {
          if (this.page.total % this.page.pageSize===0){
            this.page.currentPage=this.page.pages+1;
          }else{
            this.page.currentPage=this.page.pages
          }
          this.showCurrentPage();
          this.form = {}
          this.dialogVisible = false,
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
    },

    showCurrentPage() {
      var _this = this;
      console.log("得到了吗" + sessionStorage.getItem('currentUserId'))
      this.$http.get("daily/getAllDaily/" + sessionStorage.getItem('currentUserId') + "/" + _this.page.currentPage + "/" + _this.page.pageSize)
        .then(resp => {
          _this.tableDate = resp.data.extend.list.list;
          _this.page.currentPage = resp.data.extend.list.pageNum;
          _this.page.pageSize = resp.data.extend.list.pageSize;
          _this.page.total = resp.data.extend.list.total;
          _this.page.pages = resp.data.extend.list.pages;
          this.form.sid=resp.data.extend.sid;
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
    //修改日志数据回显
    editDaily(row) {
      this.dialogVisibleEdit = true;
      this.$http.get("daily/getDailyById/" + row.id).then((resp) => {
        this.editForm = resp.data.extend.daily;
      })
    },
    //执行修改日志操作
    doEditDaily() {
      this.$http.put("daily/updateDaily",this.editForm).then((resp) => {
        if (resp.data.code == 100) {
          this.dialogVisibleEdit = false;
          this.editForm ={};
          this.showCurrentPage();
          this.$message({
            type: 'success',
            showClose: true,
            message: resp.data.msg
          })
        } else {
          this.$message({
            type: 'error',
            showClose: true,
            message: resp.data.msg
          })
        }
      })

    },

    //删除日志
    delDaily(row) {
      console.log(row);
      this.$confirm('此操作将永久删除该日志, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        center: true
      }).then(() => {
        this.$http.delete("daily/delDailyById/" + row.id).then(resp => {
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
    tableRowClassName({row, rowIndex}) {
      if (rowIndex % 2 == 0) {
        return 'warning-row';
      } else if (rowIndex % 2 != 0) {
        return 'success-row';
      }
      return '';
    },
  }

}
</script>
<style scoped>
.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}
</style>
