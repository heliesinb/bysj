package com.example.bysj.controller;

import com.alibaba.fastjson.JSON;
import com.example.bysj.pojo.ChooseForm;
import com.example.bysj.pojo.Course;
import com.example.bysj.pojo.User;
import com.example.bysj.service.impl.CourseServiceImpl;
import com.example.bysj.service.impl.UserServiceImpl;
import org.jetbrains.annotations.Nullable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;


@RestController
public class CourseController {
    @Resource
    UserServiceImpl userService;
    @Resource
    CourseServiceImpl courseService;

    //所有选题信息
    @RequestMapping("/allCourse")
    public String getAllList(){
        List<Course> allList = courseService.getAllList();
        HashMap<String,Object> data =new HashMap<>();
        data.put("list",allList);
        String s= JSON.toJSONString(data);
        return s;
    }
    //查看管理员或教师的个人选题信息
    @RequestMapping("/courseManage")
    public String courseManage(@RequestBody Course course){
        User user =userService.selectByName(course.getUsername());
        course.setUid(user.getId());
        course.setCname("%"+course.getCname()+"%");
        List<Course> list =courseService.getList(course);
        HashMap<String,Object> data =new HashMap<>();
        data.put("list",list);
        String s= JSON.toJSONString(data);
        return s;
    }
   //新增选题
    @Nullable
    @RequestMapping("/addCourse")
    public String add(@RequestBody Course course){

        System.out.println(course.getUsername());
        System.out.println(userService.selectByName(course.getUsername()));

        course.setUid(userService.selectByName(course.getUsername()).getId());
        course.setStatus(false);
        int i = courseService.addCourse(course);
        return  i>0?"Success":"error";

    }

    //查看待审核选题信息
    @RequestMapping("/verify")
    public String verify(@RequestBody Course course){
        List<Course> courseList =courseService.
                verifyCourse("%"+course.getCname()+"%","%"+course.getUsername()+"%");
        HashMap<String,Object> data =new HashMap<>();
        data.put("list",courseList);
        String s= JSON.toJSONString(data);
        return s;
    }
    //审核成功	
    @RequestMapping("/editCourse")
    public String editCourse(@RequestBody Course course){
        int j= courseService.editCourse(course);
            return j>0?"Success":"error";
    }
    //审核失败
    @RequestMapping("/deleteCourse")
    public String deleteCourse(int cid){
        int i =courseService.deleteCourse(cid);
        return i>0?"Success":"error";
    }

    //查看可选选题信息
    @RequestMapping("/view")
    public String view(@RequestBody Course course){
        String username ="%"+course.getUsername()+"%";
        List<Course> courseList =courseService.view("%"+course.getCname()+"%",username);
        HashMap<String,Object> data =new HashMap<>();
        data.put("list",courseList);
        String s= JSON.toJSONString(data);
        return s;
    }
    //选题
    @Transactional
    @RequestMapping("/chooseCourse")
    public synchronized String chooseCourse(@RequestBody ChooseForm chooseForm){
        if (courseService.checkCourseNum(chooseForm.getCid())<1){   //检查是否冲突，需要人数是否大于1
            return "error";
        }
        int i=courseService.chooseCourse(chooseForm);    //选题
        courseService.editCourseNum(chooseForm.getCid());  //需要人数减一
        return i>0?"Success":"error";
    }

    //查看个人已选的选题信息
    @RequestMapping("/myCourse")
    public String myCourse(@RequestBody ChooseForm chooseForm){
        chooseForm.setCname("%"+chooseForm.getCname()+"%");
        chooseForm.setUsername("%"+chooseForm.getUsername()+"%");
        List<Course> list =courseService.myCourse(chooseForm);
        HashMap<String,Object> data =new HashMap<>();
        data.put("list",list);
        String s= JSON.toJSONString(data);
        return s;
    }
   //退题
    @RequestMapping("/dropCourse")
    @Transactional
    public String dropCourse(@RequestBody ChooseForm chooseForm){
        int i= courseService.dropCourse(chooseForm);
        int j=  courseService.addCourseNum(chooseForm.getCid());
        return i>0||j>0?"Success":"error";
    }
     //查看选题人员名单
    @RequestMapping("/sourceList")
    public  String sourceList(int cid){
        List<User> list =courseService.sourceList(cid);
        HashMap<String,Object> data =new HashMap<>();
        data.put("list",list);
        String s= JSON.toJSONString(data);
        return s;
    }


}
