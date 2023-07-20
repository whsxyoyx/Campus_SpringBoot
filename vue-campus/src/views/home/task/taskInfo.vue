<template>
  <div class="info">
    <el-card class="box-card">
      <div>
        <el-link @click="$router.back()" type="primary"> &lt;返回 </el-link>
        <el-tag style="float: right">任务奖励：{{taskLists.reward}} <span style="color: #42b983">花花币</span></el-tag>
        <el-row>
          <el-col style="text-align: center" :span="14" :offset="6">
            <span style="font-size: 25px; text-align: center;margin-top: 0px">
          <span style="color: #42b983">标题：</span>{{taskLists.taskname}}&nbsp;&nbsp;&nbsp;&nbsp;
          <el-tag type="success">
            {{taskLists.tasktype}}
          </el-tag>
          </span>
          </el-col>
          <!--          <el-avatar :size="50" :src="require('@/assets/imgs/'+publicUserInfo.photo)"></el-avatar>-->

          <el-popover
              placement="top-start"
              title="发布者信息"
              width="200"
              trigger="hover"
          >
            <!--头部头像-->
            <!--          <el-avatar v-if="user.photo==null" :size="45" fit="fill" :src="circleUrl" slot="reference"></el-avatar>
                      <el-avatar v-else :size="45" fit="fill" :src="require('@/assets/imgs/'+user.photo)" slot="reference"></el-avatar>-->
            <el-avatar  :size="45" fit="fill" :src="publicUserInfo.photo" slot="reference"></el-avatar>
            <div class="grid-content bg-purple">
              <div class="block">
                <el-row>
                  <el-col :span="4" :offset="10">
                    <!--                    <el-avatar v-if="user.photo==null" :size="45" :fit="fit" :src="circleUrl"></el-avatar>
                                        <el-avatar v-else :size="45" :fit="fit" :src="require('@/assets/imgs/'+user.photo)"></el-avatar>-->
                    <el-avatar v-if="user.photo" :size="45" fit="fill" :src="publicUserInfo.photo"></el-avatar>
                  </el-col>
                </el-row>
              </div>
              <div>
                <span>学号：{{publicUserInfo.studentid}} </span>
              </div>
              <div>
                <span>姓名：{{publicUserInfo.name}} </span>
              </div>
              <div >
                <span>性别:&nbsp; <span v-if="user.sex===0"> 男</span><span v-else> 女</span></span>
              </div>
              <div>
                <span>学校：{{publicUserInfo.schoolName}} </span>
              </div>
              <div>
                <span>状态:&nbsp;
                  <el-tag size="medium" type="success" v-if="publicUserInfo.state===0">良好</el-tag>
                  <el-tag size="medium" type="danger" v-else>被限制</el-tag>
                </span>
              </div>
            </div>
          </el-popover>



        </el-row>
        <el-divider></el-divider>
        <span style="font-size: 15px">{{taskLists.taskcontext}}</span>

        <!-- 显示用户上传的图片-->
        <div class="demo-image__placeholder">
          <div style="text-align:center;">

            <div v-for="img in images">
              <el-image v-if="img.length>10" style="width: 90%;height: 90%" :src="img" lazy></el-image>
              <!--              <el-button v-else type="primary">YYYYYYY</el-button>-->
            </div>
          </div>
        </div>
        <el-divider></el-divider>
        <div style="text-align: right ">
          <el-button  type="primary" @click="acceptTask" round :disabled="disabled">接受该任务</el-button>
        </div>

      </div>
    </el-card>


    <!-- 评论模块   -->
    <el-card class="box-card" style="margin-top: 20px">
      <span>评论</span>
      <div style="margin: 10px 50px 0px 50px;">
        <el-input
            @keyup.enter.native="submitComment"
            type="textarea"
            maxlength="255" show-word-limit
            :autosize="{ minRows: 2, maxRows: 4}"
            placeholder="请写下你的评论"
            v-model="comment.content">
        </el-input>
        <div style="margin-top: 5px;text-align: right">

          <el-button type="primary" @click="submitComment" plain>提交</el-button>
        </div>
      </div>
    </el-card>

    <el-card class="box-card">

      <span>评论列表</span>

      <div style="margin: 10px 50px 10px 50px;">
        <div style="margin: 20px 0;text-align: left;">
          <!--         遍历评论列表-->
          <div style="padding: 10px 0;" v-for="item in comments" :key="item.comment">
            <div style="display: flex">
              <div style="width: 60px">  <el-avatar :size="40" :fit="fit" :src="item.img"></el-avatar></div>
              <div style="flex: 1">
                <div v-if="publicUserInfo.name===item.username" style="color: #42b983">{{item.username}}<span style="color: red"> up</span></div>
                <div v-else style="color: #42b983">{{item.username}}</div>
                <div  style="font-size: 2px;color: #666"> {{item.createtime | dateFormat}}</div>
                <div style="margin: 10px 0px 0px 30px;color: salmon">{{item.content}}</div>

                <!-- 评论多级回复按钮          -->
                <div>
                  <el-button type="text" @click="reply(item.commonId,item.username)">回复</el-button>
                </div>
                <div style="background-color: aliceblue">
                <!--       回复列表           -->
                    <div v-for="reply in item.children" :key="reply.id">
                      <div style="display: flex;padding: 10px;">
                        <div style="width: 60px;margin: 0px 5px 10px 0px">
                          <el-avatar :size="40" :src="reply.img"></el-avatar></div>
                        <div style="flex: 1">
<!--                <div v-if="publicUserInfo.name===item.username" style="color: #42b983">{{item.username}}<span style="color: red"> up</span></div>
                          -->
                          <div  v-if="publicUserInfo.name===reply.userName">{{reply.userName}}<span style="color: red"> up</span><span> 回复 </span><span style="color: #42b983">@{{item.username}}</span></div>
                          <div  v-else-if="publicUserInfo.name===item.username">{{reply.userName}}<span> 回复 </span><span style="color: #42b983">@{{item.username}}<span style="color: red"> up</span></span></div>
                          <div  v-else>{{reply.userName}}<span> 回复 </span><span style="color: #42b983">@{{item.username}}</span></div>
                          <div  style="font-size: 2px;color: #666"> {{reply.createtime | dateFormat}}</div>
                           <div style="margin:10px  10px;color: salmon">{{reply.content}}</div>
                       </div>
                      </div>
                    </div>
                </div>
              </div>
            </div>
            <el-divider></el-divider>
          </div>

        </div>
      </div>
    </el-card>
    <el-dialog title="回复" :visible.sync="dialogTableVisible">
      <el-form :model="replyComment">
        <el-form-item label="内容" >
          <el-input   type="textarea"
                      @keyup.enter.native="replySubmit"
                      maxlength="255" show-word-limit
                      :autosize="{ minRows: 2, maxRows: 4}"
                      placeholder="请写下你的评论"
                      v-model="replyComment.content"
                      autocomplete="off">

          </el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogTableVisible = false">取 消</el-button>
        <el-button type="primary" @click="replySubmit">确 定</el-button>
      </div>
    </el-dialog>

  </div>

</template>

<script>
import bus from "../../../router/eventBus";
import axios from "axios";
export default {
  name: "taskInfo",
  data(){
    return {
      fit:'contain',

      //回复评论对话框
      dialogTableVisible:false,
      //该任务中的所有评论信息
      comments:[],
      //回复评论
      replyComment:{
        taskId:0,
        content:'',
        username:'',
        replyId:0,

      },
      //写评论
      comment:{
        parentCommentId:-1,
        userId:0,
        userName:'',
        content:'',
        taskId:0,
      },
      //是否展示接受任务按钮
      disabled: false,
      //当前任务详情页面显示的图片
      images:[],
      //任务信息
      taskLists: {
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
        //img:require("@/assets/imgs/0.jpg"),
        img: "",
        taskType: "",
      },
      //发布者信息
      publicUserInfo:{
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
      //接受者或当前登录的用户信息
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
    }
  },
  created() {
    this.getCurrentUser()
    this.getTaskInfo()
    this.getCurrentUserInfo()
    this.getPublicUserInfo()
    this.getImages()
    this.loadComment()
  },

  methods:{

    /*------------------二级回复功能暂未实现start--------------------------*/

    //二级提交回复内容
    twoLevelReplySubmit(){
      this.$http.post("replyComment/saveReply",this.replyComment).then((resp)=>{
        if (resp.data.code===100){
          this.dialogTableVisible  = false;
          this.loadComment();
          this.$message.success("评论成功")
          this.replyComment={};
        }else{
          this.$message({
            type: 'error',
            message:"评论失败",
          });
        }
      })
    },
    //二级回复按钮触发
    twoLevelReply(parentCommentId,target){
      this.dialogTableVisible=true;
      this.replyComment.replyId=parentCommentId;
      this.replyComment.userName=this.user.name;
      this.replyComment.taskId=this.taskLists.taskid;
      this.replyComment.img=this.user.photo;

    },
    /*------------------end--------------------------*/

    /*------------------一级回复功能start--------------------------*/
    //一级回复按钮触发
    reply(parentCommentId,target) {
      this.dialogTableVisible = true;
      this.replyComment.replyId = parentCommentId;
      this.replyComment.userName = this.user.name;
      this.replyComment.taskId = this.taskLists.taskid;
      this.replyComment.img = this.user.photo;
    },

    //一级提交回复内容
    replySubmit(){
      this.$http.post("comment/saveReply",this.replyComment).then((resp)=>{
        if (resp.data.code===100){
          this.dialogTableVisible  = false;
          this.loadComment();
          this.$message.success("评论成功")
          this.replyComment={};
        }else{
          this.$message({
            type: 'error',
            message:"评论失败",
          });
        }
      })
    },

    /*------------------end--------------------------*/

    //加载该任务所有评论
    loadComment(){
      //alert(this.taskLists.taskid)
      this.$http.get("comment/getComment/"+this.taskLists.taskid).then((resp)=>{
        if (resp.data.code===100){
          console.log("当前任务评论json数据：",resp.data.extend.comments);
          this.comments=resp.data.extend.comments;
        }else{
          this.$message({
            type: 'error',
            message:"加载评论失败",
          });
        }
      })
    },
    //一级评论功能
    submitComment(){
      this.comment.userId=this.user.stuid;
      this.comment.username=this.user.name;
      this.comment.img=this.user.photo;
      this.comment.taskId=this.taskLists.taskid;
      this.$http.post("comment/save",this.comment).then((resp)=>{
         if (resp.data.code===100){
           this.$message.success("评论成功")
           this.loadComment();
           this.comment={};
         }else{
           this.$message({
             type: 'error',
             message:"评论失败",
           });
         }
       })

    },
    //获取当前任务页图片
    getImages(){
      this.$http.get("task/getImagesByTid/"+this.taskLists.taskid).then((resp)=>{
        this.images = resp.data.extend.imgs;
        console.log("----图片>>>>>>>>",this.images[0])
      })
    },



    //接受从index.vue页面传过来的任务信息
    getTaskInfo(){
      if (this.$route.query.taskInfo){
        let info = decodeURIComponent(this.$route.query.taskInfo);
        this.taskLists= JSON.parse(info);
        console.log("---",this.taskLists);
        if(this.taskLists.reward===0){
          this.disabled=true;
        }
      }
    },
    getPublicUserInfo(){
      this.$http.get("user/getCurrentUser/"+this.taskLists.publishUserId).then((resp)=>{
        this.publicUserInfo=resp.data.extend.publicUser
        this.publicUserInfo.schoolName = resp.data.extend.schoolName;
      })
    },
    getCurrentUser(){
      this.user.studentid = window.sessionStorage.getItem('currentUserId');
      console.log("this.user.studentid",this.user.studentid)
    },
    getCurrentUserInfo(){
      if (this.user.studentid!==''){
        this.$http.get("user/getCurrentUser?studentid="+this.user.studentid).then((resp)=>{
          if (resp.data.code!==100){
            console.log(resp.data.msg)
          }else{
            this.user = resp.data.extend.user;
            this.user.schoolName = resp.data.extend.schoolName;
          }
        })
      }else{
        this.$message.error("出错啦!!!")
      }

    },
    //接受任务
    acceptTask(){
      console.log(this.taskLists)
      this.$http.put("task/taskAccept",
          {aId: this.user.stuid,taskId: this.taskLists.taskid}
      ).then((resp)=>{
        if (resp.data.code!==100){
          this.$message({
            type: 'error',
            message: resp.data.msg,
          });
        }else{
          this.disabled=true;
          this.getTaskInfo();
          this.$message({
            type: 'success',
            message: resp.data.msg,
          });
        }
      })
    },


  }
}
</script>

<style scoped>
.info{
  width: 100%;
}
.demo-image__placeholder{
  margin-top: 20px;
}
.box-card{
  width: 70%;
}
</style>
