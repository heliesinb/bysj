package com.example.bysj.dao;

import com.example.bysj.pojo.Comment;
import com.example.bysj.pojo.Notice;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface CommentDao extends JpaRepository<Comment, Integer> {

    List<Comment> findAllByForeignId(Integer foreignId);



}
