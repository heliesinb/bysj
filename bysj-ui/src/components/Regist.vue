<template>
  <div class="container">

    <!-- 注册模块 -->
    <div class="box">
      <!-- 头像 -->
      <div class="avatar_box">
        <img src="../assets/img/logo.png" />
      </div>

      <el-form
        :model="registForm"
        ref="registFormRef"
        :rules="registRules"
        status-icon
        label-width="100px"
        class="regist_form"
      >
        <el-form-item label="用户名" prop="username">
          <!-- 使用status-icon属性为输入框添加了表示校验结果的反馈图标。 -->
          <el-input
            v-model="registForm.username"
            placeholder="请输入用户名"
          ></el-input>
        </el-form-item>
        <!--
          autocomplete 属性规定输入字段是否应该启用自动完成功能。
          自动完成允许浏览器预测对字段的输入。当用户在字段开始键入时，浏览器基于之前键入过的值，应该显示出在字段中填写的选项。
          input 的属性autocomplete 默认为on
          其含bai义代表是否让浏览器du自动记录之前输入的值
          很多时候zhi，需dao要对客户的资料进行保密，防止浏览器软件或者恶意插件获取到
          可以在input中加入autocomplete="off" 来关闭记录
          系统需要保密的情况下可以使用此参数
        -->

        <el-form-item label="密码" prop="password">
          <el-input
            placeholder="请输入密码"
            v-model="registForm.password"
            show-password
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="checkpassword">
          <el-input
            placeholder="请再次输入密码"
            v-model="registForm.checkpassword"
            show-password
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input
            placeholder="请输入邮箱"
            v-model="registForm.email"
          ></el-input>
        </el-form-item>

        <!-- 验证码 -->
        <el-form-item prop="seccode" label="验证码">
          <el-input
            class="log-input"
            v-model="registForm.seccode"
            placeholder="请输入验证码(区别大小写)"
            prefix-icon="iconfont icon-mimadunpai"
            @keydown.enter.native="checkCode"
          >
          </el-input>
          <span class="checkCode" @click="createCode">{{ checkCode }}</span>
        </el-form-item>

        <el-form-item class="btn">
          <el-button type="primary" @click="regist()" @keyup.enter="regist"
            >注册</el-button
          >
          <el-button type="info" @click="restForm()">重置</el-button>
          <el-button type="success" @click="backLogin()">返回登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    var validatePassword = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.registForm.checkpassword !== "") {
          this.$refs.registFormRef.validateField("checkPassword");
        }
        callback();
      }
    };
    var validatePassword2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.registForm.password) {
        callback(new Error("两次密码不一致！"));
      } else {
        callback();
      }
    };
    return {
      registForm: {
        username: "",
        password: "",
        checkpassword: "",
        email: "",
        seccode: "",
      },
      checkCode: "",

      //表单验证
      registRules: {
        username: [
          { required: true, message: "用户名称为必填项", trigger: "blur" }, //必填项验证
          {
            min: 5,
            max: 12,
            message: "长度在 5 到 12 个字符",
            trigger: "blur",
          }, //长度验证
        ],
        password: [
          { validator: validatePassword, trigger: "blur" }, //自定义验证
          { min: 6, max: 10, message: "长度在 6 ~ 10 个字符", trigger: "blur" }, //长度验证
        ],
        checkpassword: [
          { validator: validatePassword2, trigger: "blur" }, //自定义验证
          { min: 6, max: 10, message: "长度在 6 ~ 10 个字符", trigger: "blur" }, //长度验证
        ],
        email: [
          { required: true, message: "请输入邮箱地址", trigger: "blur" },
          {
            type: "email",
            message: "请输入正确的邮箱地址",
            trigger: ["blur", "change"],
          },
        ],
        seccode: [{ required: true, message: "请输验证码", trigger: "blur" }],
      },
    };
  },
  mounted() {
    this.createCode();
    // 绑定监听事件
    window.addEventListener("keydown", this.keyDown);
  },
  destroyed() {
    // 销毁事件
    window.removeEventListener("keydown", this.keyDown, false);
  },
  methods: {
    //验证码
    createCode() {
      var code = "";
      const codeLength = 4; //验证码的长度
      const random = new Array(
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "c",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z"
      ); //随机数
      for (let i = 0; i < codeLength; i++) {
        //循环操作
        let index = Math.floor(Math.random() * 60); //取得随机数的索引（0~60）
        code += random[index]; //根据索引取得随机数加到code上
      }
      this.checkCode = code; //把code值赋给验证码
      /*loginForm.seccode=code;*/
    },
    regist() {
      //验证校验规则
      this.$refs.registFormRef.validate(async (valid) => {
        if (!valid) return;

        //验证码校验
        if (this.registForm.seccode == this.checkCode) {
          //验证码正确，注册用户
          const { data: res } = await this.$http.post(
            "regist",
            this.registForm
          );
          if (res.flag == "success") {
            this.$message.success("注册成功！！！");
            this.$refs.registFormRef.resetFields(); //重置表单
            this.createCode(); //刷新验证码
          } else if (res.flag == "error") {
            this.$message("该用户名已存在！！！");
          } else {
            this.$message.error("出错啦！");
          }
          console.log(res.flag);
        } else {
          this.$message.error("验证码错误！！!");
          this.createCode(); //再次刷新验证码
          return false;
        }
      });
    },
    //重置表单内容
    restForm() {
      this.$refs.registFormRef.resetFields();
      this.createCode(); //刷新验证码
    },
    backLogin() {
      this.$router.push("/login"); //回到登录
    },
     // 点击回车键登录
    keyDown(e) {
      // 回车则执行登录方法 enter键的ASCII是13
      if (e.keyCode === 13) {
        this.regist(); // 定义的登录方法
      }
    },
  },
};
</script>

<style lang="less" scpoed>
.container {
  //设置背景图铺满整个屏幕
  background-image: url("../assets/img/regist.jpg");
  background-position: center center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
  height: 100%;
}
.box {
  width: 400px;
  height: 500px;
  border-radius: 4px;
  margin: 0 auto;
  position: absolute; // 绝对定位
  left: 50%;
  top: 50%;
  background-color: #fff;
  opacity: 0.6;
  transform: translate(-50%, -50%); // 根据自己位置 以自己为长度位移
  // 头像框
  .avatar_box {
    width: 130px;
    height: 130px;
    border: 1px solid #eee;
    border-radius: 50%; // 加圆角
    padding: 10px;
    box-shadow: 0px 0px 20px #02414d; // 盒子阴影
    position: absolute;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: rgb(69, 8, 167);
    img {
      width: 100%;
      height: 100%;
      border-radius: 50%; // 加圆角
      background-color: #eee;
    }
  }
  //输入验证码框
  .log-input {
    width: 60%;
  }
  .checkCode {
    padding-left: 20px;
    color: #df5000;
  }
}
.regist_form {
  position: absolute;
  bottom: 0%;
  width: 100%;
  padding: 0 10px;
  box-sizing: border-box; // 设置边框
  margin-top: 200px;
}
video {
  position: fixed;
  right: 0px;
  bottom: 0px;
  min-width: 100%;
  min-height: 100%;
  height: 100%;
  width: auto;
  /*加滤镜*/
  /*filter: blur(15px); //背景模糊设置 */
  /*-webkit-filter: grayscale(100%);*/
  /*filter:grayscale(100%); //背景灰度设置*/
  z-index: -11;
}
source {
  min-width: 100%;
  min-height: 100%;
  height: auto;
  width: auto;
}
</style>