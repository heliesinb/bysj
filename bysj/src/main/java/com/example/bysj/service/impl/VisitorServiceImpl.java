package com.example.bysj.service.impl;

import com.example.bysj.dao.VisitorDao;
import com.example.bysj.pojo.Visitor;
import com.example.bysj.service.VisitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VisitorServiceImpl implements VisitorService {

    @Autowired
    VisitorDao visitorDao;

    @Override
    public List<Visitor> getAllVisitor(String username, String time, int pageStart, int pageSize) {
        return visitorDao.getAllVisitor(username, time, pageStart, pageSize);
    }

    @Override
    public int getVisitorCounts(String username, String time) {
        return visitorDao.getVisitorCounts(username, time);
    }

    @Override
    public int deleteVisitor(String time) {
        return visitorDao.deleteVisitor(time);
    }
}
