package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.pojo.Comment;
import com.example.bysj.pojo.QueryInfo;
import com.example.bysj.service.impl.CommentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

@RestController
public class CommentController2 {
    @Autowired
    CommentServiceImpl commentService;

    @RequestMapping("/allComment")
    public  String getCommentList(QueryInfo queryInfo){
        //获取最大列表数和当前编号
        //System.out.println(queryInfo);
        int numbers=commentService.getCommentCounts("%"+queryInfo.getQuery()+"%");
        System.out.println(numbers);
        int pageStart=(queryInfo.getPageNum()-1)*queryInfo.getPageSize();
        List<Comment> nts=commentService.getAllComment("%"+queryInfo.getQuery()+"%",pageStart,queryInfo.getPageSize());
        HashMap<String,Object> res=new HashMap<>();
        res.put("numbers",numbers);  //对应UserList.vue里的numbers
        res.put("data",nts);
        String res_string= JSON.toJSONString(res);
        return res_string;
    }

    @RequestMapping("/deleteComment")
    public String deleteComment(int id){
        int i=commentService.deleteComment(id);
        return i>0?"success":"error";
    }
}
