<template>
    <div>
      <div>
        <!-- 面包屑导航 -->
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>学生中心</el-breadcrumb-item>
          <el-breadcrumb-item>论文提交</el-breadcrumb-item>
        </el-breadcrumb>
  
        <h1 style="margin-left:450px;">点击提交开题报告,任务书或毕业论文</h1>
        <el-form ref="form" :model="form" label-width="80px" style="margin-left:350px;">
  
          <el-form-item>
            <el-upload class="upload-demo" ref="upload" drag action="http://localhost:9000/file/upload" multiple
              :auto-upload="false" :limit="5" :on-success="handleFilUploadSuccess" :on-remove="handleRemove" v-model="form.file">
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
              <div class="el-upload__tip" slot="tip">只能上传 Excel 文件,且不超过500kb</div>
            </el-upload>
          </el-form-item>
          <el-button type="primary" @click="handleUpload" style="margin-left:200px">提交</el-button>
        </el-form>
  
  
        
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        dialogVisible: false,
        form: {                
                  username:'',
                  file:''
              },
      }
    },
    methods: {
      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      submitUpload() {
        this.$refs.upload.submit();
      },
      // 文件上传成功时的函数
      handleFilUploadSuccess(res, file, fileList) {
        console.log(res, file, fileList)
        this.$message.success("上传成功");
      },
  
      // 处理文件上传的函数
      handleUpload() {
        // console.log(res,file)
  
        this.submitUpload();
        this.dialogVisible = false;
      }
    }
  }
  
  </script>
  
  <style lang="less" scoped>
  /* 面包屑样式 */
  .el-breadcrumb {
    margin-bottom: 15px;
    font-size: 17px;
  }
  </style>