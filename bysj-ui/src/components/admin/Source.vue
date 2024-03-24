<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>学生中心</el-breadcrumb-item>
      <el-breadcrumb-item>选题选择</el-breadcrumb-item>
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
      <el-table-column prop="num" label="需要人数" width="50">
      </el-table-column>
      <el-table-column prop="introduction" label="简介" width="350">
      </el-table-column>
      <el-table-column prop="nandu" label="难度" width="50">
      </el-table-column>
      <el-table-column prop="effort" label="工作量" width="50">
      </el-table-column>
      <el-table-column prop="remake" label="备注" width="120">
      </el-table-column>
      <el-table-column label="操作" width="150">
        <template slot-scope="scope">
          <el-button type="primary" icon="el-icon-check" size="mini" @click="choose(scope.row)"></el-button>
         

        </template>
      </el-table-column>
    </el-table>
    <el-dialog title="选题选择" :visible.sync="addDiaLog" inline="true" width="50%" @close="addDiaLog=false">
      <el-form :inline="true" :model="addForm" ref="addFormRef" label-width="70px">
        <el-form-item label="选题名" prop="cname">
          <el-input v-model="addForm.cname" disabled></el-input>
        </el-form-item>
        <el-form-item label="学员名" prop="stuName">
          <el-input v-model="addForm.stuName" disabled></el-input>
        </el-form-item>
        <el-form-item label="教师名" prop="username">
          <el-input v-model="addForm.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="需要人数" prop="num">
          <el-input v-model="addForm.num" disabled></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="introduction">
          <el-select v-model="addForm.introduction" placeholder="请选择" class="slect1" disabled>
            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="难度" prop="nandu">
          <el-input v-model="addForm.nandu" disabled></el-input>
        </el-form-item>
        <el-form-item label="工作量" prop="effort">
          <el-input v-model="addForm.effort" disabled></el-input>
        </el-form-item>

        <el-form-item label="备注" prop="remake">
          <el-input v-model="addForm.remake" disabled></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDiaLog=false">取消</el-button>
        <el-button type="primary" @click="chooseCourse">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
import Cookies from "js-cookie";
export default {
  name: "source.vue",
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
      addDiaLog: false,
      addForm: {
        cid: '',
        cname: '',
        username: '',
        num: '',
        introduction: '',
        nandu: '',
        effort: '',
        remake: '',
        stuName: ''
      },
      username: '',
      sendMailForm: {
        username: Cookies.get("username"),
        
      },
    }
  },
  methods: {
    created() {
      this.getList();
    },
    getCookie() {
      const username = Cookies.get("username");
    },
    async getList() {

      const { data: res } = await this.$http.post("view", this.queryForm);
      this.list = res.list;
    },
    async chooseCourse() {
      const { data: res } = await this.$http.post("chooseCourse", this.addForm);
      if (res == "Success") {
        this.addDiaLog = false;
        this.getList();
        this.ChooseSuccess();
        this.$message({
          message: '选题成功！',
          type: 'success'
        });

      }
      else {
        this.$message.error('选题失败');
      }
    },
    choose(row) {
      this.addDiaLog = true

      this.addForm = row
      this.addForm.stuName = Cookies.get("username");
    },
    async ChooseSuccess() {
      const { data: res } = await this.$http.put("ChooseSuccess", this.sendMailForm);
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