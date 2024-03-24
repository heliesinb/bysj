package com.example.bysj.dao;

import com.example.bysj.pojo.Visitor;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface VisitorDao {
    public List<Visitor> getAllVisitor(@Param("username") String username, @Param("time") String time,@Param("pageStart") int pageStart, @Param("pageSize") int pageSize);
    //public List<Visitor> getAllVisitor2(@Param("time") String time, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);
    public int getVisitorCounts(@Param("username") String username,@Param("time") String time);
    //public int getVisitorCounts2(@Param("time") String time);
    public int deleteVisitor(String time);
}
