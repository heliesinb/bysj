package com.example.bysj.service;

import com.example.bysj.pojo.Visitor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface VisitorService {
    public List<Visitor> getAllVisitor(@Param("username") String username, @Param("time") String time, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);
    //public List<Visitor> getAllVisitor2(@Param("time") String time, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);
    public int getVisitorCounts(@Param("username") String username,@Param("time") String time);
    //public int getVisitorCounts2(@Param("time") String time);
    public int deleteVisitor(String time);
}
