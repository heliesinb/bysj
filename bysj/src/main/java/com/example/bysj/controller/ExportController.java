package com.example.bysj.controller;

import com.example.bysj.dao.CourseDao;
import com.example.bysj.dao.UserDao;
import com.example.bysj.service.impl.ExportServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@RestController
public class ExportController {
    @Autowired
    UserDao userDao;
    @Autowired
    CourseDao courseDao;
    @Resource
    ExportServiceImpl exportServiceImpl;



    @GetMapping("/exportUser")
    public void exportUser(HttpServletResponse response) throws IOException {
        String s= exportServiceImpl.exportUserExcelBook(response,userDao);
    }

    @GetMapping("/exportCourse")
    public void exportCourse(HttpServletResponse response) throws IOException {
        String s= exportServiceImpl.exportCourseExcelBook(response,courseDao);
    }


}
