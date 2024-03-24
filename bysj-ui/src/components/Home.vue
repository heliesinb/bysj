<template>
   <!-- 引入container布局 -->
   <el-container class="home-container">
      <!--头部  -->
      <el-header>
        <div>
          <img src="../assets/img/logo.png" alt class="logo_img" />
          <span>毕业设计选题管理系统</span>
        </div>
        <!--头部-->
        <span>
          <div class="userInfo">
          欢迎您，亲爱的{{username}}
          </div>
        </span>
        <el-button type="danger" @click="logout()">安全退出</el-button>
      </el-header>

      <!-- 主体 -->
      <el-container>
        <!-- 侧边栏 -->
        <el-aside width="isCollapase?'64px':'200px'">
          <div class="aside-button" @click="asideCollapase">|||</div>
           <el-menu background-color="#545c64" text-color="#fff" active-text-color="#409eff"
           unique-opened="" :collapse="isCollapase" :collapse-transition="false" :router="true" 
           :default-active="activePath">
            <!-- 一级菜单 -->
            <el-submenu :index="item.id+''" v-for="item in menuList" :key="item.id" >
              <template slot="title" >
                <i :class="iconsObject[item.id]"></i>
                <span>{{item.title}}</span>
              </template>

              <!-- 二级菜单 -->   
              <el-menu-item :index="it.path+''" v-for="it in item.slist" :key="it.id" @click="saveNavState(it.path)">
                <template slot="title">
                  <i :class="iconsObject[it.id]"></i>
                  <span>{{it.title}}</span>
                </template>
              </el-menu-item>
            </el-submenu>
          </el-menu>
        </el-aside>

        <!-- 主体内容 -->
        <el-main>
          <!-- 路由在这里展示 -->
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
</template>

<script>
import Cookies from "js-cookie";
export default {
  data(){
    return{
      username:'',
      //菜单列表
      menuList:[],
      isCollapase:false,
      iconsObject:{
        '100':'iconfont icon-quanxianguanli',
        '200':'iconfont icon-xuanti-mingcheng',
        '300':'iconfont icon-xueshengdushu',
        '400':'iconfont icon-xuanti-jibie',
        '500':'iconfont icon-gonggao1',
        '50':'iconfont  icon-icon7',
        '600':'iconfont icon-wentijieda',
        '101':'iconfont icon-yonghuquanxian',
        '102':'iconfont icon-role',
        '103':'iconfont icon-gerenxinxi_o',
        '104':'iconfont icon-liebiao',
        '201':'iconfont icon-check',
        '202':'iconfont icon-xuanti-mingcheng',
        '203':'iconfont icon-xuanti-lanmubanmian',
        '301':'iconfont icon-xuanze',
        '302':'iconfont icon-timu-04',
        '303':'iconfont icon-liebiao1',
        '304':'iconfont icon-timu-04',
        '305':'iconfont icon-icon_xinyong_xianxing_jijin-174',
        '306':'iconfont icon-tushu',
        '401':'iconfont icon-tubiao-zhuzhuangtu',
        '402':'iconfont icon-jilu',
        '501':'iconfont icon-gonggao2',
        '502':'iconfont icon-gonggaoguanli',
        '601':'iconfont icon-liuyan',
        '602':'iconfont icon-liuyanguanli',
        '700':'iconfont icon-caidanguanli',
        '701':'iconfont icon-icon_xinyong_xianxing_jijin-174',
        '702':'iconfont icon-liebiao1'
      },
      activePath:"/welcome",
    }
  },

  //onload事件
  created(){
      //查询menuList
      this.getMenuList();
      this.activePath=window.sessionStorage.getItem("activePath");  //取出session里的path,动态修改activePath
      this.username=Cookies.get("username");
  },
  mounted(){
    this.getCookie();
  },
  methods:{
    //安全退出
    async logout(){
      // 弹框
      const confirmResult = await this.$confirm('是否确认退出?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
          }).catch(err => err)
          // 成功删除为confirm 取消为 cancel
      if(confirmResult!='confirm'){
              return this.$message.info("已取消");
      }
      window.sessionStorage.clear(); //清除session
      this.$router.push("/login");  //回到登录
      this.$message.success("退出成功！！！");
    },
    getCookie() {
      const username = Cookies.get("username");
      const password = Cookies.get("password");
      //console.log(username);
    },
    //获取导航菜单方法
    async getMenuList(){
      const username = Cookies.get("username");
      const {data:res}=await this.$http.get("menus?username="+username);
      //const {data:res}=await this.$http.get("menus");
      //console.log("getMenuList");
      console.log(res);
      if(res.flag!=200) return this.$message.error("获取列表失败！！！");//访问失败的错误信息
      this.menuList=res.menus; //数据回填
    },
    asideCollapase(){ //控制伸缩
      this.isCollapase=!this.isCollapase;
    },
    saveNavState(activePath){
      window.sessionStorage.setItem("activePath",activePath); //存放在session里
      this.activePath=activePath;
    }
  }
}
</script>

<style lang="less" scoped>
//布局器样式
.home-container {
  height: 100%;
}
//头部样式
.el-header {
  background-color: #373d41;
   display: flex;
  justify-content: space-between;// 左右贴边
  padding-left: 0%;// 左边界
  align-items: center;// 水平
  color: #fff;
  align-items: center;
  font-size: 40px;
  font-family:"华文新魏","华文新魏_GB2312";
  > div { //左侧div加布局
    display: flex;
    align-items: center;
    span {  
      margin-left: 15px;
    }
  }
}
//侧边样式
.el-aside {
  background-color: #333744;
  //消除对不齐的线
  .el-menu{
    border-right:none;// 对其右边框
  }
}
//主体样式
.el-main {
  background-color: #eaedf1;
}

.logo_img{
  width: 55px;
  height: 55px;
}
.aside-button{
    background-color:#4A5064;
  font-size: 10px;
  line-height: 24px;
  color:#fff;
  text-align: center;
  letter-spacing: 0.2em;
  cursor: pointer;// 显示鼠标指针为：小手
}
.userInfo{
    font-size: 30px;
    padding-left: 600px;
  }
</style>