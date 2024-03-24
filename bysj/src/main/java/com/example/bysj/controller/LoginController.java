package com.example.bysj.controller;

import com.example.bysj.pojo.LoginRecord;
import com.example.bysj.pojo.User;
import com.example.bysj.dao.UserDao;
import com.example.bysj.service.impl.UserServiceImpl;
import com.example.bysj.util.TimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.alibaba.fastjson.JSON;

import java.net.InetAddress;
import java.util.HashMap;



@RestController
public class LoginController {
    @Autowired
    UserServiceImpl userService;

    @RequestMapping("/login")
    public String login(@RequestBody User user){
        String flag="error";
        HashMap<String,Object> res=new HashMap<>();
        User us= userService.getUserByMassage(user.getUsername(),user.getPassword());
        if(us!=null){
            flag="ok";
            System.out.println("前台登录信息:"+us);
        }
        res.put("flag",flag);
        res.put("user",user);
        String res_json=JSON.toJSONString(res);

        //后台添加登录记录
        InetAddress ia=null;
        try {
            ia=ia.getLocalHost();
            String localip=ia.getHostAddress();
            LoginRecord loginRecord =new LoginRecord();
            loginRecord.setTime(TimeUtil.getTimeNow("yyyy-MM-dd HH:mm:ss",0));
            loginRecord.setUsername(user.getUsername());
            loginRecord.setIp(localip);
            userService.addLoginRecord(loginRecord);   //添加登录记录
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return res_json;
    }

    @RequestMapping("/regist")
    public String regist(@RequestBody User user){
        String flag="";
        User us=userService.check(user.getUsername());
        //System.out.println(us);
        HashMap<String,Object> res =new HashMap<>();
        if (us!=null){ //如果查询到注册用户名相同的数据
            flag= "error"; //错误，该用户已存在
            //System.out.println("不存在的"+flag);
        }else{
            //没有改用户，注册用户
            user.setRoleId(4);
            user.setState(true);
            userService.regist(user);
            flag="success";
            //System.out.println("存在的"+flag);
        }
        res.put("flag",flag);
        String res_json=JSON.toJSONString(res);
        //System.out.println("最终返回的的"+flag);
        return res_json;
    }
}
