package com.example.bysj.service;

import com.example.bysj.pojo.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentService {


    public List<Comment> getAllComment(@Param("content") String content, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);

    public int getCommentCounts(@Param("content") String content);

    public int deleteComment(int id);
}
