package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.service.LoginRecordService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;


@RestController
public class LoginRecordController {
    @Resource
    LoginRecordService loginRecordService;
    @GetMapping("/loginRecord")
    public  String loginRecord(){
        Map map =loginRecordService.countLoginRecord();
        String s= JSON.toJSONString(map);
        return s;
    }
}
