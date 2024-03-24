package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.pojo.*;
import com.example.bysj.service.impl.NoticeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
@RestController
public class NoticeController {
    @Autowired
    private NoticeServiceImpl noticeService;

    @RequestMapping("/allNotice")
    public  String getNoticeList(QueryInfo queryInfo){
        //获取最大列表数和当前编号
        //System.out.println(queryInfo);
        int numbers=noticeService.getNoticeCounts("%"+queryInfo.getQuery()+"%");
        int pageStart=(queryInfo.getPageNum()-1)*queryInfo.getPageSize();
        List<Notice> nts=noticeService.getAllNotice("%"+queryInfo.getQuery()+"%",pageStart,queryInfo.getPageSize());
        HashMap<String,Object> res=new HashMap<>();
        res.put("numbers",numbers);  //对应UserList.vue里的numbers
        res.put("data",nts);
        String res_string= JSON.toJSONString(res);
        return res_string;
    }

    @RequestMapping("/getNotice")
    public  String getNotice(QueryInfo queryInfo){
        //获取最大列表数和当前编号
        //System.out.println(queryInfo);
        int numbers=noticeService.getNoticeCounts("%"+queryInfo.getQuery()+"%");
        int pageStart=(queryInfo.getPageNum()-1)*queryInfo.getPageSize();
        List<Notice> nts=noticeService.getNotice("%"+queryInfo.getQuery()+"%",pageStart,queryInfo.getPageSize());
        HashMap<String,Object> res=new HashMap<>();
        res.put("numbers",numbers);  //对应UserList.vue里的numbers
        res.put("data",nts);
        String res_string= JSON.toJSONString(res);
        return res_string;
    }

    @RequestMapping("/noticeState")  //userState对应vue里面的
    public String updateUserState(@RequestParam("id") Integer  id,
                                  @RequestParam("state") Boolean state){

        int i = noticeService.updateState(id, state);
        return  i >0?"success":"error";
        //return str;
    }

    @RequestMapping("/addNotice")  //对应vue里面的
    public String addNotice(@RequestBody Notice notice){
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd :hh:mm:ss");
        notice.setState(false);
        notice.setTime(dateFormat.format(date));
        int num=noticeService.getNoticeCounts(notice.getContent());
        if(num>0){
            return "exist";
        }
        int i =noticeService.addNotice(notice);
        return  i >0?"success":"error";
    }

    @RequestMapping("/deleteNotice")
    public String deleteNotice(int id){
        int i=noticeService.deleteNotice(id);
        return i>0?"success":"error";
    }

    @RequestMapping("/getUpdateNotice")
    public String getUpdateNotice(int id){
        //System.out.println("编号:"+id);
        Notice updateNotice = noticeService.getUpdateNotice(id);
        String nots_json = JSON.toJSONString(updateNotice);
        return nots_json;
    }

    @RequestMapping("/editNotice")
    public String editNotice(@RequestBody Notice notice){
        System.out.println(notice);
        //System.out.println(user);
        int i = noticeService.editNotice(notice);
        System.out.println(i);
        return i >0?"success":"error";
        //String str = i >0?"success":"error";
        //return str;
    }
}
