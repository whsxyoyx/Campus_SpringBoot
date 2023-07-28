<template>
  <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>学生权限修改</span>
      <el-button style="float: right" type="primary" @click="unLimitAll"
        >全部解除限制</el-button
      >
    </div>
    <el-table :data="student.list" v-loading="userStore.loading">
      <el-table-column prop="name" label="用户名"> </el-table-column>
      <el-table-column prop="schoolid" label="学院编号"> </el-table-column>
      <el-table-column label="用户状态">
        <template #default="scope">
          <el-tag type="danger" v-if="scope.row.state === 1">被限制</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template #default="scope">
          <el-button size="small" type="danger" @click="unLimitUser(scope.row)"
            >解除限制</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <Pagination @updatePage="updatePage" />
  </el-card>
</template>

<script setup>
import { reactive, onMounted } from "vue";
import { request } from "@/api/request.js";
import {useUserStore} from "@/stores/user.js"
const userStore = useUserStore()

const student = reactive({
  pageInfo: {
    pageNum: 1, //当前页码值
    pageSize: 5, // 当前页要展示的数据条数
    total: 0, //总页码值
  },
  list: [],
});
//获取所有学生
const getStudentList = async function () {
  const res = await request({
    url: `admin/getLimitedUsers/${student.pageInfo.pageNum}/${student.pageInfo.pageSize}`,
    method: "get",
  });
  if (res.code === 100) {
    const { list, pageNum, pageSize, total } = res.extend.limitedUsers;
    student.list = list;
    student.pageInfo.pageNum = pageNum;
    student.pageInfo.pageSize = pageSize;
    student.pageInfo.total = total;
  }
};
//解除学生限制
const unLimitUser = async function (row) {
  const res = await request({
    url: "admin/openUser/" + row.stuid,
    method: "put",
  });
  if (res.code === 100) {
    ElMessage.success(res.msg);
    await getStudentList();
  } else {
    ElMessage.error(res.msg);
  }
};
//解全部学生限制
const unLimitAll = function () {
  ElMessageBox.confirm("此操作将解除所有学生限制, 是否继续?", "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  }).then(
    () => {
      request({
        url: "admin/openAllUsers",
        method: "put",
      }).then((res) => {
        if (res.code === 100) {
          getStudentList();
          ElNotification.success(res.msg);
        } else ElNotification.error(res.msg);
      });
    },
    () => {
      ElMessage({
        type: "info",
        message: "已取消解除!",
      });
    }
  );
};
const updatePage = function (pageInfo) {
  student.pageInfo = pageInfo.value;
  getStudentList();
};
onMounted(getStudentList);
</script>
<style lang="less" scoped></style>
