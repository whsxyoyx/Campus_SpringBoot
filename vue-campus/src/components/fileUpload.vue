<!--上传文件模板 -->
<template>
  <!--action：必传参数，上传的地址，类型为String
  headers：设置上传头部，类型为Object,一般为 Authorization: 'Bearer ' + Cookie.get('token'), 类型object
  multiple: 是否支持多选文件，true可以选多个，false只能选一个 类型boolean
  data：上传时的额外参数 类型object
  name: 上传的文件字段名字 类型string
  with-credentials: 支持发送 cookie 凭证信息,默认为true， 类型boolean
  show-file-list: 是否显示已上传文件列表,默认为true 类型boolean
  drag: 是否启用拖拽上传，默认为false             类型 boolean
  accept: 接收上传的文件类型，限制上传的文件格式，before-upload可以达到同样的效果 类型string
  on-preview：点击文件列表中已上传的文件时的钩子,就是点击已经上传文件列表触发的函数，比如点击已经上传的图片可以进行放大和删除 类型function(file)
  on-remove: 文件移除时的钩子，相当于我把文件点叉了，触发的函数 类型function(file, fileList)
  on-success：文件上传成功时的钩子，比如可以弹出上传成功，在一些文件列表新增中也可以做一些处理 类型function(response, file, fileList)
  on-error：文件上传失败出发的钩子 类型function(err, file, fileList)
  on-progress： 文件上传时的钩子，可以理解为文件上传触发的函数 类型function(event, file, fileList)
  on-change: 文件状态改变时的钩子，添加文件、上传成功和上传失败时都会被调用 类型function(file, fileList)
  before-upload: 上传文件之前的钩子，参数为上传的文件，若返回 false 或者返回 Promise 且被 reject，则停止上传,同accept，可以做一些文件上传的限制，比如后缀名是不是为png/jpg之类的 类型 function(file)
  before-remove：删除文件之前的钩子，参数为上传的文件和文件列表，若返回 false 或者返回 Promise 且被 reject，则停止删除，优先级在on-remove之前 function(file, fileList)
  list-type:文件列表上传的类型，比如我类型为picture-card或者text，可选列表text/picture/picture-card，默认为text 类型string
  auto-upload: 是否在选取文件后立即进行上传，默认为true 类型boolean
  file-list: 上传的文件列表，默认为[] 数组形式  类型：array
  http-request 覆盖默认的上传行为，可以自定义上传的实现,一些特殊需求可以用到 类型function
  disabled: 是否禁用 默认为flase 类型boolean
  limit: 最大允许上传个数 number类型 	类型number
  on-exceed：文件超出个数限制时的钩子 类型function(files, fileList)
  -->
  <div>
    <el-upload
        :action="action"
        :headers="headers"
        :multiple="multiple"
        :data="parameterData"
        name="file"
        with-credentials="ture"
        show-file-list="true"
        drag="false"
        :accept="accept"
        :on-preview="handlePictureCardPreview"
        :on-remove="handleFileRemove"
        :on-success="handleFileSuccess"
        :on-error="handleUploadError"
        :on-progress="handleFileUploadProgress"
        :on-change="handleFileUploadChange"
        :before-upload="beforeAvatarUpload"
        :before-remove="beforeRemoveUpload"
        list-type="text"
        auto-upload="true"
        :file-list="fileList"
        :http-request="httpRequestUpload"
        :disabled="isUploading"
        :limit="limit"
        :on-exceed="onExceedUpload"
        ref="upload"
    >
      <!--简介式上传文件 -->
      <el-button size="small" icon="el-icon-upload2">点击上传文件</el-button>
      <!--上传图片 -->
      <!-- <i class="el-icon-plus"></i> -->
      <!--solt
          trigger	触发文件选择框的内容,需要时候使用
          tip	提示说明文字，用的较多，在solt标签中写出提示的文字即可
      -->
      <div style="color: #999999; font-size: 12px; margin-top: 4px;" slot="tip">
        <slot>
          <!-- 提示的文字 -->
        </slot>
      </div>
    </el-upload>
    <!--图片放大的dialog -->
    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt />
    </el-dialog>
  </div>
</template>

<script>
import Cookie from 'js-cookie'
export default {
  props: {
    action: '/upload',
    multiple: false,
    files: {
      type: Array,
      default: () => [],
    },
    accept: {
      type: String,
      default: '',
    },
    limit: {
      type: Number,
      default: 2,
    },
    parameterData: '',
  },
  data: function () {
    return {
      dialogImageUrl: '',
      fileList: [],
      /**
       * 设置上传的请求头部
       */
      headers: {
        Authorization: 'Bearer ' + Cookie.get('token'),
      },
      /**
       * 是否禁用上传
       */
      isUploading: false,
    }
  },
  watch: {
    files: {
      handler(value) {
        this.fileList = value
      },
      immediate: true,
    },
  },
  methods: {
    /**
     * 点击文件列表中已上传的文件时的钩子
     */
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    /**
     * 文件移除时触发的函数
     */
    handleFileRemove(file, fileList) {
      this.handleEmitFilesChange(fileList)
    },
    /**
     * 文件上传成功出发的函数
     */
    handleFileSuccess(response, file, fileList) {
      this.isUploading = false
      // this.msgSuccess("上传成功");
      // this.$alert(response.msg, '导入结果', { dangerouslyUseHTMLString: true })
      this.handleEmitFilesChange(fileList)
    },
    /**
     * 文件上传失败触发的函数
     */
    handleUploadError() {
      this.$message({
        type: 'error',
        message: '上传失败',
      })
      this.loading.close()
    },
    /**
     * 文件上传时触发的函数
     */
    handleFileUploadProgress(event, file, fileList) {
      this.isUploading = true
    },

    /**
     * 文件状态改变时触发的函数
     */
    handleFileUploadChange(file, fileList) {},
    // 限制图片上传大小
    beforeAvatarUpload(file) {
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isLt2M) {
        this.$message.error('上传图片大小不能超过 2MB!')
        return false
      }

      // 判断图片类型来筛选图片格式上传
      let _type = file.type
      if (
          _type.indexOf('png') == -1 &&
          _type.indexOf('jpg') == -1 &&
          _type.indexOf('jpeg') == -1
      ) {
        this.$message.error('上传图片格式不正确，请重新上传!')
        return false
      }
      return
    },
    /**
     * 删除文件时触发的函数，若返回 false 或者返回 Promise 且被 reject,停止删除
     */
    beforeRemoveUpload(file, fileList) {},
    /**
     * 覆盖默认的上传行为，可以自定义上传的实现
     */
    httpRequestUpload() {
      console.log('覆盖上传')
    },
    /**
     * 文件超出个数限制时触发的函数
     */
    onExceedUpload(files, fileList) {
      this.$alert('文件数量超出限制', '上传结果', {
        dangerouslyUseHTMLString: true,
      })
    },

    handleEmitFilesChange(fileList = []) {
      const files = fileList.map((i) => i.response.fileName)
      this.$emit('file-list-change', { files })
    },
    /**
     clearFiles	清空已上传的文件列表（该方法不支持在 before-upload 中调用）	— 比如点击重新上传的时候
     abort	取消上传请求	（ file: fileList 中的 file 对象 ）
     submit	手动上传文件列表
     */
    _clearFiles() {
      this.$refs.upload.clearFiles()
    },
    _submit() {
      this.$refs.upload.submit()
    },
  },
}
</script>
