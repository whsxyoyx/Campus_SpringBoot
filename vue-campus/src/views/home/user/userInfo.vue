<template>
  <div id="userinfo">
    <el-row :gutter="20" style="margin-top:10px;">
      <el-col :span="14">
        <div class="grid-content bg-purple">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span><h3>学生信息管理</h3></span>
            </div>
            <div class="block">
              <el-row>
                <el-col :span="4" :offset="10">
                    <div class="demo-image__preview">
                      <el-image v-if="user.photo" :src="user.photo"
                                width="100%"  :fit="fit"
                                :preview-src-list="srcList"
                                @click="vbs(user.photo)"
                                class="demonstration"></el-image>
                    </div>
                </el-col>

              </el-row>
            </div>
            <el-descriptions   :column="4"  border>
              <template slot="extra">
<!--                <el-button type="primary" @click="dialogVisible =true" size="small">修改头像</el-button>-->
                <el-button type="primary" @click="dialogVisibleEdit =true" size="small">修改个人信息</el-button>
              </template>
              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-user"></i>
                  用户名
                </template>
                {{user.name}}
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label">
                  <i ></i>
                  学号
                </template>
               {{user.studentid}}
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label">
                  <i ></i>
                  性别
                </template>
               <span v-if="user.sex==0"> 男</span><span v-else> 女</span>
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label">
                  状态
                </template>
                <el-tag size="small" type="success" v-if="user.state==0">良好</el-tag>
                <el-tag size="small" type="danger" v-else>被限制</el-tag>
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-school"></i>
                  学院
                </template>
                {{user.schoolName}}
              </el-descriptions-item>

              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-money"></i>
                  余额
                </template>
                {{user.money}} <span style="color: #42b983">花花币</span>
              </el-descriptions-item>
            </el-descriptions>
          </el-card>
        </div>
      </el-col>


    </el-row>

<!--   修改头像 -->
    <el-dialog
      title="修改头像"
      :visible.sync="dialogVisible"
      width="30%">
      <el-row :gutter="20">
        <el-col :span="12">
          <div><h4>原来的图片</h4></div>
          <el-image style="margin-top: 10px"  :src="user.photo"
                     width="100%"  fit="scale-down"
                     :preview-src-list="srcList"
                     @click="vbs(user.photo)"
                     class="demonstration"></el-image>
        </el-col>
        <el-col :span="12">
          <div><h4>修改后的图片</h4></div>
          <el-upload
            style="margin-top: 10px"
            class="avatar-uploader"
            action="#"
            :show-file-list="false"
            :auto-upload="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            <img v-if="imageUrl" :src="imageUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-col>
      </el-row>


      <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>
<!--修改个人信息    -->
    <el-dialog
      title="修改个人信息"
      :visible.sync="dialogVisibleEdit"
      width="30%">
      <el-form :model="editUserinfo" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="学号" prop="studentid">
          <el-input v-model="editUserinfo.studentid" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="editUserinfo.name"></el-input>
        </el-form-item>
        <el-form-item label="性别" v-model="editUserinfo.sex" prop="sex">
          <el-tag type="success"><span v-if="editUserinfo.sex==0"> 男</span><span v-else> 女</span></el-tag>

        </el-form-item>
        <el-form-item label="学院" prop="schoolName">
          <el-input v-model="editUserinfo.schoolName" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-button @click="dialogVisibleEdit = false">取消</el-button>
          <el-button type="primary" @click="doEditUser('ruleForm')" native-type="submit">编辑</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data(){
    return{
      imageUrl: '',
      dialogVisibleEdit: false,
      dialogVisible: false,
      fit:"contain",
      circleUrl: "http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg",
      srcList: [],
      editUserinfo:{
        stuid:0,
        studentid:"",
        schoolName:"",
        name:"",
        sex:"",
      },
      user:{
        stuid:"",
        studentid:"",
        password:"",
        schoolid:"",
        sex:"",
        name:"",
        registertime:"",
        money:"",
        state:"",
        photo:"",
        schoolName:"",
      },
      stuId:"",
      rules: {
        name: [
          { required: true, message: '请输入名字', trigger: 'blur' },
          { min: 2, max: 6, message: '长度在 2 到 6 个字符', trigger: 'blur' }
        ],
      }
    }
  },

  mounted(){
      this.getCurrentUser()
      this.getCurrentUserInfo()

  },methods:{
    getCurrentUser(){
        this.stuId=window.sessionStorage.getItem("currentUserId");
    },
    getCurrentUserInfo(){
      this.$http.get("user/getCurrentUser?studentid="+this.stuId).then((resp)=>{
          if (resp.data.code!=100){
            console.log(resp.data.msg)
          }else{
            this.user = resp.data.extend.user;
            this.user.schoolName = resp.data.extend.schoolName;
            this.editUserinfo.studentid =this.user.studentid;
            this.editUserinfo.stuid =this.user.stuid;
            this.editUserinfo.name =this.user.name;
            this.editUserinfo.sex =this.user.sex;
            this.editUserinfo.schoolName =this.user.schoolName;
          }

        })
    },
    vbs(val) {
      this.srcList = []
      this.srcList.push(val)
    },
    doEditUser(formName){
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log(this.editUserinfo)
          this.$http.put("user/updateUserInfo",this.editUserinfo).then((resp)=>{
            if (resp.data.code===100){
              //立即刷新页面
              this.$router.go(0)
              this.dialogVisibleEdit=false,
              this.$message({
                type: 'success',
                message: resp.data.msg,
              });
            }else{
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


    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    }
  }
}
</script>

<style lang="less" scoped>


.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}


.photoLocation{
  padding-top: 40px;
  margin-left: 0px;

}
/*卡片样式*/
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

.box-card {
  width: 100%;
}
.grid-content{
  width: 800px;
}
/*文本样式区*/
.name-role {
  font-size: 16px;
  padding: 5px;
  text-align:center;
}
.sender{
  text-align:center;
}
.registe-info{
  text-align: center;
  padding-top:10px;
}
.personal-relation {
  font-size: 16px;
  padding: 0px 5px 15px;
  margin-right: 1px;
  width: 100%
}

.relation-item {
  padding: 12px;

}
.dialog-footer{
  padding-top:10px ;
  padding-left: 10%;
}
/*//布局样式区*/
.el-row {
  margin-bottom: 20px;
  &:last-child {
    margin-bottom: 0;
  }
}
.el-col {
  border-radius: 4px;
}
.bg-purple-dark {
  background: #99a9bf;
}
.bg-purple {
  background: #d3dce6;
}
.bg-purple-light {
  background: #e5e9f2;
}
.grid-content {
  border-radius: 4px;
  min-height: 36px;
}
.row-bg {
  padding: 10px 0;
  background-color: #f9fafc;
}
</style>
