<template>
    <div>
      <!-- 面包屑导航 -->
      <!-- 面包屑导航 -->
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>学生中心</el-breadcrumb-item>
        <el-breadcrumb-item>参考文献</el-breadcrumb-item>
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
          
        </el-row>
        <!-- 用户列表部分 -->
        <!-- 用户列表  border 边框 stripe 隔行变色 -->
        <el-table :data="referenceList" border stripe>
          <!--索引列-->
          <el-table-column label="编号" prop="id" width="50"></el-table-column>
          <el-table-column label="参考文献" prop="aname" width="200"></el-table-column>
          <el-table-column label="作者" prop="author" width="200"></el-table-column> 
          <el-table-column label="类型" prop="type" width="200"></el-table-column>
          <el-table-column label="出版社" prop="publication" ></el-table-column>
          <el-table-column label="出版日期" prop="date" ></el-table-column>
         
         
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