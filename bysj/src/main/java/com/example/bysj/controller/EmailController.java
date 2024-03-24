package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.example.bysj.pojo.User;
import com.example.bysj.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

@RestController
public class EmailController {

    @Autowired
    JavaMailSenderImpl mailSender;

    @Autowired
    UserServiceImpl userService;

    @RequestMapping("/sendMail")
    public String sendMail(@RequestBody String request){
        try {
            JSONObject json = JSONObject.parseObject(request);
            String email = json.getString("email");
            String text = json.getString("text");
            SimpleMailMessage message = new SimpleMailMessage();
            message.setSubject("<毕业设计选题管理系统通知>");
            message.setText(text);
            message.setFrom("你的邮箱xxxxx@xx.com");
            message.setTo(email);
            mailSender.send(message);
        }catch (Exception e){
            e.printStackTrace();
            HashMap<String, Object> map = new HashMap<>();
            map.put("status",400);
            map.put("msg","发送失败!");
            return JSON.toJSONString(map);
        }
        HashMap<String, Object> map = new HashMap<>();
        map.put("status",200);
        map.put("msg","发送成功!");
        return JSON.toJSONString(map);
    }


    @RequestMapping("/ChooseSuccess")
    public String ChooseSuccess(@RequestBody String request){
        try {
            JSONObject json = JSONObject.parseObject(request);
            String username = json.getString("username");
            User user = userService.getUserByUsername(username);
            String email = user.getEmail();
            SimpleMailMessage message = new SimpleMailMessage();
            message.setSubject("<毕业设计选题管理系统通知>");
            message.setText("选题成功！请注意,有任何疑问请及时联系相应老师。");
            message.setFrom("你的邮箱xxxxx@xx.com");
            message.setTo(email);
            mailSender.send(message);
        }catch (Exception e){
            e.printStackTrace();
            HashMap<String, Object> map = new HashMap<>();
            map.put("status",400);
            map.put("msg","发送失败!");
            return JSON.toJSONString(map);
        }
        HashMap<String, Object> map = new HashMap<>();
        map.put("status",200);
        map.put("msg","已成功发送通知!");
        return JSON.toJSONString(map);
    }

    @RequestMapping("/dropCourseSuccess")
    public String dropCourseSuccess(@RequestBody String request){
        try {
            JSONObject json = JSONObject.parseObject(request);
            String username = json.getString("username");
            User user = userService.getUserByUsername(username);
            String email = user.getEmail();
            SimpleMailMessage message = new SimpleMailMessage();
            message.setSubject("<毕业设计选题管理系统通知>");
            message.setText("退题成功！请注意,有任何疑问请及时联系相应老师。");
            message.setFrom("你的邮箱xxxxx@xx.com");
            message.setTo(email);
            mailSender.send(message);
        }catch (Exception e){
            e.printStackTrace();
            HashMap<String, Object> map = new HashMap<>();
            map.put("status",400);
            map.put("msg","发送失败!");
            return JSON.toJSONString(map);
        }
        HashMap<String, Object> map = new HashMap<>();
        map.put("status",200);
        map.put("msg","已成功发送通知!");
        return JSON.toJSONString(map);
    }
    @RequestMapping("/verifySuccess")
    public String verifySuccess(@RequestBody String request){
        try {
            JSONObject json = JSONObject.parseObject(request);
            String username = json.getString("username");
            User user = userService.getUserByUsername(username);
            String email = user.getEmail();
            SimpleMailMessage message = new SimpleMailMessage();
            message.setSubject("<毕业设计选题管理系统通知>");
            message.setText("审核成功！您提交的项目已被审核！");
            message.setFrom("你的邮箱xxxxx@xx.com");
            message.setTo(email);
            mailSender.send(message);
        }catch (Exception e){
            e.printStackTrace();
            HashMap<String, Object> map = new HashMap<>();
            map.put("status",400);
            map.put("msg","发送失败!");
            return JSON.toJSONString(map);
        }
        HashMap<String, Object> map = new HashMap<>();
        map.put("status",200);
        map.put("msg","已成功发送通知!");
        return JSON.toJSONString(map);
    }
    @RequestMapping("/verifyFailed")
    public String verifyFailed(@RequestBody String request){
        try {
            JSONObject json = JSONObject.parseObject(request);
            String username = json.getString("username");
            User user = userService.getUserByUsername(username);
            String email = user.getEmail();
            SimpleMailMessage message = new SimpleMailMessage();
            message.setSubject("<毕业设计选题管理系统通知>");
            message.setText("审核失败！请您重新提交！");
            message.setFrom("你的邮箱xxxxx@xx.com");
            message.setTo(email);
            mailSender.send(message);
        }catch (Exception e){
            e.printStackTrace();
            HashMap<String, Object> map = new HashMap<>();
            map.put("status",400);
            map.put("msg","发送失败!");
            return JSON.toJSONString(map);
        }
        HashMap<String, Object> map = new HashMap<>();
        map.put("status",200);
        map.put("msg","已成功发送通知!");
        return JSON.toJSONString(map);
    }
}
