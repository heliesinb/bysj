<template>
  <div>公告列表
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>公告栏</el-breadcrumb-item>
      <el-breadcrumb-item>公告管理</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 公告主体部分 -->
    <el-card>
      <el-row :gutter="25"> 
        <!--搜索区域 -->
        <el-col :span="10"> 
             <!--搜索按钮 -->                                      <!--clearable 清除按钮，添加此属性会出现一个小x的按钮 -->
            <el-input placeholder="请输入搜索内容" v-model="queryInfo.query" clearable @clear="getNoticeList">
                <el-button slot="append" icon="el-icon-search" @click="getNoticeList"></el-button>
            </el-input>
        </el-col>

        <!-- 添加按钮 -->
        <el-col :span="4">
            <el-button type="primary" @click="addDialogVisible = true">添加公告</el-button>
        </el-col>
      </el-row>

      <!-- 公告列表  stripe 隔行变色-->
      <el-table :data="noticeList" border stripe>
           <el-table-column  label="序号" prop="id"></el-table-column> <!-- 索引列 -->
           <el-table-column label="日期" prop="time"></el-table-column>
           <el-table-column label="内容" prop="content"></el-table-column>
           <el-table-column label="状态" prop="state">
               <!--作用域插槽 scope.row 存储了当前行的信息 -->
               <template slot-scope="scope"><!--数据模板-->
                    <el-switch v-model="scope.row.state" @change="noticeStateChange(scope.row)"></el-switch>
               </template>
           </el-table-column>
           <el-table-column label="操作">
                <template slot-scope="scope">
                <!-- 修改 -->
                <el-tooltip effect="dark" content="修改公告" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.id)"></el-button>
                </el-tooltip>
                <!-- 删除 -->
                <el-tooltip effect="dark" content="删除公告" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteNotice(scope.row.id)"></el-button>
                </el-tooltip>
                <!-- 上传 -->
                <!-- <el-tooltip effect="dark" content="上传文件" placement="top-start" :enterable="true">
                    <el-button class="btn-upload" type="success" icon="el-icon-upload2" size="mini" @click="handleUpdate(scope.row.id)"></el-button>
                </el-tooltip> 
            -->
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

    
    <!-- 新增公告对话框 -->
    <el-dialog title="添加公告" center="" :visible.sync="addDialogVisible" width="30%" @close="addDialogClosed">
        <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="70px"> <!--label-width="70px",这个属性影响form-item离对表单左边的距离 -->
            <!-- 日期 -->
            <el-form-item label="日期:" prop="time">
                <el-input v-model="addForm.time" disabled></el-input>
            </el-form-item>
            <!-- 内容 -->
            <el-form-item label="内容:" prop="content">
                <el-input v-model="addForm.content"></el-input>
            </el-form-item>
        </el-form>
        <!-- 内容底部区域 -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="addDialogVisible=false">取消</el-button>
            <el-button type="primary" @click="addNotice">确定</el-button>
        </span>
    </el-dialog>

     <!-- 修改公告对话框 -->
    <el-dialog title="修改公告信息" :visible.sync="editDialogVisible" width="30%" @close="editDialogClosed">
        <el-form :model="editForm" ref="editFormRef" label-width="70px">
            <!-- 日期 -->
            <el-form-item label="日期:" prop="time">
                <el-input v-model="editForm.time" disabled></el-input>
            </el-form-item>
            <!-- 内容 -->
            <el-form-item label="内容:" prop="content">
                <el-input v-model="editForm.content"></el-input>
            </el-form-item>
        </el-form>
        <!-- 内容底部区域 -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible=false">取消</el-button>
            <el-button type="primary" @click="editNoticeInfo">确定</el-button>
        </span>
    </el-dialog>
     
  </div>
</template>

<script>
export default {
    name: "Upload",
    created(){
        this.getNoticeList();
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
            //添加公告信息
            addForm:{
                time:"",
                content:""
            },
            //添加公告表单验证
            addFormRules:{
                content: [
                    { required: true, message: '请输入内容', trigger: 'blur' },
                ],
            },
            //修改公告信息
            editForm:{},
            //显示隐藏修改公告栏
            editDialogVisible:false, 
            dialogVisible: false
        }
    },
    methods:{
        //获取所有用户
        async getNoticeList(){
          const {data:res}= await this.$http.get("allNotice",{params:this.queryInfo});
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
        //修改公告状态
        async noticeStateChange(noticeInfo){
            const { data:res } =await this.$http.put(`noticeState?id=${noticeInfo.id}&state=${noticeInfo.state}`);  //userState对应java
            if(res!="success"){
                noticeInfo.state=!noticeInfo.state; //取反
                return this.$message.error("操作失败！！！");
            }
            this.$message.success("操作成功！！！");
            this.getNoticeList();
        },
        //监听添加公告
        addDialogClosed(){
            this.$refs.addFormRef.resetFields(); // 重置表单项
        },
        // 添加公告
        addNotice(){
            this.$refs.addFormRef.validate(async valid=>{
                if(!valid) return; //如果没有验证成功
                //提交数据
                const {data:res}=await this.$http.post("addNotice",this.addForm); //addUser对应java中
                if(res!="success"){
                    return this.$message.error("添加失败！！！");
                }
                this.$message.success("添加成功！！！");
                this.addDialogVisible=false;
                this.getNoticeList();
            });
        },
        //根据主键删除公告
        async deleteNotice(id){
            // 弹框
            const confirmResult = await this.$confirm('此操作将永久删除该公告, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).catch(err => err)
            // 成功删除为confirm 取消为 cancel
            if(confirmResult!='confirm'){
                return this.$message.info("已取消删除");
            }
            const {data:res} = await this.$http.delete("deleteNotice?id="+id);
            if (res != "success") {
                return this.$message.error("删除失败！！！");
            }
            this.$message.success("删除成功！！！");
            this.getNoticeList();
       },

       //显示修改对话框
        async showEditDialog(id){
            const {data:res}=await this.$http.get("getUpdateNotice?id="+id);
            this.editForm=res; //查询公告信息反填编辑表单
            this.editDialogVisible=true;  //开启编辑对话框
        },
       //关闭窗口
        editDialogClosed(){
            this.$refs.editFormRef.resetFields(); //重置信息
        },
       //确认修改
       editNoticeInfo(){
           this.$refs.editFormRef.validate(async valid=>{
               if(!valid) return;
               //发起请求
               const {data:res}= await this.$http.put("editNotice",this.editForm);
               if (res != "success") {
                    return this.$message.error("修改失败！！！");
                }
                this.$message.success("修改成功！！！");
                //隐藏对话框
                this.editDialogVisible=false;
                this.getNoticeList();
            })
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