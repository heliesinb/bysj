<template>
   <div>
      <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path:'/home'}">首页</el-breadcrumb-item>
            <el-breadcrumb-item>选题管理</el-breadcrumb-item>
            <el-breadcrumb-item>所有选题</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
       <el-row :gutter="25"> 
                 <!-- 导出表格 -->
       <a href="http://localhost:9000/exportCourse">
          <el-col :span="4">
              <el-button style="" type="primary" class="el-icon-download" @click="exp()">    导出表格</el-button>
          </el-col>
       </a>
      </el-row>
          <el-table
                :data="list" border stripe
                style="width: 100%">
            <el-table-column aria-disabled="false"
                    prop="cid"
                    label="编号"
                    width="50">
            </el-table-column>
            <el-table-column
                    prop="cname"
                    label="选题名称"
                    width="320">
            </el-table-column>
            <el-table-column
                    prop="username"
                    label="教师名称"
                    width="100">
            </el-table-column>
            <el-table-column
                    prop="num"
                    label="需要人数"
                    width="50">
            </el-table-column>
            <el-table-column
                    prop="introduction"
                    label="简介"
                    width="350">
            </el-table-column>
            <el-table-column
                    prop="nandu"
                    label="难度"
                    width="50">
            </el-table-column>
             <el-table-column
                    prop="effort"
                    label="工作量"
                    width="50">
            </el-table-column>
             <el-table-column
                    prop="remake"
                    label="备注"
                    width="120">
            </el-table-column>
        </el-table>
      </el-card>
   </div>
</template>
<script>
  import Cookies from "js-cookie";
export default {
     name: "AllCourse.vue",
        created() {
           this.getList();
        },
         mounted(){
          this.getCookie();
    },
        data(){
            return{
                queryForm:{
                    cname:'',
                    username:'',
                },
                list:[],
                addDiaLog:false,
                addForm:{
                  cid:'',
                    cname:'',
                    username:'',
                    num:'',
                    introduction:'',
                    nandu:'',
                    effort:'',
                    remake:'',
                    stuName:''
                },
                username:'',
              
            }
        },
          methods:{
              created(){
                 this.getList();
              },
            getCookie() {
            const username = Cookies.get("username");
           },
            async getList(){
              this.queryForm.username = Cookies.get("username");
              const {data:res} = await this.$http.post("allCourse",this.queryForm);
              this.list =res.list;
            },
            //导出表
       exp(){
         this.$message.success("导出成功");
       },
          }
           
}
</script>
<style scoped lang="less" scoped>
  .el-breadcrumb{
        padding-top: 20px;
        margin-bottom: 15px;
        font-size: 17px;
    }
      .input1{
        padding-top: 10px;
        padding-right: 10px;
        padding-left: 20px;
        width: 200px;
    }
      .input2{
        padding-top: 10px;
        padding-right: 10px;
        padding-left: 20px;
        width: 200px;
    }
    .slect1{
      width: 200px;
    }
</style>