package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.dao.CommentDao;
import com.example.bysj.pojo.Comment;
import com.example.bysj.pojo.Notice;
import com.example.bysj.pojo.QueryInfo;
import com.example.bysj.service.impl.CommentServiceImpl;
import com.sun.media.jfxmediaimpl.HostUtils;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@CrossOrigin
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Resource
    CommentDao commentDao;


    @PostMapping
    public void save(@RequestBody Comment comment) {
        comment.setCreatetime(LocalDateTime.now());
        commentDao.save(comment);
    }

    @GetMapping
    public Map<String, Object> list(@RequestParam Integer foreignId) {
        Map<String, Object> map = new HashMap<>();

        List<Comment> comments = commentDao.findAllByForeignId(foreignId);

        List<Comment> rootComments = comments.stream().filter(comment -> comment.getPid() == null).collect(Collectors.toList());
        for (Comment rootComment : rootComments) {
            rootComment.setChildren(comments.stream().filter(comment -> rootComment.getId().equals(comment.getPid())).collect(Collectors.toList()));
        }
        map.put("comments", rootComments);
        return map;
    }


}
