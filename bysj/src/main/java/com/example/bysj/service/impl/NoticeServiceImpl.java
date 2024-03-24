package com.example.bysj.service.impl;

import com.example.bysj.dao.NoticeDao;
import com.example.bysj.pojo.Notice;
import com.example.bysj.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    NoticeDao noticeDao;


    @Override
    public List<Notice> getAllNotice(String content, int pageStart, int pageSize) {
        return noticeDao.getAllNotice(content,pageStart,pageSize);
    }


    @Override
    public List<Notice> getNotice(String content, int pageStart, int pageSize) {
        return noticeDao.getNotice(content, pageStart, pageSize);
    }

    @Override
    public int getNoticeCounts(String content) {
        return noticeDao.getNoticeCounts(content);
    }

    @Override
    public int updateState(Integer id, Boolean state) {
        return noticeDao.updateState(id,state);
    }

    @Override
    public int addNotice(Notice notice) {
        return noticeDao.addNotice(notice);
    }

    @Override
    public int deleteNotice(int id) {
        return noticeDao.deleteNotice(id);
    }

    @Override
    public Notice getUpdateNotice(int id) {
        return noticeDao.getUpdateNotice(id);
    }

    @Override
    public int editNotice(Notice notice) {
        return noticeDao.editNotice(notice);
    }
}
