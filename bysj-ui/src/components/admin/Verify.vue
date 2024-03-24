<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>选题管理</el-breadcrumb-item>
      <el-breadcrumb-item>选题审核</el-breadcrumb-item>
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
      <el-table-column prop="cname" label="选题名称" width="300">
      </el-table-column>
      <el-table-column prop="username" label="教师名称" width="100">
      </el-table-column>
      <el-table-column prop="num" label="需要人数" width="50">
      </el-table-column>
      <el-table-column prop="introduction" label="简介" width="350">
      </el-table-column>
      <el-table-column prop="nandu" label="难度" width="80"> </el-table-column>
      <el-table-column prop="effort" label="工作量" width="80">
      </el-table-column>
      <el-table-column prop="remake" label="备注" width="130">
      </el-table-column>
      <el-table-column label="操作" width="150">
        <template slot-scope="scope">
          <el-button type="primary" icon="el-icon-check" size="mini" @click="edit(scope.row)"></el-button>
          <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteCourse(scope.row)"></el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog title="审核选题" :visible.sync="addDiaLog" inline="true" width="50%" @close="addDialogClose">
      <el-form :inline="true" :model="addForm" :rules="addRules" ref="addFormRef" label-width="70px">
        <el-form-item label="选题名" prop="cname">
          <el-input v-model="addForm.cname"></el-input>
        </el-form-item>
        <el-form-item label="教师名" prop="cname">
          <el-input v-model="addForm.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="难度" prop="nandu">
          <el-select v-model="addForm.nandu" placeholder="请选择" class="slect1">
            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="需要人数" prop="num">
          <el-input v-model="addForm.num"></el-input>
        </el-form-item>
        <el-form-item label="工作量" prop="effort">
          <el-select v-model="addForm.effort" placeholder="请选择" class="slect1">
            <el-option v-for="item in option" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="简介" prop="introduction">
          <el-input v-model="addForm.introduction"></el-input>
        </el-form-item>
        <el-form-item label="备注" prop="remake">
          <el-input v-model="addForm.remake"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDiaLog = false">取消</el-button>
        <el-button type="primary" @click="editCourse">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
import Cookies from "js-cookie";
export default {
  name: "verify.vue",
  created() {
    this.getList();
  },
  mounted() {
    this.getCookie();
  },
  data() {
    return {
      queryForm: {
        cname: "",
        username: "",
      },
      list: [],
      addDiaLog: false,
      addForm: {
        cid: "",
        cname: "",
        username: "",
        num: "",
        introduction: "",
        nandu: "",
        effort: "",
        remake: "",
        
      },
      // sendMailForm: {
      // username: "",

      // },
      options: [
        {
          value: "难",
          label: "难",
        },
        {
          value: "适中",
          label: "适中",
        },
        {
          value: "易",
          label: "易",
        },
      ],

      optiont: [
        {
          value: "大",
          label: "大",
        },
        {
          value: "一般",
          label: "一般",
        },
        {
          value: "少",
          label: "少",
        },
      ],
      addRules: {
        cname: [{ required: true, message: "请输入名称", trigger: "blur" }],
        num: [{ required: true, message: "请输入需要人数", trigger: "blur" }],
        nandu: [{ required: true, message: "请选择难度", trigger: "blur" }],
        introduction: [
          { required: true, message: "请输入简介", trigger: "blur" },
        ],
        effort: [{ required: true, message: "请选择工作量", trigger: "blur" }],
      },
    };
  },
  methods: {
    getCookie() {
      const username = Cookies.get("username");
    },
    async getList() {
      const { data: res } = await this.$http.post("verify", this.queryForm);
      this.list = res.list;
    },
    async editCourse() {
      const { data: res } = await this.$http.post("editCourse", this.addForm);
      if (res == "Success") {
        this.addDiaLog = false;
        this.getList();
        this.verifySuccess();
        this.$message({
          message: "审核成功",
          type: "success",
        });
      } else {
        this.$message.error("审核失败");
      }
    },
    edit(row) {
      this.addDiaLog = true;
      this.addForm = row;
    },
   
    async deleteCourse(row) {
      this.addForm = row;
      const confirmResult = await this.$confirm("确定删除？", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      }).catch((err) => err);
      if (confirmResult != "confirm") {
        return this.$message.info("已取消删除");
      }
      const { data: res } = await this.$http.post("deleteCourse?cid=" + row.cid,this.addForm);
      console.log(row);
      if (res == "Success") {
        this.$message({
          message: "删除成功",
          type: "success",
        });
        this.verifyFailed();
        this.getList();
      } else {
        this.$message.error("删除失败！");
      }
    },
    //关闭窗口
    addDialogClosed() {
      this.$refs.addForm.resetFields(); //重置信息
    },
    async verifySuccess() {
      const { data: res } = await this.$http.put("verifySuccess", this.addForm);
      if (res.status != 200) {
        this.$message.error(res.msg);
      } else {
        this.$message.success(res.msg);
      }

    },
    async verifyFailed() {
      const { data: res } = await this.$http.put("verifyFailed", this.addForm);
      if (res.status != 200) {
        this.$message.error(res.msg);
      } else {
        this.$message.success(res.msg);
      }

    }
  },
};
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