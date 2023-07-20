<template>
  <div>
    <el-card class="box-card">
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="任务标题" prop="taskname">
          <el-input v-model="ruleForm.taskname"></el-input>
        </el-form-item>
        <!--文件上传功能 -->
        <el-form-item label="图片">
          <el-upload
              class="upload-demo"
              ref="upload"
              action=""
              :auto-upload="false"
              :on-preview="handlePreview"
              :on-remove="handleRemove"
              :on-change="handleChange"
              :before-remove="beforeRemove"
              multiple
              :limit="6"
              :on-exceed="handleExceed"
              accept="image/png, image/jpeg"
              :file-list="fileList"
              list-type="picture-card">
            <el-button slot="trigger" size="small" type="primary">点击上传</el-button>
            <el-button size="small" type="primary" @click="submitUpload">上传到服务器</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件</div>
          </el-upload>
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>

        </el-form-item>
        <el-form-item label="任务描述" prop="taskcontext">
          <el-input maxlength="255" show-word-limit type="textarea" v-model="ruleForm.taskcontext"></el-input>
        </el-form-item>
        <el-form-item style="width: 100%" label="任务类型" prop="tasktype">
          <el-select v-model="ruleForm.tasktype">
            <el-option v-for="(item,index) in taskTypes" :key="index" :label="item.tasktype"
                       :value="item.tasktype"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="报酬" prop="reward">
          <el-select v-model="ruleForm.reward" placeholder="请选择报酬">
            <el-option label="0" value="0"></el-option>
            <el-option label="10" value="10"></el-option>
            <el-option label="20" value="20"></el-option>
            <el-option label="30" value="30"></el-option>
          </el-select>
          <span style="color: #42b983">花花币</span>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')">发布该任务</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>


  </div>

</template>
<script>
export default {
  data() {
    return {
      //图片预览
      dialogImageUrl: '',
      dialogVisible: false,

      //用于文件上传
      fileList: [],
      urls: [],
      //用于获取任务类型
      taskTypes: [{
        addtime: "",
        tasktype: ""
      }],
      user: {
        stuid: "",
        studentid: "",
        password: "",
        schoolid: "",
        sex: "",
        name: "",
        registertime: "",
        money: "",
        state: "",
        photo: "",
        schoolName: "",
      },
      //用于提交到服务器
      ruleForm: {
        taskid: "",
        publishUserId: "",
        publishUserName: "",
        publishSchoolId: "",
        acceptUserId: "",
        reward: "",
        addtime: "",
        endtime: "",
        taskname: "",
        taskcontext: "",
        state: "",
        img: "",
        tasktype: "",
      },
      //定义规则
      rules: {
        taskname: [
          {required: true, message: '请输入任务标题', trigger: 'blur'},
          {min: 2, max: 18, message: '长度在 2 到 18 个字符', trigger: 'blur'}
        ],
        taskcontext: [
          {required: true, message: '请填写任务描述信息', trigger: 'change'},
          {min: 2, max: 255, message: '长度在 2 到 255 个字符', trigger: 'blur'}
        ],
        tasktype: [
          {required: true, message: '请选择任务类型', trigger: 'change'}
        ],
        reward: [
          {required: true, message: '请选择报酬', trigger: 'change'}
        ],
      }
    };
  },
  mounted() {
    this.getAllTaskType()
    this.getCurrentUser()
    this.getCurrentUserInfo()
  },
  methods: {
    //上传服务器
    submitUpload() {
      this.fileList.forEach((file) => {
        console.log(file.raw)
      })
      console.log("----")
      //判断是否有文件再上传
      if (this.fileList.length === 0) {
        return this.$message.warning('请选取文件后再上传')
      }
      // 下面的代码将创建一个空的FormData对象:
      const formData = new FormData()
      // 你可以使用FormData.append来添加键/值对到表单里面；
      this.fileList.forEach((file) => {
        formData.append('file', file.raw)
      })
      //自定义的接口也可以用ajax或者自己封装的接口
      this.$http.post("file/upload", formData).then(res => {
        if (res.data.code === 100) {
          this.urls = res.data.extend.url;
          this.$message.success('上传成功');
        } else {
          this.$message.error('上传失败');
        }
        //清空fileList
        this.fileList = []
      })
    },
    // 文件状态改变时的钩子，添加文件、上传成功和上传失败时都会被调用,function(file, fileList)
    handleChange(file, fileList) {
      this.fileList = fileList
    },
    handleRemove(file, fileList) {
      console.log(file, fileList);
    },
    //图片预览
    handlePreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
      console.log(file);
    },
    handleExceed(files, fileList) {
      this.$message.warning(`当前限制选择 6 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
    },
    beforeRemove(file) {
      return this.$confirm(`确定移除 ${file.name}？`);
    },


    //发布任务
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          //this.submitUpload();
          console.log("文件urls", this.urls)
          for (let i = 0; i < this.urls.length; i++) {
            if (i < this.urls.length - 1) {
              this.ruleForm.img += (this.urls[i] + " ");
            } else {
              this.ruleForm.img += this.urls[i];
            }
          }
          console.log("img", this.ruleForm.img);

          console.log(this.ruleForm)
          this.$http.post("task/addTask", this.ruleForm).then((resp) => {
            if (resp.data.code === 100) {
              this.$router.push("/home/center")
              this.$message({
                type: 'success',
                message: resp.data.msg,
              });
              this.ruleForm = {}
            } else {
              this.$message({
                type: 'error',
                message: resp.data.msg,
              });
            }
          })
        } else {
          return false;
        }
      });
    },
    //查询所有任务类型
    getAllTaskType() {
      this.$http.get("task/getAllTaskType").then((resp) => {
        this.taskTypes = resp.data.extend.taskTypes;
      })

    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    getCurrentUser() {
      this.user.studentid = window.sessionStorage.getItem('currentUserId');
    },
    getCurrentUserInfo() {
      if (this.user.studentid !== '') {
        this.$http.get("user/getCurrentUser?studentid=" + this.user.studentid).then((resp) => {
          if (resp.data.code !== 100) {
          } else {
            this.user = resp.data.extend.user;
            this.user.schoolName = resp.data.extend.schoolName;
            this.ruleForm.publishSchoolId = this.user.schoolid
            this.ruleForm.publishUserName = this.user.name
            this.ruleForm.publishUserId = this.user.stuid
            this.ruleForm.state = 0
          }
        })
      } else {
        this.$message.error("出错啦!!!")
      }
    },

  }
}
</script>
<style lang="less" scoped>
.box-card {
  width: 650px;
}
</style>
