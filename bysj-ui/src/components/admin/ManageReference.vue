<template>
    <div>
      <!-- 面包屑导航 -->
      <!-- 面包屑导航 -->
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>学生中心</el-breadcrumb-item>
        <el-breadcrumb-item>文献管理</el-breadcrumb-item>
      </el-breadcrumb>
      <!-- 用户列表主体部分 -->
      <el-card>
        <!-- 搜索区域 -->
        <!-- 间隙 -->
        <el-row :gutter="25">
          <!-- 列宽 -->
          <el-col :span="10">
            <!-- 搜索添加 -->
            <el-input
              placeholder="请输入搜索内容"
              v-model="queryInfo.query"
              clearable
              @clear="getAllReference"
            >
              <el-button
                slot="append"
                icon="el-icon-search"
                @click="getAllReference()"
              ></el-button>
            </el-input>
          </el-col>
          <el-col :span="4">
            <el-button type="primary" @click="addDialogVisible = true"
              >添加文献</el-button
            >
          </el-col>
        </el-row>
        <!-- 用户列表部分 -->
        <!-- 用户列表  border 边框 stripe 隔行变色 -->
        <el-table :data="referenceList" border stripe>
          <!--索引列-->
          <el-table-column label="编号" prop="id" width="50"></el-table-column>
          <el-table-column label="参考文献" prop="aname" width="200"></el-table-column>
          <el-table-column label="作者" prop="author" width="200"></el-table-column>
          <el-table-column label="出版社" prop="publication" width="200"></el-table-column>
          <el-table-column label="出版日期" prop="date" width="200"></el-table-column>
          <el-table-column label="类型" prop="type" width="200"></el-table-column>
          <!--自定义插槽-->
          <el-table-column label="操作">
            <!-- 作用域插槽 -->
            <template slot-scope="scope">
              <!-- 修改 -->
              <el-button
                type="primary"
                icon="el-icon-edit"
                size="mini"
                @click="getUpdateReference(scope.row.id)"
              ></el-button>
  
              
              <el-button
                type="danger"
                icon="el-icon-delete"
                size="mini"
                @click="deleteReference(scope.row.id)"
              ></el-button>
            
  
            </template>
          </el-table-column>
        </el-table>
  
        <!-- 分页 size-change 每页最大数变化 current-change 页数变化 layout 功能组件-->
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryInfo.pageNum"
          :page-sizes="[1, 2, 5, 100]"
          :page-size="queryInfo.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
        >
        </el-pagination>
      </el-card>
  
      <!-- 新增区域 -->
      <el-dialog
        title="添加文献"
        :visible.sync="addDialogVisible"
        width="50%"
        @close="addDialogClosed"
        :append-to-body="true"
      >
        <el-form
          :model="addForm"
          :rules="addFormRules"
          ref="addFormRef"
          label-width="70px"
        >
        
          <el-form-item label="参考文献" prop="aname">
            <el-input v-model="addForm.aname"></el-input>
          </el-form-item>
         
          <el-form-item label="作者" prop="author">
            <el-input v-model="addForm.author"></el-input>
          </el-form-item>
          
          <el-form-item label="出版社" prop="publication">
            <el-input v-model="addForm.publication"></el-input>
          </el-form-item>
  
          <el-form-item label="出版日期" prop="date">
            <el-input v-model="addForm.date"></el-input>
          </el-form-item>
  
          <el-form-item label="类型" prop="type">
            <el-input v-model="addForm.type"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="addDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="addReference">确 定</el-button>
        </span>
      </el-dialog>
  
      <!-- 修改对话框 -->
      <el-dialog
        title="修改文献"
        :visible.sync="editDialogVisible"
        width="50%"
        @close="editDialogClosed"
        :append-to-body="true"
      >
        <el-form
          :model="editForm"
          :rules="editFormRules"
          ref="editFormRef"
          label-width="70px"
        >
          
          <el-form-item label="参考文献" prop="aname">
            <el-input v-model="editForm.aname"></el-input>
          </el-form-item>
       
          <el-form-item label="作者" prop="author">
            <el-input v-model="editForm.author"></el-input>
          </el-form-item>
        
          <el-form-item label="出版社" prop="publication">
            <el-input v-model="editForm.publication"></el-input>
          </el-form-item>
          <el-form-item label="出版时间" prop="date">
            <el-input v-model="editForm.date"></el-input>
          </el-form-item>
          <el-form-item label="类型" prop="type">
            <el-input v-model="editForm.type"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="editDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="editReference">确 定</el-button>
        </span>
      </el-dialog>
  
    
    </div>
  </template>
  
  <script>
  export default {
    created(){
      this.getAllReference();
    },
    data() {
      return {
         // 请求数据  查询实体类
         queryInfo: {
          query: "", //查询信息
          pageNum: 1, //当前页
          pageSize: 5, //每页最大数
        },
        referenceList: [], // 用户列表
        total: 0, // 最大数据记录
        addDialogVisible: false, //会话框的状态
        addForm: {
          aname: "",
          author: "",
          publication: "",
        },
        //修改用户信息
        editForm: {},
        editRoleForm: {},
        //显示/隐藏修改用户栏
        editDialogVisible: false,
        editReferenceDialogVisible: false,
      }
    },
    methods: {
  //获取所有用户
  async getAllReference() {
        // 调用post请求
        const { data: res } = await this.$http.get("allReference", {
          params: this.queryInfo,
        });
        this.referenceList = res.data; // 将返回数据赋值  用户列表数据封装
        this.total = res.numbers; // 总个数   总用户数封装
      },
      // 监听pageSize改变的事件  最大数
      handleSizeChange(newSize) {
        this.queryInfo.pageSize = newSize;
        this.getAllReference(); // 数据发生改变重新申请数据
      },
      // 监听pageNum改变的事件
      handleCurrentChange(newPage) {
        this.queryInfo.pageNum = newPage;
        this.getAllReference(); // 数据发生改变重新申请数据
      },
      // 监听添加用户
      addDialogClosed() {
        this.$refs.addFormRef.resetFields();
      },
      addReference() {
        this.$refs.addFormRef.validate(async (valid) => {
          if (!valid) return;
          const { data: res } = await this.$http.post("addReference", this.addForm);
          if (res != "success") {
            return this.$message.error("操作失败!!!!");
          }
          this.$message.success("操作成功!!!");
          this.addDialogVisible = false;
          this.getAllReference();
        });
      },
      //根据主键删除信息
      async deleteReference(id) {
        const confirmResult = await this.$confirm(
          "此操作将永久删除用户，是否继续？",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
          }
        ).catch((err) => err);
        if (confirmResult != "confirm") {
          //取消删除
          return this.$message.info("已取消删除");
        }
        const { data: res } = await this.$http.delete("deleteReference?id=" + id);
        if (res != "success") {
          return this.$message.error("删除失败!!!!");
        }
        this.$message.success("删除成功!!!");
        this.getAllReference();
      },
      //显示对话框
      async getUpdateReference(id) {
        const { data: res } = await this.$http.get("getUpdateReference?id=" + id);
        this.editForm = res; //查询出用户信息反填回编辑表单
        this.editDialogVisible = true; //开启编辑对话框
      },
      editDialogClosed() {
        this.$refs.editFormRef.resetFields(); //重置信息
      },
      editRoleDialogClosed() {
       this.$refs.editRoleFormRef.resetFields(); //重置信息
      },
      //确认修改
      editReference() {
        
        this.$refs.editFormRef.validate(async (valid) => {
  
          if (!valid) return;
          //发起修改请求
          const { data: res } = await this.$http.put("editReference", this.editForm);
          if (res != "success") return this.$message.error("操作失败!!!");
          this.$message.success("操作成功!!!");
          //隐藏
          this.editDialogVisible = false;
          this.getAllReference();
        });
      },
  
        }
  }
  </script>
  
  <style lang="less" scoped>
  /* 面包屑样式 */
  .el-breadcrumb{
      margin-bottom: 15px;
      font-size: 17px;
  }
  .el-input{
    width: 300px;
  
  }
  </style>