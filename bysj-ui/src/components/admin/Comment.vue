<template>
<div>
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>学生答疑</el-breadcrumb-item>
      <el-breadcrumb-item>学生留言</el-breadcrumb-item>
    </el-breadcrumb>
  <div style="width: 1000px; margin: 0 auto">
    

    <div style="margin: 20px 0">
      

      <div style="margin: 10px 0">
        <el-input
          type="textarea"
          placeholder="请输入评论"
          v-model="comment.content"
        ></el-input>
        <div style="text-align: right; margin: 10px 0">
          <el-button type="primary" @click="submit">提交</el-button>
        </div>
      </div>
    </div>

    <div style="margin: 20px 0">
      <div
        style="
          margin: 10px 0;
          font-size: 24px;
          padding: 10px 0;
          border-bottom: 1px solid #ccc;
          text-align: left;
        "
      >
        问答列表
      </div>

      <div style="margin: 20px 0; text-align: left">
        <div style="padding: 10px 0" v-for="item in comments" :key="item.id">
          <div style="display: flex">
            <div style="width: 80px">
              <el-avatar
                :size="50"
                :src="'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'"
              ></el-avatar>
            </div>
            <div style="flex: 1">
              <div>
                {{ item.username }}
                <span style="margin-left: 10px">{{ item.createtime }}</span>
              </div>
              <div style="margin-top: 10px; color: #666">
                {{ item.content }}
              </div>
              <div>
                <el-button type="text" @click="reply(item.id, item.username)"
                  >回复</el-button
                >
              </div>

              <!-- 回复列表 -->
              <div
                v-if="item.children.length"
                style="
                  margin-left: 100px;
                  background-color: aliceblue;
                  padding: 10px;
                  border-radius: 10px;
                "
              >
                <div v-for="sub in item.children" :key="sub.id">
                  <div style="padding: 5px 0">
                    <b
                      style="cursor: pointer"
                      @click="reply(sub.pid, sub.username)"
                      >{{ sub.username }}</b
                    >
                    <span
                      >回复
                      <span style="color: cornflowerblue"
                        >@{{ sub.target }}</span
                      >
                      <span style="color: #666; margin-left: 10px">{{
                        sub.content
                      }}</span></span
                    >
                    <span
                      style="
                        float: right;
                        font-size: 13px;
                        color: #666;
                        margin-top: 3px;
                      "
                      >{{ sub.createtime }}</span
                    >
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <el-dialog title="回复" :visible.sync="dialogFormVisible" width="40%">
      <el-form :model="replyComment">
        <el-form-item label="内容" :label-width="100">
          <el-input
            v-model="replyComment.content"
            autocomplete="off"
            style="width: 80%"
          ></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveReply">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</div>
</template>

<script>
import Cookies from "js-cookie";
export default {
  
  name: "comment",
  data() {
    return {
      value: 0,
      comments: [],
      comment: {
        // rate: 0,
        content: "",
      },
      replyComment: {},
      dialogFormVisible: false,
    };
  },
  created() {
    this.load();
  },
  methods: {
    reply(pid, target) {
      this.replyComment = {
        pid: pid,
        userId: 3,
        foreignId: 1,
        target: target,
      },
      this.replyComment.username=Cookies.get("username");
      this.dialogFormVisible = true;
    },
    // ttp://localhost:9000/comment?foreignId=1
    load() {
      fetch("http://localhost:9000/comment?foreignId=1")
        .then((res) => {
          if (res.status === 500) {
            this.$notify.error("系统错误");
            return {};
          }
          return res.json();
        })
        .then((res) => {
          // this.value = res.rate;
          this.comments = res.comments;
        });
    },
    saveReply() {
      fetch("http://localhost:9000/comment", {
        method: "post",
        headers: {
          "Content-Type": "application/json;charset=utf-8",
        },
        body: JSON.stringify(this.replyComment),
      }).then((res) => {
        if (res.status === 200) {
          this.$notify.success("成功");
          this.load();
          this.replyComment = {};
          this.dialogFormVisible = false;
        }
      });
    },
    submit() {
      // this.comment.userId = 1;
      this.comment.username = Cookies.get("username");
      this.comment.foreignId = 1;

      fetch("http://localhost:9000/comment", {
        method: "post",
        headers: {
          "Content-Type": "application/json;charset=utf-8",
        },
        body: JSON.stringify(this.comment),
      }).then((res) => {
        if (res.status === 200) {
          this.$notify.success("成功");
          this.load();
          this.comment = {};
        }
      });
    },
  },
};
</script>
