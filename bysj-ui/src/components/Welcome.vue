<template>
  <div>
    <p>欢迎进入毕业设计选题管理系统</p>
    <el-carousel :interval="4000" type="card" height="400px">
      <el-carousel-item v-for="item in images" :key="item.id">
        <img :src="item.idImage" alt="" class="images">
        <h3 class="medium">{{ item }}</h3>
      </el-carousel-item>
   </el-carousel>
</div>
</template>

<script>
export default {
data(){
  return{
    images:[
      {id:1,idImage:require("../assets/img/course1.png")},
      {id:2,idImage:require("../assets/img/course2.png")},
      {id:3,idImage:require("../assets/img/course3.png")},
      {id:4,idImage:require("../assets/img/course4.png")},
      {id:5,idImage:require("../assets/img/course5.png")},
      {id:6,idImage:require("../assets/img/course6.png")},
      {id:7,idImage:require("../assets/img/course7.png")},
    ]
  }
}
}
</script>

<style lang="less">
.el-carousel__item h3 {
    //color: #475669;
    font-size: 14px;
    //opacity: 0.75;
    line-height: 200px;
    margin: 0;
  }
  
  // .el-carousel__item:nth-child(2n) {
  //   //background-color: #99a9bf;
  //   //background-image: url("../assets/img/6.jpg");
  // }
  
  // .el-carousel__item:nth-child(2n+1) {
  //   //background-color: #d3dce6;
  // }
  .images{
    height: 400px;
    width: 613px;
  }
  div>p{
    font-size: 20px;
    text-align: center;
  }
</style>