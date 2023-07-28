<template>
  <information-slot @updatePage="updatePage">
    <template #delBtn>
      <el-button type="danger" :disabled="taskSelectedList.length === 0" @click="bulkDelTask">批量删除</el-button>
    </template>
    <template #queryUser>
      <el-select v-model="taskTypes.tasktype" placeholder="请选择任务类型">
        <el-option v-for="(item,index) in taskTypes" :key="index" :label="item.tasktype"
                   :value="item.tasktype"></el-option>
      </el-select>
      <el-button type="primary" @click="queryTask" :disabled="!taskTypes.tasktype">查询</el-button>
    </template>
    <template #content>
      <!-- 任务表单信息 -->
      <el-table :data="task.list" style="width: 100%" @selection-change="handleSelectionChange" v-loading="userStore.loading">
        <el-table-column type="selection" align="center" width="30"/>
        <el-table-column prop="taskid" align="center" label="任务编号"/>
        <el-table-column prop="publishUserId" align="center" label="发布者id"/>
        <el-table-column prop="publishUserName" align="center" label="发布者姓名"/>
        <el-table-column prop="publishSchoolId" align="center" label="发布者学院编号"/>
        <el-table-column prop="acceptUserId" align="center" label="接受者编号"/>
        <el-table-column prop="taskname" align="center" label="任务名"/>
        <el-table-column align="center" label="任务类型">
          <template #default="scope">
            <div slot="reference" class="name-wrapper">
              <el-tag type="warning" size="medium">{{ scope.row.tasktype }}</el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="taskcontext" align="center" label="任务描述"/>
        <el-table-column prop="reward" align="center" label="报酬"/>
        <el-table-column align="center" label="添加时间" width="165">
          <template #default="scope">
            <span style="margin-left: 10px">{{
                new Date(scope.row.addtime).toLocaleString().replaceAll("/", "-")
              }}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="状态">
          <template #default="scope">
            <el-tag v-if="scope.row.state ===0">待解决</el-tag>
            <el-tag type="danger" v-if="scope.row.state ===1">任务关闭</el-tag>
            <el-tag type="info" v-if="scope.row.state ===2">解决中</el-tag>
            <el-tag type="success" v-if="scope.row.state ===3">已完成</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="132">
          <template #default="scope">
            <el-button type="primary" size="small" @click="taskEdit(scope.row.taskid)">编辑</el-button>
            <el-button type="danger" size="small" @click="delTask(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </template>
  </information-slot>
  <!--修改任务的对话框-->
  <Dialog ref="dialogRef">
    <template #container>
      <el-form ref="formRef" :model="form" label-width="100px" @submit.native.prevent>
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
            <el-radio :label="0" size="mini" border>待解决</el-radio>
            <el-radio :label="1" size="mini" border>任务关闭</el-radio>
            <el-radio :label="2" size="mini" border>解决中</el-radio>
            <el-radio :label="3" size="mini" border>已完成</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="任务描述">
          <el-input type="textarea" v-model="form.taskcontext"></el-input>
        </el-form-item>
      </el-form>
    </template>
    <template #btnConfirm>
      <el-button type="primary" @click="confirmEdit">修改</el-button>
    </template>
  </Dialog>
</template>

<script setup>
import InformationSlot from "@/components/InformationSlot.vue"
import {ref, onMounted, reactive} from 'vue'
import {request} from "@/api/request.js";
import Dialog from "@/components/Dialog.vue";
import {useUserStore} from "@/stores/user.js"
const userStore = useUserStore()
//多选按钮选中的数据
const taskSelectedList = ref([])
const task = reactive({
  pageInfo: {
    pageNum: 1,//当前页码值
    pageSize: 5, // 当前页要展示的数据条数
    total: 0 //总页码值
  },
  list: []
})
const dialogRef = ref(null)
//编辑对话框的回显数据
const form = ref({})
//获取到选中的的某一项并保存到数组中
const handleSelectionChange = function (value) {
  taskSelectedList.value = value
}
//任务类型数组
const taskTypes = ref([])
const getTaskList = async function () {
  const res = await request({
    url: `admin/getAllTask/${task.pageInfo.pageNum}/${task.pageInfo.pageSize}`,
    method: 'get',
    // params:{
    //   taskType:taskTypes.value
    // }
  })
  if (res.code === 100) {
    const {list, pageNum, pageSize, total} = res.extend.taskList;
    task.list = list
    task.pageInfo.pageNum = pageNum
    task.pageInfo.pageSize = pageSize
    task.pageInfo.total = total
  }
}
//批量删除任务
const bulkDelTask = async function () {
  const idList = [];
  taskSelectedList.value.forEach(item => {
    idList.push(item.taskid)
  })
  const newIdList = idList.join('-');
  try {
    const res = await ElMessageBox.confirm(
        `你确定要删除任务编号为${newIdList}吗?`,
        '警告',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
        }
    )
    if (res === "confirm") {
      const res = await request({
        method: 'delete',
        url: "admin/delTasks/" + newIdList
      })
      if (res.code === 100) {
        await getTaskList()
        ElNotification.success(res.msg)
      } else {
        ElNotification.error(res.msg)
      }
    }
  } catch (e) {
    return e
  }
}
//删除任务的处理函数
const delTask = async function (row) {
  const res = await request({
    url: "admin/delTask/" + row.taskid,
    method: 'delete'
  })
  if (res.code === 100) {
    await getTaskList()
    ElMessage.success(res.msg)
  } else {
    ElMessage.error(res.msg)
  }
}

//查询所有任务类型
const getAllTaskType = async function () {
  const res = await request({
    url: 'taskType/getAllTaskType',
    method: 'get'
  })
  if (res.code === 100) {
    taskTypes.value = res.extend.taskTypes;
  }
}
//根据任务类型查询所有任务
const queryTask = async function () {
  const res = await request({
    url: "admin/getTaskByCondition/" + task.pageInfo.pageNum + "/" + task.pageInfo.pageSize,
    params: {
      schoolid: '',
      taskType: taskTypes.value.tasktype
    }
  })
  if (res.code === 100) {
    const {list, pageNum, pageSize, total} = res.extend.list;
    task.list = list
    task.pageInfo.pageNum = pageNum
    task.pageInfo.pageSize = pageSize
    task.pageInfo.total = total
  } else {
    ElNotification.error(res.msg)
  }
}
const updatePage = function (pageInfo) {
  task.pageInfo = pageInfo.value
  getTaskList()
}
//打开修改任务的对话框并进行数据回显
const taskEdit = async function (id) {
  dialogRef.value.openDialog("编辑任务")
  const res = await request({
    url: "admin/getTaskInfo/" + id,
    method:'get'
  })
  if(res.code === 100){
    form.value = res.extend.taskInfo;
  }
}
//修改任务
const confirmEdit = async function (){
  const res = await request({
    url:'admin/updateTask',
    data:form.value,
    method:'put'
  })
  if(res.code === 100){
    dialogRef.value.closeDialog()
    await getTaskList()
    ElNotification.success(res.msg)
  }else {
    ElNotification.error(res.msg)
  }
}
onMounted(function () {
  //组件创建完成立即查询所有任务列表
  getTaskList()
  //组件创建完成立即查询所有任务类型
  getAllTaskType()
})
</script>
<style lang="less" scoped>
</style>
