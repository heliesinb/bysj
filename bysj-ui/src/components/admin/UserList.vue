<template>
  <div>用户列表
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>权限管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 用户列表主体部分 -->
    <el-card>
      <el-row :gutter="25"> 
        <!--搜索区域 -->
        <el-col :span="10"> 
             <!--搜索按钮 -->                                      <!--clearable 清除按钮，添加此属性会出现一个小x的按钮 -->
            <el-input placeholder="请输入搜索内容" v-model="queryInfo.query" clearable @clear="getUserList">
                <el-button slot="append" icon="el-icon-search" @click="getUserList"></el-button>
            </el-input>
        </el-col>

        <!-- 添加按钮 -->
        <el-col :span="4">
            <el-button type="primary" @click="addDialogVisible = true">添加用户</el-button>
        </el-col>

        <!-- 导出表格 -->
       <a href="http://localhost:9000/exportUser">
          <el-col :span="4">
              <el-button style="margin-left:400px" type="primary" class="el-icon-download"  @click="exp()">  导出表格</el-button>
          </el-col>
       </a>
      </el-row>

      <!-- 用户列表  stripe 隔行变色-->
      <el-table :data="userList" border :stripe="true">
           <el-table-column type="index" label="序号" width="50px"></el-table-column> <!-- 索引列 -->
           <el-table-column label="用户名" prop="username" width="150px"></el-table-column>
           <el-table-column label="邮箱" prop="email" width="250px"></el-table-column>
           <el-table-column label="密码" prop="password" width="250px"></el-table-column>
           <el-table-column label="角色" prop="role" width="100px"></el-table-column>
           <el-table-column label="状态" prop="state" width="150px">
               <!--作用域插槽 scope.row 存储了当前行的信息 -->
               <template slot-scope="scope"><!--数据模板-->
                    <el-switch v-model="scope.row.state" @change="userStateChange(scope.row)"></el-switch>
               </template>
           </el-table-column>
           <el-table-column label="操作">
                <template slot-scope="scope">
                <!-- 修改 -->
                <el-tooltip effect="dark" content="修改用户信息" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.id)"></el-button>
                </el-tooltip>
                <!-- 删除 -->
                <el-tooltip effect="dark" content="删除用户" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteUser(scope.row.id)"></el-button>
                </el-tooltip>
                <!-- 权限 -->
                <el-tooltip effect="dark" content="更改用户角色" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="warning" icon="el-icon-setting" size="mini" @click="changeRole(scope.row.username)"></el-button>
                </el-tooltip>
                <!-- 发送邮件 -->
            <el-tooltip
              effect="dark"
              content="发送邮件"
              placement="top-start"
              :enterable="false"
              ><!--文字提示 enterable 隐藏-->
              <el-button
                type="info"
                icon="el-icon-message"
                size="mini"
                @click="showMailDialog(scope.row)"
              ></el-button>
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

    <!-- 新增用户对话框 -->
    <el-dialog title="添加用户" center="" :visible.sync="addDialogVisible" width="30%" @close="addDialogClosed">
        <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="70px"> <!--label-width="70px",这个属性影响form-item离对表单左边的距离 -->
            <!-- 用户名 -->
            <el-form-item label="用户名:" prop="username">
                <el-input v-model="addForm.username"></el-input>
            </el-form-item>
            <!-- 密码 -->
            <el-form-item label="密码:" prop="password">
                <el-input v-model="addForm.password"></el-input>
            </el-form-item>
            <!-- 邮箱 -->
            <el-form-item label="邮箱:" prop="email">
                <el-input v-model="addForm.email"></el-input>
            </el-form-item>
        </el-form>
        <!-- 内容底部区域 -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="addDialogVisible=false">取消</el-button>
            <el-button type="primary" @click="addUser">确定</el-button>
        </span>
    </el-dialog>

     <!-- 修改用户对话框 -->
    <el-dialog title="修改用户信息" :visible.sync="editDialogVisible" width="30%" @close="editDialogClosed">
        <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="70px">
            <!-- 用户名 -->
            <el-form-item label="用户名:" prop="username">
                <!-- 用户名不能修改，添加disabled属性，不能修改 -->
                <el-input v-model="editForm.username" disabled></el-input>
            </el-form-item>
            <!-- 密码 -->
            <el-form-item label="密码:" prop="password">
                <el-input v-model="editForm.password"></el-input>
            </el-form-item>
            <!-- 邮箱 -->
            <el-form-item label="邮箱:" prop="email">
                <el-input v-model="editForm.email"></el-input>
            </el-form-item>
        </el-form>
        <!-- 内容底部区域 -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible=false">取消</el-button>
            <el-button type="primary" @click="editUserInfo">确定</el-button>
        </span>
    </el-dialog>

    <!-- 更改角色对话框 -->
    <el-dialog title="更改角色" :visible.sync="changeDialogVisible" width="30%" @close="editDialogClosed">
      <el-form :model="changeForm" :rules="editFormRules" ref="editFormRef" label-width="70px">
        <template>
        <el-select v-model="value" filterable placeholder="请选择角色">
          <el-option
                  v-for="item in roleList"
                  :key="item.roleId"
                  :label="item.roleName"
                  :value="item.roleId">
          </el-option>
        </el-select>
      </template>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="changeDialogVisible=false">取消</el-button>
        <el-button type="primary" @click="editRole()">确定</el-button>
      </span>
    </el-dialog>
    <!-- 发送邮件对话框 -->
    <el-dialog
      title="发送邮件"
      :visible.sync="MailDialogVisible"
      width="50%"
      @close="MailDialogClosed"
      :append-to-body="true"
    >
      <el-form :model="sendMailForm" ref="sendMailRef"  label-width="70px">
        <!-- 用户名 -->
         <el-form-item label="用户名" prop="username" >
          <el-input v-model="sendMailForm.username" :disabled="true"></el-input>
        </el-form-item> 
        <!-- 邮箱 -->
         <el-form-item label="邮箱" prop="email" >
          <el-input v-model="sendMailForm.email" :disabled="true"></el-input>
        </el-form-item>
        <!-- 内容 -->
         <el-form-item label="内容" prop="text">
          <el-input v-model="sendMailForm.text" type="textarea"></el-input>
        </el-form-item>
        
    </el-form> 
      <span slot="footer" class="dialog-footer">
        <el-button @click="MailDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="sendMail">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
    created(){
        this.getUserList();
        this.getList();
    },
     mounted(){
      this.getCookie();
    },
    data(){
        return{
            //查询信息实体
            queryInfo:{
                query:"", //查询信息
                pageNum:1, //当前页
                pageSize:5, //每页最大数
            },
            userList:[], //用户列表
            total:0,  //总记录数
            addDialogVisible:false, //对话框状态
            //添加用户信息
            addForm:{
                username:"",
                password:"",
                email:""
            },
            //添加用户表单验证
            addFormRules:{
                username: [
                    { required: true, message: '请输入用户名', trigger: 'blur' },
                    { min: 4, max: 8, message: '长度在 4 到 8 个字符', trigger: 'blur' }
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                    { min: 6, max: 12, message: '长度在 6 到 12 个字符', trigger: 'blur' }
                ],
                email:[
                    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
                    { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
                ]
            },
            //修改用户信息
            editForm:{},
            //显示隐藏修改用户栏
            editDialogVisible:false,
            //修改用户表单验证
            editFormRules:{
                password: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                    { min: 6, max: 12, message: '长度在 6 到 12 个字符', trigger: 'blur' }
                ],
                email:[
                    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
                    { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
                ],
            },

            //对话框状态
            changeDialogVisible:false,
            //更该角色信息
            changeForm:{
                roleId:'',
                username:''
            },
            roleList:[],
            value:'',
            editUser:'',
            MailDialogVisible:false,
      sendMailForm:{
        username:"",
        email:"",
        text:""
      },
      
        }
    },
    methods:{
       //获取所有用户
       getCookie() {
          const username = Cookies.get("username");
       },
     
        //获取所有用户
       async getUserList(){
          const {data:res}= await this.$http.get("alluser",{params:this.queryInfo});
          this.userList=res.data; //用户列表数据封装,对应java中的data
          this.total=res.numbers;  //总用户数封装,numbers对应java中的UserController的numbers
        },
        //最大数
        handleSizeChange(newSize){
            this.queryInfo.pageSize=newSize;
            this.getUserList();
        },
        //pageNum的触发动作
        handleCurrentChange(newPage){
            this.queryInfo.pageNum=newPage;
            this.getUserList();
        },
        //修改用户状态
        async userStateChange(userInfo){
            const { data:res } =await this.$http.put(`userState?id=${userInfo.id}&state=${userInfo.state}`);  //userState对应java
            if(res!="success"){
                userInfo.state=!userInfo.state; //取反
                return this.$message.error("操作失败！！！");
            }
            this.$message.success("操作成功！！！");
            this.getUserList();
        },
        //监听添加用户
        addDialogClosed(){
            this.$refs.addFormRef.resetFields(); // 重置表单项
        },
        // 添加用户
        addUser(){
            this.$refs.addFormRef.validate(async valid=>{
                if(!valid) return; //如果没有验证成功
                //提交数据
                const {data:res}=await this.$http.post("addUser",this.addForm); //addUser对应java中
                if(res!="success"){
                    return this.$message.error("添加失败！！！");
                }
                this.$message.success("添加成功！！！");
                this.addDialogVisible=false;
                this.getUserList();
            });
        },
        //根据主键删除用户
        async deleteUser(id){
            // 弹框
            const confirmResult = await this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).catch(err => err)
            // 成功删除为confirm 取消为 cancel
            if(confirmResult!='confirm'){
                return this.$message.info("已取消删除");
            }
            const {data:res} = await this.$http.delete("deleteUser?id="+id);
            if (res != "success") {
                return this.$message.error("删除失败！！！");
            }
            this.$message.success("删除成功！！！");
            this.getUserList();
       },

       //显示修改对话框
        async showEditDialog(id){
            const {data:res}=await this.$http.get("getUpdate?id="+id);
            this.editForm=res; //查询用户信息反填编辑表单
            this.editDialogVisible=true;  //开启编辑对话框
        },
       //关闭窗口
        editDialogClosed(){
            this.$refs.editFormRef.resetFields(); //重置信息
        },
       //确认修改
       editUserInfo(){
           this.$refs.editFormRef.validate(async valid=>{
               if(!valid) return;
               //发起请求
               const {data:res}= await this.$http.put("editUser",this.editForm);
               if (res != "success") {
                    return this.$message.error("修改失败！！！");
                }
                this.$message.success("修改成功！！！");
                //隐藏对话框
                this.editDialogVisible=false;
                this.getUserList();
            })
       },
       //导出表
       exp(){
         this.$message.success("导出成功");
       },
       //更改角色
      changeRole(username){
        this.changeDialogVisible=true;
        this.editUser =username
      },
      async  getList(){

        const {data:res} = await this.$http.get("getAllRole");
        this.roleList =res.role; //用户列表数据封装
        //console.log(roleList)
      },
      async editRole(){
        const roleId =this.value;
        const username =this.editUser;
        this.changeForm.roleId =roleId;
        this.changeForm.username =username;
        // console.log(this.changeForm.username)
        // console.log(this.editUser);
        const {data:res} = await this.$http.put("editRole",this.changeForm);
        if(res!="success")return this.$message.error("操作失败");
        this.$message.success("操作成功");
       this.changeDialogVisible=false;
        this.getUserList();
      },
        //发送邮件显示窗口
     async showMailDialog(row) {
     this.sendMailForm.username = row.username;
     this.sendMailForm.email = row.email;
     this.MailDialogVisible = true;
    },
    async sendMail(){
        const {data : res} = await this.$http.put("sendMail",this.sendMailForm);
        if(res.status != 200){
          this.$message.error(res.msg);
    }else{
          this.$message.success(res.msg);
        }
        this.MailDialogVisible = false;
    }
    }
}
</script>
 
<style lang="less">

</style>