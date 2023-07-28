<template>
  <el-dialog v-model="dialogVisible" :title="dialogTitle" width="40%" draggable>
    <slot name="container">中部内容区</slot>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <slot name="btnConfirm">确认按钮区域</slot>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import {ref,defineExpose,watch} from "vue";
const dialogVisible = ref(false)
const dialogTitle = ref("")
//打开对话框的函数
const openDialog = function (title="温馨提示"){
  dialogTitle.value = title
  dialogVisible.value = true
}
// 关闭对话框的函数
const closeDialog = function (){
  dialogVisible.value = false
}
// 对外暴露打开对话框的函数
defineExpose({
  openDialog,
  closeDialog
})
</script>

<style scoped>

</style>
