<template>
  <div class="index">


    <el-row>
      <el-button type="success" size="samll" @click="dialogVisible = true">添加</el-button>
    </el-row>
    <el-table
        :data="tableData"
        style="width: 100%">
      <el-table-column
          prop="schoolid"
          label="学院id"
          width="150">
      </el-table-column>
      <el-table-column
          prop="name"
          label="学院名"
          width="150">
      </el-table-column>
      <el-table-column
          label="添加时间"
          width="200">
        <template slot-scope="scope">
          <i class="el-icon-time"></i>
          <span style="margin-left: 10px">{{ dateFormat(scope.row.addtime) }}</span>
        </template>
      </el-table-column>
      <el-table-column
          label="状态"
          width="180">
        <template slot-scope="scope">

          <div slot="reference" class="name-wrapper">
            <el-tag size="medium" type="success" v-if="scope.row.state==0">良好</el-tag>
            <el-tag size="medium" type="danger" v-if="scope.row.state==1">被限制</el-tag>
          </div>

        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
              size="mini"
              @click="editSchool(scope.row)">编辑
          </el-button>
          <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除
          </el-button>
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

    <!-- 添加学院 -->
    <el-dialog
        title="添加学院"
        :visible.sync="dialogVisible"
        width="30%">

      <el-form ref="form" label-width="100px" @submit.native.prevent>
        <el-form-item label="学院名">
          <el-input v-model="schoolName"></el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" native-type="submit" @click="doAddSchool()">确 定</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
    <!-- 修改学院 -->
    <el-dialog
        title="编辑学院"
        :visible.sync="dialogVisibleEdit"
        @submit.native.prevent
        width="30%">

      <el-form ref="form" :model="form" label-width="100px">
        <el-form-item label="学院id">
          <el-input v-model="form.schoolid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="学院名">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="学院状态">
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
          <el-button type="primary" native-type="submit" @click="doEditSchool()">确 定</el-button>
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
      checkState: false,
      schoolName: "",
      //修改学院对话框中字段
      form: {
        name: '',
        schoolid: "",
        state: 0,
      },
      tableData: [{
        schoolid: "",
        name: "",
        addtime: '',
        state: '',
      }],
      page: {
        currentPage: 1,
        pageSize: 5,
        total: 0,
        pages: 0,
        size: 0,
      },
      multipleSelection: [],
      formInline: {
        username: "",
        sex: "男"
      },
      disabled: true,
      user: {
        username: "",
        birthday: "",
        sex: "",
        address: ""
      },
      dialogVisible: false,
      dialogVisibleEdit: false,
      labelPosition: 'right',
      checkIds: [],
    }
  }, mounted() {
    this.showCurrentPage()
  },
  methods: {
    showCurrentPage() {
      this.$http.get("admin/getAllSchool/" + this.page.currentPage + "/" + this.page.pageSize).then(resp => {
        console.log(this);
        const page = this.page;
        const schoolList = resp.data.extend.schoolList
        this.tableData = schoolList.list;
        page.currentPage = schoolList.pageNum;
        page.pageSize = schoolList.pageSize;
        page.total = schoolList.total;
        page.pages = schoolList.pages;
        page.size = schoolList.size;
      })
    },
    handleCurrentChange(val) {
      this.page.currentPage = val;
      this.showCurrentPage();
    },
    handleSizeChange(val) {
      this.page.pageSize = val;
      this.page.currentPage = 1;
      this.showCurrentPage();

    },
    /*分页操作------end-------*/
    //表格删除按钮事件,删除学院
    handleDelete(index, row) {
      this.$confirm('此操作将永久删除该学院, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        center: true
      }).then(() => {
        this.$http.delete("admin/delSchool/" + row.schoolid).then(resp => {
          this.showCurrentPage();
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
    //执行添加学院操作
    doAddSchool() {
      this.$http.post("admin/addSchool", {name: this.schoolName}).then((resp) => {
        if (resp.data.code === 100) {
          this.dialogVisible = false
          this.schoolName = "";
          if (this.page.size === this.page.pageSize) {
            this.page.currentPage = this.page.pages + 1;
          }
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
    //修改学院信息之回显数据
    editSchool(row) {
      this.dialogVisibleEdit = true;

      this.$http.get("admin/getSchoolInfo/" + row.schoolid).then((resp) => {
        this.form = resp.data.extend.schoolInfo;
      })
    },
    //执行修改学院
    doEditSchool() {
      /* alert(this.form.state)*/
      this.$http.put("admin/updateSchool", this.form).then((resp) => {
        if (resp.data.code === 100) {
          this.dialogVisibleEdit = false;
          this.form = {};
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
    //时间格式化
    dateFormat(time) {
      //将13位时间戳转换成时间格式  输出为2018-10-09
      let date = new Date(time);
      let year = date.getFullYear();
      let month = date.getMonth() + 1;
      let day = date.getDate();
      month = month < 10 ? "0" + month : month;
      day = day < 10 ? "0" + day : day;
      let myDate = ''
      myDate = year + '-' + month + '-' + day;
      return myDate
    },
  },
}
</script>
