package com.example.bysj.service;

import com.example.bysj.pojo.Notice;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NoticeService {
    public List<Notice> getAllNotice(@Param("content") String content, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);
    public List<Notice> getNotice(@Param("content") String content, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);
    public int getNoticeCounts(@Param("content") String content);
    public int updateState(Integer id,Boolean state);
    public int addNotice(Notice notice);
    public int deleteNotice(int id);
    //修改操作，修改+查询
    public Notice getUpdateNotice(int id);
    public int editNotice(Notice notice);
}
