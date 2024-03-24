package com.example.bysj.dao;

import com.example.bysj.pojo.Comment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentDao2 {
    public List<Comment> getAllComment(@Param("content") String content, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);

    public int getCommentCounts(@Param("content") String content);

    public int deleteComment(int id);
}
