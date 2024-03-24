<template>
    <div>
      <div>
        <!-- 面包屑导航 -->
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>学生中心</el-breadcrumb-item>
          <el-breadcrumb-item>论文查看</el-breadcrumb-item>
        </el-breadcrumb>
        <!-- 用户列表主体部分 -->
        <el-card>
          <!-- 搜索区域 -->
          <!-- 间隙 -->
          <el-row :gutter="25">
            <!-- 列宽 -->
            <el-col :span="10">
              <!-- 搜索添加 -->
              <el-input placeholder="请输入搜索内容" v-model="queryInfo.query" clearable @clear="getUserList">
                <el-button slot="append" icon="el-icon-search" @click="getFileList()"></el-button>
              </el-input>
            </el-col>
          </el-row>
          <el-table :data="fileList" border stripe style="width: 100%">
            <el-table-column aria-disabled="false" prop="id" label="编号" width="50">
            </el-table-column>
            <el-table-column prop="filename" label="文件名" width="350">
            </el-table-column>
            <el-table-column prop="url" label="文件路径" width="550">
            </el-table-column>
  
            <el-table-column prop="date" label="上传时间" width="180">
            </el-table-column>
            <el-table-column label="操作">
              <!-- 作用域插槽 -->
              <template slot-scope="scope" >
                <!-- 下载 -->
                <el-button type="primary" icon="el-icon-download" size="mini" @click="download(scope.row.url)">
                </el-button>
              </template>
            </el-table-column>
  
            
          </el-table>
          <!-- 分页 size-change 每页最大数变化 current-change 页数变化 layout 功能组件-->
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
              :current-page="queryInfo.pageNum" :page-sizes="[1, 2, 5, 100]" :page-size="queryInfo.pageSize"
              layout="total, sizes, prev, pager, next, jumper" :total="total">
            </el-pagination>
        </el-card>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    created() {
      this.getFileList();
    },
    data() {
      return {
        // 请求数据  查询实体类
        queryInfo: {
          query: "", //查询信息
          pageNum: 1, //当前页
          pageSize: 5, //每页最大数
        },
        fileList: [], // 用户列表
        total: 0, // 最大数据记录
      };
    },
    methods: {
  //获取所有用户
  async getFileList() {
        // 调用post请求
        const { data: res } = await this.$http.get("/file/allFile", {
          params: this.queryInfo,
        });
        this.fileList = res.data; // 将返回数据赋值  用户列表数据封装
        this.total = res.numbers; // 总个数   总用户数封装
      },
      // 监听pageSize改变的事件  最大数
      handleSizeChange(newSize) {
        this.queryInfo.pageSize = newSize;
        this.getFileList(); // 数据发生改变重新申请数据
      },
      // 监听pageNum改变的事件
      handleCurrentChange(newPage) {
        this.queryInfo.pageNum = newPage;
        this.getFileList(); // 数据发生改变重新申请数据
      },
      async download(url){
        window.open(url,"_blank");
        
      }
    },
  }
  
  
  </script>
  
  <style lang="less" scoped>
  /* 面包屑样式 */
  .el-breadcrumb {
    margin-bottom: 15px;
    font-size: 17px;
  }
  
  .el-input {
    box-shadow: 0 0 10px #ddd;
    width: 40%;
    margin-left: 20%;
    margin-top: 30px;
  }
  
  .el-button {
    margin-left: 1%;
  }
  </style>