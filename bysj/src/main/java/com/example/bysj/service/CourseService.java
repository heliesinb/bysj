package com.example.bysj.service;

import com.example.bysj.pojo.ChooseForm;
import com.example.bysj.pojo.Course;
import com.example.bysj.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseService {
    List<Course> getAllList();
    List<Course> getList(Course course);
    int addCourse(Course course);

    List<Course>  verifyCourse(@Param("cname") String cname, @Param("username")String username);
    int editCourse(Course course);
    int deleteCourse(int cid);
    List<Course>  view(@Param("cname") String cname, @Param("username")String username);
    int chooseCourse(ChooseForm chooseForm);
    int editCourseNum(int cid);
    List<Course> myCourse(ChooseForm chooseForm);
    int dropCourse(ChooseForm chooseForm);
    int addCourseNum(int cid);
    List<User> sourceList(int cid);

    int checkCourseNum(int cid);
}
