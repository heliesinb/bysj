<template>
  <div>公告列表
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>公告栏</el-breadcrumb-item>
      <el-breadcrumb-item>查看公告</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 公告列表主体部分 -->
    <el-card>
      <el-row :gutter="25"> 
        <!--搜索区域 -->
        <el-col :span="10"> 
             <!--搜索按钮 -->                                      <!--clearable 清除按钮，添加此属性会出现一个小x的按钮 -->
            <el-input placeholder="请输入搜索内容" v-model="queryInfo.query" clearable @clear="getNoticeList">
                <el-button slot="append" icon="el-icon-search" @click="getNoticeList"></el-button>
            </el-input>
        </el-col>
      </el-row>

      <!-- 公告列表  stripe 隔行变色-->
      <el-table :data="noticeList" border stripe>
           <el-table-column label="序号" prop="id"></el-table-column> <!-- 索引列 -->
           <el-table-column label="日期" prop="time"></el-table-column>
           <el-table-column label="内容" prop="content"></el-table-column>
       
           <el-table-column label="操作">
                <template slot-scope="scope">
                  <!-- 详情 -->
                <el-tooltip effect="dark" content="查看公告" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="primary" icon="el-icon-edit-outline" size="mini" @click="showEditDialog(scope.row.id)"></el-button>
                </el-tooltip>
             <!-- 下载附件 -->
                <!-- <el-tooltip effect="dark" content="下载附件" placement="top-start" :enterable="true">
                    <el-button type="success" icon="el-icon-download" size="mini" @click="download(scope.row)"></el-button>
                </el-tooltip> -->
                
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



        <!-- 查看公告对话框 -->
    <el-dialog title="查看公告" center="" :visible.sync="addDialogVisible" width="30%" @close="addDialogClosed">
        <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="70px"> <!--label-width="70px",这个属性影响form-item离对表单左边的距离 -->
            <!-- 日期 -->
            <el-form-item label="日期:" prop="time">
                <el-input v-model="addForm.time" disabled></el-input>
            </el-form-item>
            <!-- 内容 -->
            <el-form-item label="内容:" prop="content">
                <el-input v-model="addForm.content" disabled></el-input>
            </el-form-item>
        </el-form>
        <!-- 内容底部区域 -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="addDialogVisible=false">确定</el-button>
        </span>
    </el-dialog>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
    created(){
        this.getNoticeList();
    },
    mounted(){

    },
    data(){
        return{
            //查询信息实体
            queryInfo:{
                query:"", //查询信息
                pageNum:1, //当前页
                pageSize:5, //每页最大数
            },
            noticeList:[], //公告列表
            total:0,  //总记录数
            addDialogVisible:false, //对话框状态
            // 表格选中的数据,用数组来接收
            selectionModel: [],
            //批量下载id，用来传给后端的字符串
            ids:'',
             //添加公告信息
             addForm:{
                time:"",
                content:""
            },
        }
    },
    methods:{  
        //获取所有公告
       async getNoticeList(){
          const {data:res}= await this.$http.get("getNotice",{params:this.queryInfo});
          this.noticeList=res.data; //公告列表数据封装,对应java中的data
          this.total=res.numbers;  //总公告数封装,numbers对应java中的UserController的numbers
        },
        //最大数
        handleSizeChange(newSize){
            this.queryInfo.pageSize=newSize;
            this.getNoticeList();
        },
        //pageNum的触发动作
        handleCurrentChange(newPage){
            this.queryInfo.pageNum=newPage;
            this.getNoticeList();
        },
       //显示修改对话框
       async showEditDialog(id){
            const {data:res}=await this.$http.get("getUpdateNotice?id="+id);
            this.addForm=res; //查询公告信息反填编辑表单
            this.addDialogVisible=true;  //开启编辑对话框
        },
        //下载文件
        // download(row) {
		// 		console.log(row);
		// 	},
			
    }
}
</script>
 
<style lang="less">

</style>