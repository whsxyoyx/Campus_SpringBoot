<template>
  <el-row>
    <el-button type="success" @click="openAddAdmin">添加管理员</el-button>
  </el-row>
  <el-table :data="admin.list" v-loading="userStore.loading">
    <el-table-column prop="aid" label="管理员编号" align="center"/>
    <el-table-column prop="account" label="账户名" align="center"/>
    <el-table-column prop="name" label="姓名" align="center"/>
    <el-table-column prop="password" label="密码" align="center"/>
    <el-table-column label="添加时间" align="center">
      <template #default="scope">
        <el-icon>
          <Timer/>
        </el-icon>
        {{ new Date(scope.row.addtime).toLocaleString().replaceAll("/", "-") }}
      </template>
    </el-table-column>
    <el-table-column label="状态" align="center">
      <template #default="scope">
        <el-tag size="small" v-if="scope.row.state === 0">良好</el-tag>
        <el-tag size="small" type="danger" v-if="scope.row.state === 1">被限制了</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作" align="center">
      <template #default="scope">
        <el-button size="small" @click="editAdmin(scope.row.aid)">编辑</el-button>
        <el-button size="small" type="danger" @click="handleDelete(scope.row)">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
  <!--编辑管理员的对话框-->
  <Dialog ref="editDialogRef">
    <template #container>
      <el-form ref="editFormRef" :rules="editRules" :model="editForm" label-width="100px" @submit.native.prevent>
        <el-form-item label="管理员编号">
          <el-input v-model="editForm.aid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="账户名">
          <el-input v-model="editForm.account"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="editForm.name"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="editForm.password"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <template #default="scope">
            <el-switch v-model="editForm.state"
                       active-color="#13ce66"
                       inactive-color="#ff4949"
                       active-text="良好"
                       :active-value="0"
                       inactive-text="限制"
                       :inactive-value="1"></el-switch>
          </template>
        </el-form-item>
      </el-form>
    </template>
    <template #btnConfirm>
      <el-button type="primary" @click="confirmUpdate">修改</el-button>
    </template>
  </Dialog>
  <!--新增管理员的对话框-->
  <Dialog ref="addDialogRef">
    <template #container>
      <el-form ref="addFormRef" :model="addForm" label-width="100px" @submit.native.prevent>
        <el-form-item label="管理员账号">
          <el-input v-model="addForm.account"></el-input>
        </el-form-item>
        <el-form-item label="管理员姓名">
          <el-input v-model="addForm.name"></el-input>
        </el-form-item>
      </el-form>
    </template>
    <template #btnConfirm>
      <el-button type="primary" @click="doAdd">确认</el-button>
    </template>
  </Dialog>
</template>

<script setup>
import {useRouter} from "vue-router";
const router = useRouter()
import {onMounted, reactive, ref, watch} from "vue";
import {request} from "@/api/request.js";
import {Timer} from "@element-plus/icons-vue";
import Dialog from "@/components/Dialog.vue";
import {useUserStore} from "@/stores/user.js"
const userStore = useUserStore()
const oldPassword = ref("")
const currentPassword = ref("")
const editDialogRef = ref(null);
const addDialogRef = ref(null);
const editFormRef = ref(null)
const admin = reactive({
  list: [],
});
const editForm = ref({})
const addForm = ref({})
const editRules = reactive({
  password:[
    {
      required:true,
      message:'请输入密码',
      trigger:'blur'
    },
    {
      min:4,
      max:10,
      message:'密码长度在4-10之间',
      trigger:'blur'
    }
  ]
})
// 获取所有的管理员
const getAdminList = async function () {
  const res = await request({
    url: `admin/getAllAdmin`,
    method: "get",
  });
  if (res.code === 100) {
    admin.list = res.extend.adminList;
  }
};
// 删除管理员
const handleDelete = async function (row) {
  const res = await request({
    url: "admin/delAdmin/" + row.aid,
    method: "delete",
  });
  if (res.code === 100) {
    await getAdminList();
    ElNotification.success(res.msg);
  } else ElNotification.error(res.msg);
};
//打开编辑任务类型的对话框并进行数据的回显
const editAdmin = async function (id) {
  editDialogRef.value.openDialog("编辑管理员");
  const res = await request({
    url: "admin/getAdmin/" + id,
    method: 'get'
  })
  if (res.code === 100) {
    editForm.value = res.extend.admin
    oldPassword.value = editForm.value.password
  }
};
// 执行修改操作
const confirmUpdate = function () {
  editFormRef.value.validate(async valide => {
    if(!valide) return
    const res = await request({
      url: "admin/updateAdmin",
      method: "put",
      data: editForm.value
    });
    if (res.code === 100) {
      if (userStore.currentUsername === editForm.value.account && oldPassword.value !== currentPassword.value) {
        await router.push("/login");
        ElNotification.error("密码已被修改,请重新登录");
      } else {
        await getAdminList();
        editDialogRef.value.closeDialog();
        ElNotification.success(res.msg);
      }
    } else ElNotification.error(res.msg);
  })
}
//打开添加任务类型对话框
const openAddAdmin = function () {
  addDialogRef.value.openDialog("新增管理员");
};
//执行添加操作
const doAdd = async function () {
  const info = addForm.value
  if (info.account && info.name) {
    const res = await request({
      url: "admin/addAdmin",
      method: "post",
      data: addForm.value,
    });
    if (res.code === 100) {
      addDialogRef.value.closeDialog();
      await getAdminList();
      ElNotification.success(res.msg);
    } else {
      ElNotification.error(res.msg);
    }
  } else {
    ElNotification.error("账户名或姓名不能为空");
  }
}
watch(() =>editForm.value.password,function (newValue){
  currentPassword.value = newValue
})
onMounted(getAdminList);
</script>
<style lang="less" scoped></style>
