<template>
  <el-dialog v-model="dialogFormVisible" :title="schoolInfoList.schoolid ? '修改学校信息' : '添加学校'" width="600" center align-center draggable>
    <el-form :model="schoolInfoList" :rules="rules" ref="dialogFormRef" label-position="left" @submit.native.prevent>
      <el-form-item label="学校id" label-width="100" v-if="schoolInfoList.schoolid">
        <el-input v-model="schoolInfoList.schoolid" disabled/>
      </el-form-item>
      <el-form-item label="学校名称" label-width="100" prop="name">
        <el-input v-model="schoolInfoList.name" placeholder="请输入学校名称">
        </el-input>
      </el-form-item>
      <el-form-item label="学校状态" label-width="70" v-if="schoolInfoList.schoolid">
        <el-switch
            v-model="schoolInfoList.state"
            inline-prompt
            active-text="正常"
            :active-value="0"
            active-color="#13ce66"
            inactive-text="限制"
            inactive-color="#ff4949"
            :inactive-value="1"
        />
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" @click="changeSchoolInfo" >
          <span v-if="schoolInfoList.schoolid">修改</span>
          <span v-else>添加</span>
        </el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import {ref,watch} from "vue";
import {request} from "@/api/request.js";
//控制学校对话框的显示与隐藏
let dialogFormVisible = ref(false)
// 获取对话框里面的form表单对象
const dialogFormRef = ref()
//表单的验证规则
const rules = {
  name:[
    {
      required:true,
      message:'学校名称不能为空!',
      trigger:'blur'
    }
  ]
}
//学校列表信息
const schoolInfoList = ref({})
// 1、封装一个函数
const openDialog = function (schoolInfo) {
  schoolInfoList.value = {
    ...schoolInfo
  }
  dialogFormVisible.value = true
}
//修改或新增学校信息的函数
const changeSchoolInfo = function (){
  dialogFormRef.value.validate(async valid =>{
    if(!valid) return;
    if(schoolInfoList.value.schoolid){
      //修改用户信息
      const res = await request({
        url:'admin/updateSchool',
        method:'put',
        data:schoolInfoList.value
      })
      if(res.code === 100){
        ElMessage.success(res.msg)
        dialogFormVisible.value = false //关闭对话框
        // 通知父组件重新渲染页面
        emit('success')
      }else {
        ElMessage.error(res.msg)
      }
    }else {
      // 新增用户信息
      const res = await request({
        url:'admin/addSchool',
        method:'post',
        data:{
          name:schoolInfoList.value.name
        }
      })
      if(res.code === 100){
        console.log(res);
        ElMessage.success(res.msg)
        dialogFormVisible.value = false //关闭对话框
        // 通知父组件重新渲染页面
        emit('success')
      }else {
        ElMessage.error(res.msg)
      }
    }
  })
}
watch(dialogFormVisible,function (dialogFormVisibleNewValue){
//监听修改学校信息对话框的值,如果值为false,那么久清空对话框
  if(!dialogFormVisibleNewValue){
    dialogFormRef.value.resetFields();
  }
})
// 对外暴露函数
defineExpose({
  openDialog
})
</script>

<style scoped>

</style>
