<template>
  <!--头部添加按钮区域-->
  <el-row>
    <el-col :span="24">
      <el-button type="success" plain @click="addSchool">添加学校</el-button>
    </el-col>
  </el-row>
  <!--中部表格区域-->
  <el-row>
    <el-col :span="24">
      <el-table :data="school.infoList" stripe v-loading="userStore.loading">
        <el-table-column prop="schoolid" label="学校id" align="center"/>
        <el-table-column prop="name" label="学校名称" align="center"/>
        <el-table-column label="添加时间" align="center">
          <template #default="scope">
            {{ new Date(scope.row.addtime).toLocaleString().replaceAll("/", "-") }}
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center">
          <template #default="{row}">
            <el-tag v-if="row.state === 0" type="success" effect="dark" round>良好</el-tag>
            <el-tag v-else-if="row.state === 1" type="danger" effect="dark" round>被限制</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" fixed="right" width="300" align="center">
          <template #default="{row}">
            <el-button type="primary" size="small" @click="showUpdateDialog(row)">
              <el-icon>
                <Edit/>
              </el-icon>
            </el-button>
            <el-button type="danger" size="small" @click="removeSchool(row.schoolid)">
              <el-icon>
                <Delete/>
              </el-icon>
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-col>
  </el-row>
  <!--  底部分页区域-->
  <Pagination @updatePage = 'updateInfo'/>
  <SchoolDialog ref="dialogRef" @success="onSuccess"/>
</template>

<script setup>
import {onMounted, reactive,ref} from "vue";
import {request} from "@/api/request.js";
import {Edit, Delete} from "@element-plus/icons-vue";
import SchoolDialog from "@/views/college/components/SchoolDialog.vue"
import Pagination from "@/components/Pagination.vue"
import {useUserStore} from "@/stores/user.js"
const userStore = useUserStore()
//学校的分页信息及学校信息
const school = reactive({
  //分页信息
  pageInfo: {
    pageNum: 1,//当前页码值
    pageSize: 5, // 当前页要展示的数据条数
    total: 0 //总页码值
  },
  // 学校列表信息
  infoList: []
})
// 修改学校信息的form表单对象
const dialogRef = ref(null);
//获取学校列表信息
const getSchoolList = async function () {
  const res = await request({
    url: `admin/getAllSchool/${school.pageInfo.pageNum}/${school.pageInfo.pageSize}`,
    method: 'get'
  })
  if (res.code === 100) {
    const {total, pageNum, pageSize, list} = res.extend.schoolList;
    school.pageInfo.total = total
    school.pageInfo.pageNum = pageNum
    school.pageInfo.pageSize = pageSize
    school.infoList = list
  } else {
    ElMessage.error(res.msg)
  }
}
const updateInfo = function (pageInfo){
  school.pageInfo = pageInfo
  getSchoolList()
}
// 删除学校
const removeSchool = function (id) {
  ElMessageBox.confirm(
      '此操作将永久删除该学学校,是否继续?',
      '警告!',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    //如果用户点击了确认,就发送网络请求执行删除操作
    const res = await request({
      url:`admin/delSchool/${id}`,
      method:'delete'
    })
    if(res.code === 100){
      ElMessage.success(res.msg)
      await getSchoolList()
    }
  },() =>{
    ElMessage({
      type: 'info',
      message: '已取消删除',
    })
  })
}
//修改学校信息
// 一、获取学校信息
const showUpdateDialog = function (row){
  dialogRef.value.openDialog(row)
}
//添加学校信息
const addSchool = function (){
  dialogRef.value.openDialog({})
}
const onSuccess = function (){
  getSchoolList()
}
onMounted(getSchoolList)
</script>
<style lang="less" scoped>
</style>
