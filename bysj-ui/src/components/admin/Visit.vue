<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path:'/home'}">首页</el-breadcrumb-item>
        <el-breadcrumb-item>访问记录</el-breadcrumb-item>
        <el-breadcrumb-item>访问次数</el-breadcrumb-item>
    </el-breadcrumb>

    <p class="title">一周内访问次数</p>
  
 <div id="myChart" :style="{width: '1100PX', height: '400px'}"></div>
  </div>
</template>
 
<script>
 export default {
  name: 'Welcome',
  data () {
    return {
      value1:'',
      countList:[],
      timeList:[],
      countNum:[],
    }
  },
 async created(){
   await this.loginRecordList();
    this.drawLine(this.timeList,this.countList,this.countNum);
  },
  async mounted(){
   
 
  },
  methods: {
  async  drawLine(){
    await  console.log("=====================")
        // 基于准备好的dom，初始化echarts实例
        let myChart = this.$echarts.init(document.getElementById('myChart'))
        // 绘制图表
        myChart.setOption({
            title: { text: '', 
             x: -20 // center 
             },
            tooltip: {
               valueSuffix: '人' // 提示信息所带单位
            },
                color: ['#77DDFF', '#FFFF33'],
              legend: {
                data:['销量']
            },
            xAxis: {
                data:this.timeList
            },
           
            yAxis: {
                
                text: '人数',
           
                plotLines: [{
                value: 0,
                width: 1,
               
              }]
            },
            series: [{
                name: '访问次数',
                type: 'bar',
                 color: '#77DDFF',
                data: this.countList
            },
            {
                name: '访问人数',
                type: 'bar',
                 color: '#FFFF33',
                data: this.countNum
            }]
        });
    },
     async loginRecordList(){         
               const {data:res} = await this.$http.get("loginRecord");  
                //this.options.xAxis.categories.push(res.timeList)
              this.timeList=res.timeList
              this.countList=res.countList
              this.countNum=res.countNum
              console.log("访问次数"+res.countList)
              console.log("访问人数"+res.countNum)
              console.log("日期列表"+res.timeList)
           },
  }
}
</script>
 
<style>
   .el-breadcrumb{
        padding-top: 20px;
        margin-bottom: 15px;
        font-size: 17px;
    }
    .title{
      text-align: center;
      font-size: 20px;
      font-weight:bold;
      color: grey;
    }
    .span1{
      margin-left: auto;
         margin-right: auto;
      width: 70px;
      height: 25px;
      background-color:#77DDFF ;
    }
    .p1{
       margin-left: auto;
         margin-right: auto;
    }
    
</style>