<template>
    <div class="mainClass">
        修改权限
        <!-- 面包屑导航 -->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>权限管理</el-breadcrumb-item>
            <el-breadcrumb-item>个人信息</el-breadcrumb-item>
        </el-breadcrumb>

         <span class="infoSpan">个人详细信息</span>

        <div class="infoForm">
            <el-form ref="form" :model="form" label-width="80px">
                <el-form-item label="姓名:" style="width:400px">
                    <el-input v-model="form.trueName" readonly></el-input>
                </el-form-item>
                <el-form-item label="用户名:" style="width:400px">
                    <el-input v-model="form.username" readonly></el-input>
                </el-form-item>
                <el-form-item label="性别:" style="width:400px">
                    <el-input v-model="form.sex" readonly></el-input>
                </el-form-item>
                <el-form-item label="生日:" style="width:400px">
                    <el-col :span="11">
                        <el-date-picker type="date" placeholder="选择日期" v-model="form.birth" style="width: 320px;" readonly></el-date-picker>
                    </el-col>
                </el-form-item>
                <el-form-item label="地址:" style="width:400px">
                    <el-input v-model="form.address" readonly></el-input>
                </el-form-item>
                <el-form-item label="手机号:" style="width:400px">
                    <el-input v-model="form.phone" readonly></el-input>
                </el-form-item>
                <el-form-item label="身份证号:" style="width:400px">
                    <el-input v-model="form.idcard" readonly></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="editPsw">更改密码</el-button>
                    <el-button class="btn" type="primary" @click="edit">修改信息</el-button>
                </el-form-item>
            </el-form>
            <!-- 修改个人信息对话框 -->
            <el-dialog title="修改用户信息" :visible.sync="editDialogVisible" width="35%" @close="editDialogClosed">
                <el-form  :model="form1" :rules="editRules" ref="editFormRef1" label-width="80px" >
                    <el-form-item label="姓名:" style="width:400px" prop="trueName">
                        <el-input  v-model="form1.trueName"  ></el-input>
                    </el-form-item>
                    <el-form-item class="input" label="用户名:" style="width:400px" prop="username">
                        <el-input v-model="form1.username" readonly></el-input>
                    </el-form-item>
                    <el-form-item label="性别:" prop="sex">
                        <el-radio-group v-model="form1.sex" >
                            <el-radio  label="男" readonly></el-radio>
                            <el-radio label="女" readonly></el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item label="生日：" prop="birth">
                    <el-col :span="11">
                        <el-date-picker type="date" placeholder="选择日期" v-model="form1.birth" style="width: 320px;" >     
                        </el-date-picker>
                    </el-col>
                    </el-form-item>
                    <el-form-item label="住址:" style="width:400px" prop="address">
                        <el-input v-model="form1.address" ></el-input>
                    </el-form-item>
                    <el-form-item label="手机号:" style="width:400px" prop="phone">
                        <el-input v-model="form1.phone" ></el-input>
                    </el-form-item>
                    <el-form-item label="身份证:" style="width:400px" prop="idcard">
                        <el-input v-model="form1.idcard" ></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button  class="btn1" type="primary" @click="editDialogVisible=false">取消</el-button>
                        <el-button class="btn" type="primary" @click="submit()">提交</el-button>
                    </el-form-item>
                </el-form>
            </el-dialog>
            <!-- 修改密码 -->
            <el-dialog title="更改密码" :visible.sync="editPswDialogVisible" width="35%" @close="editPswDialogClosed">
                <el-form  :model="pswForm" :rules="editPswRules" ref="editFormRef" label-width="80px" >
                    <el-form-item label="旧密码:" style="width:400px" prop="oldPsw">
                        <el-input  v-model="pswForm.oldPsw" placeholder="请输入旧密码"  show-password></el-input>
                    </el-form-item>
                    <el-form-item label="新密码:" style="width:400px" prop="newPsw">
                        <el-input  v-model="pswForm.newPsw" placeholder="请输入新密码"  show-password></el-input>
                    </el-form-item>
                    <el-form-item label="确认:" style="width:400px" prop="surePsw">
                        <el-input  v-model="pswForm.surePsw" placeholder="请再次输入新密码"  show-password></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button  class="btn1" type="primary" @click="editPswDialogVisible=false">取消</el-button>
                        <el-button class="btn" type="primary" @click="editPswSure()">确认</el-button>
                    </el-form-item>
                </el-form>
            </el-dialog>
        </div>
    </div>
</template>

<script>
import Cookies from "js-cookie";
export default {
    data(){
        return{
            form: {
                trueName:'',
                username:'',
                sex:'',
                birth:'',
                address:'',
                phone:'',
                idcard:''
            },
            form1: {
                trueName:'',
                username:'',
                sex:'',
                birth:'',
                address:'',
                phone:'',
                idcard:''
            },
            pswForm:{
                username:'',
                oldPsw:'',
                newPsw:'',
                surePsw:''
            },
            editDialogVisible:false,
            editRules:{
                trueName: [
                    {required: true, message: '请输入真实姓名', trigger: 'blur'},
                ],
                sex: [
                    {required: true, message: '不可为空', trigger: 'blur'}],
                birth: [
                    {required: true, message: '不可为空', trigger: 'blur'}],
                address: [
                    {required: true, message: '不可为空', trigger: 'blur'}],
                phone: [
                    {required: true, message: '不可为空', trigger: 'blur'}],
                idcard: [
                {required: true, message: '不可为空', trigger: 'blur'}],
            },
            editPswDialogVisible:false,
            editPswRules:{
                oldPsw: [
                    {required: true, message: '请输入旧密码', trigger: 'blur'},
                ],
                newPsw: [
                    {required: true, message: '请输入新密码', trigger: 'blur'},
                ],
                surePsw: [
                    {required: true, message: '请在此输入新密码', trigger: 'blur'},
                ],
            }
        }
    },
    created(){
        this.queryUserInfo()
        this.form.username=Cookies.get("username");
        this.form1.username=Cookies.get("username");
    },
    methods:{
       async queryUserInfo(){
            const username =Cookies.get("username");
            const {data:res} = await this.$http.get("queryUserInfo?username="+username); 
            this.form=res
             //   this.$http.get("queryUserInfo?username="+username).then(function(res){})
        }, 
        async  edit(){
            // this.editFlag
            this.editDialogVisible=true; 
            const username =Cookies.get("username");
            const {data:res} = await this.$http.get("queryUserInfo?username="+username); 
            this.form1=res
        },
        async submit(){
            this.$refs.editFormRef1.validate(async valid=> {
                console.log("..........."+valid)
                if (!valid) return;
                    const {data:res} = await this.$http.post("updateUserInfo",this.form1); 
                this.queryUserInfo();
                if(res=="success"){
                    this.$message({message: '修改成功！',type: 'success'});
                this.editDialogVisible=false
                }
                else{
                    this.$message.error('修改失败');
                }
            })
        },
        editPsw(){
            this.editPswDialogVisible=true
        },
        //关闭窗口
        editDialogClosed(){
            this.$refs.editFormRef1.resetFields(); //重置信息
        },
        //关闭窗口
        editPswDialogClosed(){
            this.$refs.editFormRef.resetFields(); //重置信息
        },
        editPswSure(){
            this.$refs.editFormRef.validate(async valid=> {
                console.log("..........."+valid);
                if (!valid) return;
                this.pswForm.username=Cookies.get("username");
                const {data:res} = await this.$http.post("editPsw",this.pswForm); 
                if(res=="success"){
                    this.$message({
                        message: '修改成功！',
                        type: 'success'
                    });
                this.editPswDialogVisible=false
                }
                else if(res=="erro4"){
                    this.$message.error('新密码不能与旧密码一致');
                }
                else if(res=="erro1"){
                    this.$message.error('新密码与确认密码不一致');
                }
                else if(res=="erro2"){
                    this.$message.error('旧密码输入错误');
                }
                else if(res=="erro3"){
                    this.$message.error('修改失败');
                }
            })
        }             
    },
}
</script>

<style scoped lang="less">
.mainClass{
   margin:0 auto;
 
}
  .el-breadcrumb{
        padding-top: 20px;
        margin-bottom: 15px;
        font-size: 17px;
    }
    .infoSpan{
        padding-top: 20px;
        padding-left: 450px;
        font-size: 18px;
    }
    .infoForm{
         padding-top: 20px;
        padding-left: 300px;
         padding-right: 550px;
    }
    .btn{
      float: right;
    }
    .btn1{
      float: left;
    }
</style>