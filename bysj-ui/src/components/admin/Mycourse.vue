<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>学生中心</el-breadcrumb-item>
      <el-breadcrumb-item>我的选题</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="demo-input-suffix">
      <span class="demonstration"></span>
      <el-input class="input1" placeholder="请输入选题名称" v-model="queryForm.cname" clearable @clear="getList()">
      </el-input>
      <el-input class="input2" placeholder="请输入教师名称" v-model="queryForm.username" clearable @clear="getList()">
      </el-input>

      <el-button class="input3" slot="append" type="primary" icon="el-icon-search" @click="getList()"></el-button>
    </div>
    <el-table :data="list" border stripe style="width: 100%">
      <el-table-column aria-disabled="false" prop="cid" label="编号" width="50">
      </el-table-column>
      <el-table-column prop="cname" label="选题名称" width="320">
      </el-table-column>
      <el-table-column prop="username" label="教师名称" width="100">
      </el-table-column>
      <el-table-column prop="introduction" label="简介" width="350">
      </el-table-column>
      <el-table-column prop="nandu" label="难度" width="80">
      </el-table-column>
      <el-table-column prop="effort" label="工作量" width="80">
      </el-table-column>

      <el-table-column prop="remake" label="备注" width="150">
      </el-table-column>
      <el-table-column label="操作" width="150">
        <template slot-scope="scope">
          <el-button type="primary" icon="el-icon-delete" size="mini" @click="dropCourse(scope.row)">退题</el-button>
         
        </template>
      </el-table-column>
    </el-table>

  </div>
</template>
<script>
import Cookies from "js-cookie";
export default {
  name: "mycourse.vue",
  created() {
    this.getList();
  },
  mounted() {
    this.getCookie();
  },
  data() {
    return {
      username: '',
      queryForm: {
        cname: '',
        username: '',
        stuName: '',
      },
      list: [],
      addDiaLog: false,
      addForm: {
        cid: '',
        cname: '',
        username: '',

        introduction: '',
        nandu: '',
        effort: '',
        remake: '',
        stuName: ''
      },
      username: '',

      addRules: {
        cname: [
          { required: true, message: '请输入名称', trigger: 'blur' },
        ],
        introduction: [
          { required: true, message: '请输入简介', trigger: 'blur' },
        ],

        nandu: [
          { required: true, message: '请选择难度', trigger: 'blur' },
        ],
        effort: [
          { required: true, message: '请选择工作量', trigger: 'blur' },
        ],
      },
      sendMailForm: {
      username: Cookies.get("username"),

      },
    }
  },
  methods: {
    created() {
      this.getList();
      this.username = Cookies.get("username");
      console.log(this.username)
    },
    getCookie() {
      const username = Cookies.get("username");
    },
    async getList() {
      this.queryForm.stuName = Cookies.get("username")
      const { data: res } = await this.$http.post("myCourse", this.queryForm);
      this.list = res.list;
    },
    async dropCourse(row) {
      row.stuName = Cookies.get("username");
      const confirmResult = await this.$confirm('确定退题？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)
      if (confirmResult != 'confirm') {
        return this.$message.info("已取消退题");
      }
      const { data: res } = await this.$http.post("dropCourse", row);
      if (res == "Success") {
        this.addDiaLog = false;
        this.getList();
        this.dropCourseSuccess();
        this.$message({
          message: '退题成功！',
          type: 'success'
        });

      }
      else {
        this.$message.error('退题失败！');
      }

    },
    async dropCourseSuccess() {
      const { data: res } = await this.$http.put("dropCourseSuccess", this.sendMailForm);
      if (res.status != 200) {
        this.$message.error(res.msg);
      } else {
        this.$message.success(res.msg);
      }

    }

  }
}
</script>
<style scoped lang="less" scoped>
.el-breadcrumb {
  padding-top: 20px;
  margin-bottom: 15px;
  font-size: 17px;
}

.input1 {
  padding-top: 10px;
  padding-right: 10px;
  padding-left: 20px;
  width: 200px;
}

.input2 {
  padding-top: 10px;
  padding-right: 10px;
  padding-left: 20px;
  width: 200px;
}

.slect1 {
  width: 200px;
}
</style>