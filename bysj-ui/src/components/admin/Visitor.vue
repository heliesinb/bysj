<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path:'/home'}">首页</el-breadcrumb-item>
        <el-breadcrumb-item>访问记录</el-breadcrumb-item>
        <el-breadcrumb-item>访问列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
    <div class="demo-input-suffix">
        <span class="demonstration"></span>
        <el-input class="input1"
            placeholder="请输入查询的时间"
            v-model="queryInfo.time"  clearable @clear="getVisitorList()">
        </el-input>
        
        <el-input class="input2"
            placeholder="请输入查询的用户名"
            v-model="queryInfo.username"  clearable @clear="getVisitorList()">
        </el-input>
        <el-button class="input3" slot="append" type="primary" icon="el-icon-search"   @click="getVisitorList()"></el-button>
    </div>

    <el-table :data="vititorList" stripe border style="width:70%">
        <el-table-column type="index" label="序号"></el-table-column> <!-- 索引列 -->
        <el-table-column prop="time" label="日期"></el-table-column>
        <el-table-column prop="username" label="用户名"></el-table-column>
        <el-table-column prop="ip" label="IP地址"></el-table-column>
        <el-table-column label="操作">
            <template slot-scope="scope">
                <!-- 删除 -->
                <el-tooltip effect="dark" content="删除" placement="top-start" :enterable="true"><!--文字提示 enterable 隐藏-->
                    <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteVisitor(scope.row.time)"></el-button>
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
        this.getVisitorList();
    },
    data(){
        return{
             //查询信息实体
            queryInfo:{
                query:"", //查询信息
                pageNum:1, //当前页
                pageSize:5, //每页最大数
                time:'',
                username:'',
            },
            vititorList:[],
            total:0,  //总记录数
            queryForm:{
                username:'',
                time:'',
                ip:'',
            },
            
        }
    },
    methods:{
        //获取所有访客
        async getVisitorList(){
            const {data:res}=await this.$http.get("allvisitor",{params:this.queryInfo});
            this.vititorList=res.data; //用户列表数据封装,对应java中的data
            //console.log("数据11"+this.vititorList);
            this.total=res.numbers;  //总用户数封装,numbers对应java中的UserController的numbers
        },
        
        //最大数
        handleSizeChange(newSize){
            this.queryInfo.pageSize=newSize;
            this.getVisitorList();
        },
        //pageNum的触发动作
        handleCurrentChange(newPage){
            this.queryInfo.pageNum=newPage;
            this.getVisitorList();
        },

        //根据用户名删除访客记录
    async deleteVisitor(time){
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
            const {data:res} = await this.$http.delete("deleteVisitor?time="+time);
            if (res != "success") {
                return this.$message.error("删除失败！！！");
            }
            this.$message.success("删除成功！！！");
            this.getVisitorList(); //刷新一下数据
    }
    },
}
</script>

<style lang="less" scoped>
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
</style>