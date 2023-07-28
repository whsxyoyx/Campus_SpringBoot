<template>
  <el-row>
    <el-col :span="24">
      <el-pagination
          background
          v-model:current-page="pageInfo.pageNum"
          v-model:page-size="pageInfo.pageSize"
          :page-sizes="[5, 10, 15, 20]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pageInfo.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
    </el-col>
  </el-row>
</template>

<script setup>
import {ref,defineEmits,onMounted} from "vue";
const emit = defineEmits(['updateSchool'])
const pageInfo = ref({
  pageNum:1,
  pageSize:5,
  total:0
})
// 当用户切换当前页展示多少条数据时,得到当前页要展示的最新条数
const handleSizeChange = function (newSize){
  pageInfo.value.pageSize = newSize
  emit('updatePage',pageInfo)
}
// 当用户点击要展示第几页时,得到最新的页码值
const handleCurrentChange = function (newNum){
  pageInfo.value.pageNum = newNum
  emit('updatePage',pageInfo)
}
onMounted(function (){
  emit('updatePage',pageInfo)
})
</script>

<style scoped>
  .el-row{
    margin-top: 20px;
  }
</style>
