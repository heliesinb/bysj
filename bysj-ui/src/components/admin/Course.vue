<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>选题管理</el-breadcrumb-item>
      <el-breadcrumb-item>个人选题</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="demo-input-suffix">
      <span class="demonstration"></span>
      <el-input class="input1" placeholder="请输入选题名称" v-model="queryForm.cname" clearable @clear="getList()">
      </el-input>

      <el-button class="input3" slot="append" type="primary" icon="el-icon-search" @click="getList()"></el-button>
      <el-button type="primary" icon="el-icon-circle-plus" @click="addDiaLog=true">添加选题</el-button>

    </div>
    <el-table :data="list" border stripe style="width: 100%">
      <el-table-column aria-disabled="false" prop="cid" label="编号" width="80">
      </el-table-column>
      <el-table-column prop="cname" label="选题名称" width="300">
      </el-table-column>
      <el-table-column prop="introduction" label="简介" width="350">
      </el-table-column>
      <el-table-column prop="nandu" label="难度" width="80">
      </el-table-column>
      <el-table-column prop="effort" label="工作量" width="80">
      </el-table-column>
      <el-table-column prop="num" label="需要人数" width="80">
      </el-table-column>
      <el-table-column prop="remake" label="备注" width="130">
      </el-table-column>
      <el-table-column label="操作" width="175">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click="show(scope.row.cid)">查看选课名单</el-button>
          <!--删除-->

        </template>
      </el-table-column>
    </el-table>
    <el-dialog title="添加选题" :visible.sync="addDiaLog" inline="true" width="50%" @close="addDialogClose">
      <el-form :inline="true" :model="addForm" :rules="addRules" ref="addFormRef" label-width="70px">

        <el-form-item label="选题名" prop="cname">
          <el-input v-model="addForm.cname"></el-input>
        </el-form-item>

        <el-form-item label="工作量" prop="effort">
          <el-select v-model="addForm.effort" placeholder="请选择" class="slect1">
            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="难度" prop="nandu">
          <el-select v-model="addForm.nandu" placeholder="请选择" class="slect1">
            <el-option v-for="item in optiont" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="简介" prop="introduction">
          <el-input v-model="addForm.introduction"></el-input>
        </el-form-item>
        <el-form-item label="需要人数" prop="num">
          <el-input v-model="addForm.num"></el-input>
        </el-form-item>
        <el-form-item label="备注" prop="remake">
          <el-input v-model="addForm.remake"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDiaLog=false">取消</el-button>
        <el-button type="primary" @click="addCourse">确定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="选题名单" :visible.sync="showDiaLog" inline="true" width="30%" @close="showDialogClose">
      <el-table :data="showList" border stripe>
        <el-table-column type="index" label="编号"></el-table-column>
        <el-table-column aria-disabled="false" prop="username" label="姓名" width="160px">
        </el-table-column>
        <el-table-column aria-disabled="false" prop="email" label="邮箱" width="230px">
        </el-table-column>

      </el-table>
    </el-dialog>
  </div>
</template>
<script>
import Cookies from "js-cookie";
export default {
  name: "course.vue",
  created() {
    this.getList();
  },
  mounted() {
    this.getCookie();
  },
  data() {
    return {
      queryForm: {
        cname: '',
        username: '',
      },
      list: [],
      showList: [],
      myCourselist: [],
      addDiaLog: false,
      showDiaLog: false,
      myCourseDiaLog: false,
      addForm: {
        cname: '',
        introduction: '',
        nandu: '',
        num: '',
        effort: '',
        remake: '',
        username: ''
      },
      options: [{
        value: '大',
        label: '大'
      }, {
        value: '适中',
        label: '适中'
      }, {
        value: '小',
        label: '小'
      },
      ],

      optiont: [{
        value: '难',
        label: '难'
      }, {
        value: '一般',
        label: '一般'
      }, {
        value: '易',
        label: '易'
      },
      ],
      addRules: {
        cname: [
          { required: true, message: '请输入名称', trigger: 'blur' },

        ],
        introduction: [
          { required: true, message: '请输入简介', trigger: 'change' },
        ],
        num: [
          { required: true, message: '请输入需要人数', trigger: 'change' },
        ],
        nandu: [
          { required: true, message: '请选择难度', trigger: 'change' },
        ],
        effort: [
          { required: true, message: '请选择工作量', trigger: 'change' },
        ],
      },
    }
  },
  methods: {
    getCookie() {
      const username = Cookies.get("username");
      //console.log(username);
    },
    async getList() {
      this.queryForm.username = Cookies.get("username");
      const { data: res } = await this.$http.post("courseManage", this.queryForm);
      this.list = res.list;
    },
    async addCourse() {
      //debugger;
      this.$refs.addFormRef.validate(async valid => {
        if (!valid) return;
        this.addForm.username = Cookies.get("username");
        const { data: res } = await this.$http.post("addCourse", this.addForm);
        if (res == "Success") {
          this.addDiaLog = false;
          this.getList();
          this.$message({ message: '添加成功', type: 'success' });
        }
        else {
          this.$message.error('时间或者地点冲突');
        }
      });
    },
    async show(cid) {
      this.showDiaLog = true
      const { data: res } = await this.$http.post("sourceList?cid=" + cid);
      this.showList = res.list
    },

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