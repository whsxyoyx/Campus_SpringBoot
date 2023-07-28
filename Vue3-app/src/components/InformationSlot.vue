<template>
  <el-row>
    <el-col :span="8">
      <slot name="delBtn">批量删除按钮区域</slot>
    </el-col>
    <el-col :span="16">
      <slot name="queryUser">头部搜索区域</slot>
    </el-col>
  </el-row>
  <el-row>
    <slot name="content">中部内容区</slot>
  </el-row>
  <!--  底部分页区域-->
  <Pagination @updatePage="updatePage"/>
</template>

<script setup>
import Pagination from "@/components/Pagination.vue"
import {defineEmits} from "vue"
const emit = defineEmits(['updatePage'])
const updatePage = function (pageInfo){
  emit('updatePage',pageInfo)
}
</script>

<style scoped>
</style>
