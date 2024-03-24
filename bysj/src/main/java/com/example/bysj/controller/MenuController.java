package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.pojo.MainMenu;
import com.example.bysj.pojo.Notice;
import com.example.bysj.pojo.QueryInfo;
import com.example.bysj.pojo.SubMenu;
import com.example.bysj.service.impl.MenuServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestController
public class MenuController {

    @Autowired
    MenuServiceImpl menuService;

    @RequestMapping("/menus")
    public String getAllMenus(String username){
        System.out.println("访问成功");
        HashMap<String,Object> data=new HashMap<>();
        List<MainMenu> menus=menuService.getMenus(username);       //根据不同角色获取不同菜单
        int status =404; //错误 404,成功 200
        if(menus!=null){
            data.put("menus",menus);
            data.put("flag",200);
        }else{
            data.put("flag",404);
        }
        String s= JSON.toJSONString(data);
        return s;
    }

    @RequestMapping("/allmenus")
    public String getMenu(){
        HashMap<String,Object> data =new HashMap<>();
        List<MainMenu> menus =menuService.getAll();
        System.out.println(menus);
        if(menus!=null){
            data.put("menus",menus);
            data.put("flag",200);
        }
        else {
            data.put("flag",404);
        }
        String s= JSON.toJSONString(data);

        return s;
    }

    @RequestMapping("/menuList")
    public String menuList(){
        HashMap<String,Object> data =new HashMap<>();
        List<MainMenu> menuList =menuService.menuList();
        data.put("menuList",menuList);
        String s= JSON.toJSONString(data);
        return s;
    }



}
