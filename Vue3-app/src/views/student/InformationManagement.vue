<template>
  <information-slot @updatePage="updatePage">
    <template #delBtn>
      <el-button type="danger" :disabled="studentSelectedList.length === 0" @click="bulkDelStudent">批量删除</el-button>
    </template>
    <template #queryUser>
      <el-input v-model.trim="searchName" placeholder="请输入姓名" clearable>
        <template #append>
          <el-button :icon="Search" @click="queryStudent"/>
        </template>
      </el-input>
    </template>
    <template #content>
      <el-table :data="student.list" style="width: 100%" @selection-change="handleSelectionChange" v-loading="userStore.loading">
        <el-table-column type="selection" align="center"/>
        <el-table-column prop="stuid" align="center" label="stuid"/>
        <el-table-column prop="studentid" align="center" label="学号" width="140"/>
        <el-table-column prop="name" align="center" label="姓名"/>
        <el-table-column align="center" label="性别">
          <template #default="{row}">
            <el-icon v-if="row.sex === 0">
              <Male/>
            </el-icon>
            <el-icon v-else>
              <Female/>
            </el-icon>
          </template>
        </el-table-column>
        <el-table-column prop="password" align="center" label="密码"/>
        <el-table-column prop="schoolid" align="center" label="学院编号"/>
        <el-table-column align="center" label="注册时间" width="165">
          <template #default="scope">
            <span style="margin-left: 10px">{{
                new Date(scope.row.registertime).toLocaleString().replaceAll("/", "-")
              }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="money" align="center" label="余额"/>
        <el-table-column align="center" label="状态">
          <template #default="scope">
            <el-tag type="success" v-if="scope.row.state === 0">良好</el-tag>
            <el-tag type="danger" v-if="scope.row.state === 1">被限制</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" align="center">
          <template #default="scope">
            <el-button type="error" :style="{visibility:scope.row.state === 0 ? 'visible':'hidden'}" size="small"
                       @click="limitStudent(scope.row)">限制
            </el-button>
            <el-button type="primary" size="small" @click="editStudent(scope.row)">编辑</el-button>
            <el-popconfirm title="您确定要删除该学生吗?" @confirm='delStudent(scope.row)'>
              <template #reference>
                <el-button type="danger" size="small">删除</el-button>
              </template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
    </template>
  </information-slot>
  <Dialog ref="dialogRef">
    <template #container>
      <el-form ref="formRef" :model="updateForm" label-width="80px" @submit.native.prevent label-position="left">
        <el-form-item label="用户编号">
          <el-input v-model="updateForm.stuid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="updateForm.name"/>
        </el-form-item>
        <el-form-item label="学号">
          <el-input v-model="updateForm.studentid"/>
        </el-form-item>
        <el-form-item label="性别">
          <el-radio-group v-model="updateForm.sex">
            <el-radio :label="0" size="large">男</el-radio>
            <el-radio :label="1" size="large">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="updateForm.password"/>
        </el-form-item>
        <el-form-item label="学院编号">
          <el-input v-model="updateForm.schoolid"/>
        </el-form-item>
        <el-form-item label="余额">
          <el-input v-model="updateForm.money"/>
        </el-form-item>
      </el-form>
    </template>
    <template #btnConfirm>
      <el-button type="primary" @click="updateEditForm">修改</el-button>
    </template>
  </Dialog>
</template>

<script setup>
import {Search} from "@element-plus/icons-vue"
import InformationSlot from "@/components/InformationSlot.vue"
//导入对话框组件
import Dialog from "@/components/Dialog.vue"
import {useUserStore} from "@/stores/user.js"
const userStore = useUserStore()

const dialogRef = ref(null)
const searchName = ref("")
import {Male, Female} from "@element-plus/icons-vue";
import {ref, onMounted, reactive} from 'vue'
import {request} from "@/api/request.js";

const student = reactive({
  pageInfo: {
    pageNum: 1,//当前页码值
    pageSize: 5, // 当前页要展示的数据条数
    total: 0 //总页码值
  },
  list: []
})
//多选按钮选中的数据
const studentSelectedList = ref([])
//修改表单对话框的数据
const updateForm = ref({})
const getStudentInfoList = async function () {
  const res = await request({
    url: `admin/getUsers/${student.pageInfo.pageNum}/${student.pageInfo.pageSize}`,
    method: 'get'
  })
  if (res.code === 100) {
    const {list, pageNum, pageSize, total} = res.extend.userList;
    student.list = list
    student.pageInfo.pageNum = pageNum
    student.pageInfo.pageSize = pageSize
    student.pageInfo.total = total
  }
}
//获取到选中的的某一项并保存到数组中
const handleSelectionChange = function (value) {
  studentSelectedList.value = value
}
//限制学生的处理函数
const limitStudent = async function (row) {
  const res = await request({
    method: 'put',
    url: "admin/limitUser/" + row.stuid
  })
  if (res.code === 100) {
    await getStudentInfoList()
    ElMessage.success(res.msg)
  } else {
    ElMessage.error(res.msg)
  }
}
//删除学生的处理函数
const delStudent = async function (row) {
  const res = await request({
    url: "admin/delUser/" + row.stuid,
    method: 'delete'
  })
  if (res.code === 100) {
    await getStudentInfoList()
    ElMessage.success(res.msg)
  } else {
    ElMessage.error(res.msg)
  }
}
//批量删除学生的处理函数
const bulkDelStudent = async function () {
  const nameList = [];
  const idList = [];
  studentSelectedList.value.forEach(item => {
    nameList.push(item.name)
    idList.push(item.stuid)
  })
  const newNameList = nameList.join(',');
  const newIdList = idList.join('-');
  try {
    const res = await ElMessageBox.confirm(
        `你确定要删除${newNameList}吗?`,
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
        url: "admin/delUsers/" + newIdList
      })
      if (res.code === 100) {
        await getStudentInfoList()
        ElNotification.success(res.msg)
      } else {
        ElNotification.error(res.msg)
      }
    }
  } catch (e) {
    return e
  }
}
//显示修改学生信息的对话框
const editStudent = async function (row) {
  dialogRef.value.openDialog("修改用户")
  const res = await request({
    method: 'get',
    url: "admin/getCurrentUser/" + row.studentid,
  })
  if (res.code === 100) {
    updateForm.value = res.extend.user;
  } else {
    ElMessage.error(res.msg)
  }
}
//修改信息
const updateEditForm = async function () {
  const res = await request({
    url: 'admin/updateUser',
    method: 'put',
    data: updateForm.value
  })
  if (res.code === 100) {
    await getStudentInfoList()
    ElNotification.success(res.msg)
    dialogRef.value.closeDialog()
  } else {
    ElNotification.error(res.msg)
  }
}
//条件查询
const queryStudent = async function () {
  if (searchName.value) {
    const res = await request({
      url:`admin/search/${student.pageInfo.pageNum}/${student.pageInfo.pageSize}`,
      method:'get',
      params:{
        name:searchName.value,
        schoolid:''
      }
    })
    if (res.code === 100) {
       const {list, pageNum, pageSize, total} = res.extend.users;
       student.list = list
       student.pageInfo.pageNum = pageNum
       student.pageInfo.pageSize = pageSize
       student.pageInfo.total = total
    }else {
      ElNotification.error(res.msg)
    }
  }
}
//更新页码值
const updatePage = function (pageInfo) {
  student.pageInfo = pageInfo.value
  getStudentInfoList()
}
onMounted(getStudentInfoList)
</script>
<style lang="less" scoped>
.el-input{
  width: 400px;
}
</style>
