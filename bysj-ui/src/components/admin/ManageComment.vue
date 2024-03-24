<template>
  <div>
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>学生答疑</el-breadcrumb-item>
      <el-breadcrumb-item>问答管理</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 公告主体部分 -->
    <el-card>
      <el-row :gutter="25"> 
        <!--搜索区域 -->
        <el-col :span="10"> 
             <!--搜索按钮 -->                                      <!--clearable 清除按钮，添加此属性会出现一个小x的按钮 -->
            <el-input placeholder="请输入搜索内容" v-model="queryInfo.query" clearable @clear="getCommentList">
                <el-button slot="append" icon="el-icon-search" @click="getCommentList"></el-button>
            </el-input>
        </el-col>
      </el-row>

      <!-- 公告列表  stripe 隔行变色-->
      <el-table :data="commentList" border stripe>
           <el-table-column  label="序号" prop="id"></el-table-column> <!-- 索引列 -->
           <el-table-column label="发布人" prop="username"></el-table-column>
           <el-table-column label="内容" prop="content"></el-table-column>
           <el-table-column label="发布时间" prop="createtime"></el-table-column>
           <el-table-column label="操作">
                <template slot-scope="scope">
             <!-- 删除 -->
                <el-tooltip effect="dark" content="删除记录" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteComment(scope.row.id)"></el-button>
                </el-tooltip>
                
                </template>
           </el-table-column>
      </el-table>

      <!-- 分页组件 -->
      <div>
          <!-- 分页 size-change 每页最大数变化 current-change 页数变化 layout 功能组件-->
        <el-pagination
            @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="queryInfo.pageNum"
                :page-sizes="[1, 5, 10, 20, 100]"
                :page-size="queryInfo.pageSize"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total" >
        </el-pagination>
      </div>
    </el-card>

 


       
  </div>
</template>

<script>
export default {

    created(){
        this.getCommentList();
    },
     
    data(){
        return{
            //查询信息实体
            queryInfo:{
                query:"", //查询信息
                pageNum:1, //当前页
                pageSize:5, //每页最大数
            },
            commentList:[], //评论列表
            total:0,  //总记录数
            
        }
    },
    methods:{
        //获取所有用户
        async getCommentList(){
          const {data:res}= await this.$http.get("allComment",{params:this.queryInfo});
          console.log(res.data);
          this.commentList=res.data; //公告列表数据封装,对应java中的data
          this.total=res.numbers;  //总公告数封装,numbers对应java中的UserController的numbers
        },
        //最大数
        handleSizeChange(newSize){
            this.queryInfo.pageSize=newSize;
            this.getCommentList();
        },
        //pageNum的触发动作
        handleCurrentChange(newPage){
            this.queryInfo.pageNum=newPage;
            this.getCommentList();
        },
        
        //根据主键删除评论
        async deleteComment(id){
            // 弹框
            const confirmResult = await this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).catch(err => err)
            // 成功删除为confirm 取消为 cancel
            if(confirmResult!='confirm'){
                return this.$message.info("已取消删除");
            }
            const {data:res} = await this.$http.delete("deleteComment?id="+id);
            if (res != "success") {
                return this.$message.error("删除失败！！！");
            }
            this.$message.success("删除成功！！！");
            this.getCommentList();
       },

   
     
       
    }
}
</script>
 
<style lang="less">
.btn-upload {
	top: 70px;
	right: 40px;
	z-index: 100;
	border-radius: 30px;
}
	
.el-upload {
	margin: 5px;
}
</style>