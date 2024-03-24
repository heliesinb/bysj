<template>
    <div>
        修改权限
        <!-- 面包屑导航 -->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>权限管理</el-breadcrumb-item>
            <el-breadcrumb-item>修改权限</el-breadcrumb-item>
        </el-breadcrumb>

        <!-- 卡片 -->
        <el-card>
            <el-row :gutter="25">
                <!-- 搜索区域 -->
                <el-col :span="10">                                             <!-- clearable 是否显示清除按钮-->
                    <el-input placeholder="请输入搜索内容" v-model="roleInfo.rolename" clearable @clear="getList">
                        <el-button slot="append" type="primary" icon="el-icon-search" @click="getList()"></el-button>
                    </el-input>
                </el-col>
                <!-- 添加角色 -->
                <el-col :span="4">
                    <el-button type="primary" @click="addDialogVisible=true">添加角色</el-button>
                </el-col>
            </el-row>

            <!-- 表格 -->
            <el-table :data="roleList" border stripe>
                <el-table-column label="角色id" prop="roleId"></el-table-column> <!-- 索引列 -->
                <el-table-column label="角色名称" prop="roleName" ></el-table-column>
                <el-table-column label="排序" prop="sort" ></el-table-column>
                <el-table-column label="状态" prop="statas" >
                    <!--作用域插槽 scope.row 存储了当前行的信息 -->
                    <template slot-scope="scope"><!--数据模板-->
                        <el-switch v-model="scope.row.status" @change="changeStatus(scope.row.roleId)"></el-switch>
                    </template>
                </el-table-column>
                <el-table-column label="备注" prop="ps" ></el-table-column>
                <!-- 操作 -->
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <!-- 删除 -->
                        <el-tooltip effect="dark" content="删除角色" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteRole(scope.row.roleId)"></el-button>
                        </el-tooltip>
                         <!-- 修改 -->
                        <el-tooltip effect="dark" content="修改角色信息" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                            <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.roleId)"></el-button>
                        </el-tooltip>
                        <!-- 权限 -->
                        <el-tooltip effect="dark" content="分配菜单" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                            <el-button type="warning" icon="el-icon-setting" size="mini" @click="Menulist(scope.row.roleId)"></el-button>
                        </el-tooltip>
                    </template>
                </el-table-column>
            </el-table>

            <!-- 新增角色对话框 -->
            <el-dialog title="添加角色" center :visible.sync="addDialogVisible" width="30%" @close="addDialogClose">
                <el-form :model="addRoleForm" :rules="addRules" ref="addFormRef" label-width="70px">
                    <!-- 角色id -->
                    <el-form-item label="角色ID" prop="roleId">
                        <el-input v-model="addRoleForm.roleId"></el-input>
                    </el-form-item>
                    <!-- 角色名称 -->
                    <el-form-item label="角色名:" prop="roleName">
                        <el-input v-model="addRoleForm.roleName"></el-input>
                    </el-form-item>
                    <!-- 排序-->
                    <el-form-item label="排序:" prop="sort">
                        <el-input v-model="addRoleForm.sort"></el-input>
                    </el-form-item>
                     <!-- 备注 -->
                    <el-form-item  label="备注:" prop="ps">
                        <el-input v-model="addRoleForm.ps"></el-input>
                    </el-form-item>
                </el-form>
                <!-- 内容底部区域 -->
                <span slot="footer" class="dialog-footer">
                    <el-button @click="addDialogVisible=false">取消</el-button>
                    <el-button type="primary" @click="addRole">确定</el-button>
                </span>
            </el-dialog>

            <!-- 修改角色对话框 -->
            <el-dialog title="修改用户信息" :visible.sync="editDialogVisible" width="30%" @close="editDialogClosed">
                <el-form :model="editForm" :rules="editRoleRlues" ref="editFormRef" label-width="90px"> <!--label-width="70px",这个属性影响form-item离表单左边的距离 -->
                    <!-- 角色id -->
                    <el-form-item label="角色id:" prop="roleId">
                        <!-- 角色id不能修改，添加disabled属性，不能修改 -->
                        <el-input v-model="editForm.roleId" disabled></el-input>
                    </el-form-item>
                    <!-- 角色名 -->
             
                    <el-form-item label="角色名称:" prop="roleName">
                        <el-input v-model="editForm.roleName" ></el-input>
                    </el-form-item>
                   
                    <!-- 排序 -->
                    <el-form-item label="排序:" prop="sort">
                        <el-input v-model="editForm.sort"></el-input>
                    </el-form-item>
                    <!-- 备注 -->
                    <el-form-item label="备注:" prop="ps">
                <el-input v-model="editForm.ps"></el-input>
                    </el-form-item>
                </el-form>
                <!-- 内容底部区域 -->
                <span slot="footer" class="dialog-footer">
                    <el-button @click="editDialogVisible=false">取消</el-button>
                    <el-button type="primary" @click="editdRoleInfo">确定</el-button>
                </span>
            </el-dialog>

            <!-- 分配菜单对话框 -->
            <el-dialog title="选择菜单" :visible.sync="editRoleDialogVisible" width="30%" @close="addDialogClose">
                <el-input placeholder="输入关键字进行过滤" v-model="filterText"></el-input>
                <el-tree class="filter-tree" :data="list" :default-checked-keys="checkList" show-checkbox
                  node-key="id" :props="defaultProps" default-expand-all :filter-node-method="filterNode" 
                ref="tree">
                </el-tree>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="editRoleDialogVisible=false">取消</el-button>
                    <el-button type="primary" @click="change()">确定</el-button>
                </span>
            </el-dialog>

        </el-card>
    </div>
</template>

<script>
export default {
    watch:{
        filterText(val) {
        this.$refs.tree.filter(val);
      }
    },
    name: "rights",
    created(){
        this.getList();
    },
    data(){
        return{
            //查询信息实体
            roleInfo:{
                rolename:"",
            },
            roleList: [],
            menulist1:[],
            addDialogVisible:false,//对话框状态
            iscollapse:false,
            activePath:'/right',
            addRoleForm:{
                roleId:'',
                roleName:''
            }, 

            //添加角色校验规则
            addRules: {
                roleId: [
                    {required: true, message: '请输入id', trigger: 'blur'},
                ],
                roleName: [
                    {required: true, message: '请输入角色名', trigger: 'blur'},
                ],
                sort:[
                    {required: true, message: '请输入排序', trigger: 'blur'}
                ]
            },
            //修改角色信息
            editForm:{},
            //显示隐藏修改角色栏
            editDialogVisible:false,
            //修改角色校验规则
            editRoleRlues: {
                roleId: [
                    {required: true, message: '请输入id', trigger: 'blur'},
                ],
                roleName: [
                    {required: true, message: '请输入角色名', trigger: 'blur'},
                ],
                sort:[
                    {required: true, message: '请输入排序', trigger: 'blur'}
                ]
            },
            editRoleDialogVisible:false,
            editRoleForm:{

            },
            editRoleId:'',
            defaultProps: {
                children: 'slist',
                label: 'title'
            },
            filterText:'',
            list:[],
            checkList:[],
            SelectedList:[],
                changeForm:{
                list:'',
                roleId:''
            },
        }
    },
    methods:{
        //获取角色
        async  getList(){
                const rolename =this.roleInfo.rolename;
                const {data:res} = await this.$http.post("role?rolename="+rolename);
                this.roleList =res.role; //用户列表数据封装
                console.log(rolename)
            },

        //监听添加角色
        addDialogClose(){
            this.$refs.addFormRef.resetFields();
        },

        //添加角色方法
        addRole(){
                this.$refs.addFormRef.validate(async valid=>{
                    if(!valid) return ;
                    this.addDialogVisible=true;
                    const {data:res} = await this.$http.post("addRole",this.addRoleForm);
                    console.log(this.addRoleForm.roleId)
                    if(res=="exist"){
                        return this.$message.error("用户名或id重复！");
                    }
                    if(res=="erro"){
                        return this.$message.error("添加失败！");
                    }
                    this.$message.success("添加成功！");
                    this.addDialogVisible=false;
                    this.getList();
                });
            },

            //更改状态方法
            async changeStatus(roleId){
                const {data:res}=await this.$http.get("changeStatus?roleId="+roleId);
                  if(res!="success"){
                    return this.$message.error("更改失败！");
                }
                this.$message.success("更改成功！");
            },

            //删除角色
            async deleteRole(roleId){
                const confimResust=await this.$confirm('确定删除？','提示',{
                    confirmButtonText:'确定',
                    cancelButtonText:'取消',
                    type:'warning'
                }).catch(err=>err)
                if(confimResust!='confirm'){
                    return this.$message.info("已取消删除");
                }
                const {data:res}=await this.$http.delete("delete?roleId="+roleId);
                /*     const {data:res}=await this.$http.delete("deleteUser");*/
                console.log(res);
                if(res!="success"){
                    return this.$message.error("删除失败！");
                }
                this.$message.success("删除成功！");
                this.getList();
            
            },

            //显示修改对话框
            async showEditDialog(roleId){
                const {data:res}=await this.$http.get("getUpdateRole?roleId="+roleId);
                this.editForm=res; //查询用户信息反填编辑表单
                this.editDialogVisible=true;  //开启编辑对话框
            },
            //关闭窗口
            editDialogClosed(){
                this.$refs.editFormRef.resetFields(); //重置信息
            },
            //确认修改
            editdRoleInfo(){
                this.$refs.editFormRef.validate(async valid=>{
                    if(!valid) return;
                    //发起请求
                    const {data:res}= await this.$http.put("editUser2",this.editForm);
                    if (res != "success") {
                            return this.$message.error("修改失败！！！");
                        }
                        this.$message.success("修改成功！！！");
                        //隐藏对话框
                        this.editDialogVisible=false;
                        this.getList();
                    })
            },
            //分配菜单
            async Menulist(roleId){
                /* const username = Cookies.get("username");*/
                console.log("1111111111111111111")
                const {data:res}=await this.$http.get("menuList");
                const {data:res1}=await this.$http.get("selectRoleMenu?roleId="+roleId);
                this.list =res.menuList;  //数据回填
                this.checkList=res1.list;
                this.editRoleId=roleId;
                this.editRoleDialogVisible=true;
            },
            filterNode(value, list) {
               if (!value) return true;
                return list.title.indexOf(value) !== -1;

            },
            change(){
                this.changeForm.list=this.$refs.tree.getCheckedKeys().concat(this.$refs.tree.getHalfCheckedKeys());
                this.changeForm.roleId=this.editRoleId;
                this.$http.put("changeRoleMenu",this.changeForm);
                console.log(this.SelectedList)
                this.$message.success("修改成功！");
                this.editRoleDialogVisible=false;
            },          
    }
}
</script>

<style lang="less">

</style>