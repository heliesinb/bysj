package com.example.bysj.service.impl;

import com.example.bysj.dao.CommentDao;
import com.example.bysj.dao.CommentDao2;
import com.example.bysj.pojo.Comment;
import com.example.bysj.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentDao2 commentDao;


    @Override
    public List<Comment> getAllComment(String content, int pageStart, int pageSize) {
        return commentDao.getAllComment(content, pageStart, pageSize);
    }

    @Override
    public int getCommentCounts(String content) {
        return commentDao.getCommentCounts(content);
    }

    @Override
    public int deleteComment(int id) {
        return commentDao.deleteComment(id);
    }
}
