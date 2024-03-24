package com.example.bysj.service.impl;

import com.example.bysj.dao.CourseDao;
import com.example.bysj.pojo.ChooseForm;
import com.example.bysj.pojo.Course;
import com.example.bysj.pojo.User;
import com.example.bysj.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    CourseDao courseDao;

    @Override
    public List<Course> getAllList() {
        return courseDao.getAllList();
    }

    @Override
    public List<Course> getList(Course course) {
        return courseDao.getList(course);
    }

    @Override
    public int addCourse(Course course) {
        return courseDao.addCourse(course);
    }





    @Override
    public List<Course> verifyCourse(String cname, String username) {
        return courseDao.verifyCourse(cname,username);
    }

    @Override
    public int editCourse(Course course) {
        return courseDao.editCourse(course);
    }

    @Override
    public int deleteCourse(int cid) {
        return courseDao.deleteCourse(cid);
    }

    @Override
    public List<Course> view(String cname, String username) {
        return courseDao.view(cname, username);
    }

    @Override
    public int chooseCourse(ChooseForm chooseForm) {
        return courseDao.chooseCourse(chooseForm);
    }



    @Override
    public int editCourseNum(int cid) {
        return courseDao.editCourseNum(cid);
    }

    @Override
    public List<Course> myCourse(ChooseForm chooseForm) {
        return courseDao.myCourse(chooseForm);
    }

    @Override
    public int dropCourse(ChooseForm chooseForm) {
        return courseDao.dropCourse(chooseForm);
    }

    @Override
    public int addCourseNum(int cid) {
        return courseDao.addCourseNum(cid);
    }

    @Override
    public List<User> sourceList(int cid) {
        return courseDao.sourceList(cid);
    }


    @Override
    public int checkCourseNum(int cid) {
        return courseDao.checkCourseNum(cid);
    }
}
