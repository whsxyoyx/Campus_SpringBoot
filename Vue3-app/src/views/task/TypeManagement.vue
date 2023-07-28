<template>
  <el-row>
    <el-button type="success" @click="openAddTaskTypeDialog">添加任务类型</el-button>
  </el-row>
  <el-table :data="task.list" v-loading="userStore.loading">
    <el-table-column align="center" label="添加日期">
      <template #default="scope">
        <el-icon><Timer /></el-icon>
        <i class="el-icon-time"></i>
        {{ new Date(scope.row.addtime).toLocaleString().replaceAll("/", "-") }}
      </template>
    </el-table-column>
    <el-table-column align="center" label="任务类型">
      <template #default="scope">
        <el-tag>{{ scope.row.tasktype }}</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作" align="center">
      <template #default="scope">
        <el-button size="small" @click="editTaskType(scope.row.tasktype)"
          >编辑</el-button
        >
        <el-popconfirm
          title="您确定要删除该类型吗?"
          @confirm="handleDelete(scope.row)"
        >
          <template #reference>
            <el-button size="small" type="danger">删除</el-button>
          </template>
        </el-popconfirm>
      </template>
    </el-table-column>
  </el-table>
  <!--编辑任务类型的对话框-->
  <Dialog ref="editDialogRef">
    <template #container>
      <el-input type="text" placeholder="请输入任务类型" v-model="typeName"></el-input>
    </template>
    <template #btnConfirm>
      <el-button type="primary" @click="confirmUpdate">修改</el-button>
    </template>
  </Dialog>
  <!--新增任务类型的对话框-->
  <Dialog ref="addDialogRef">
    <template #container>
      <el-input type="text" placeholder="请输入任务类型" v-model="addNewType"/>
    </template>
    <template #btnConfirm>
      <el-button type="primary" @click="addTaskType">确认</el-button>
    </template>
  </Dialog>
  <!-- 分页 -->
  <Pagination @updatePage="updatePage" />
</template>

<script setup>
import {onMounted, reactive, ref} from "vue";
import { request } from "@/api/request.js";
import { Timer } from "@element-plus/icons-vue";
import Dialog from "@/components/Dialog.vue";
import {useUserStore} from "@/stores/user.js"
const userStore = useUserStore()
const editDialogRef = ref(null)
const addDialogRef = ref(null)
const typeName = ref("")
const oldName = ref("")
const addNewType = ref("")
const task = reactive({
  pageInfo: {
    pageNum: 1, //当前页码值
    pageSize: 5, // 当前页要展示的数据条数
    total: 0, //总页码值
  },
  list: [],
});
// 获取所有的任务类型
const getTaskTypeList = async function () {
  const res = await request({
    url: `taskType/getAllTaskType/${task.pageInfo.pageNum}/${task.pageInfo.pageSize}`,
    method: "get",
  });
  if (res.code === 100) {
    const { list, pageNum, pageSize, total } = res.extend.taskTypes;
    task.list = list;
    task.pageInfo.pageNum = pageNum;
    task.pageInfo.pageSize = pageSize;
    task.pageInfo.total = total;
  }
};
// 删除任务类型
const handleDelete = async function (row) {
  const res = await request({
    url: "taskType/delTaskType/" + row.tasktype,
    method: "delete",
  });
  if (res.code === 100) {
    await getTaskTypeList();
    ElNotification.success(res.msg);
  } else ElNotification.error(res.msg);
};
//打开编辑任务类型的对话框并进行数据的回显
const editTaskType = function (taskType){
  editDialogRef.value.openDialog("编辑任务类型")
  oldName.value = taskType
  typeName.value = taskType
}
// 执行修改操作
const confirmUpdate = async function (){
  if(typeName.value){
    const res = await request({
      url:'taskType/updateTaskType',
      method:'put',
      data:{
        name:typeName.value,
        oldName:oldName.value
      }
    })
    if(res.code === 100){
      await getTaskTypeList()
      editDialogRef.value.closeDialog()
      ElNotification.success(res.msg)
    }else {
      ElNotification.error(res.msg)
    }
  }
}
//打开添加任务类型对话框
const openAddTaskTypeDialog = function (){
  addDialogRef.value.openDialog("新增任务类型")
}
//执行添加操作
const addTaskType = async function (){
  if(addNewType.value){
    const res = await request({
      url:'taskType/addTaskType',
      method:'post',
      data:{
        tasktype:addNewType.value
      }
    })
    if(res.code === 100){
      addDialogRef.value.closeDialog()
      await getTaskTypeList()
      ElNotification.success(res.msg)
    }else {
      ElNotification.error(res.msg)
    }
  }else {
    ElNotification.warning("请输入任务类型!!")
  }
}
// 获取页码信息
const updatePage = function (pageInfo) {
  task.pageInfo = pageInfo.value;
  getTaskTypeList();
};
onMounted(getTaskTypeList);
</script>
<style lang="less" scoped></style>
