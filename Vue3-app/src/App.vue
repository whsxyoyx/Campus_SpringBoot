<template>
  <el-config-provider :locale="locale">
    <router-view></router-view>
  </el-config-provider>
</template>
<script setup>
import {zhCn} from "element-plus/es/locale/index";
const locale = zhCn// 插件语言改为中文
</script>
