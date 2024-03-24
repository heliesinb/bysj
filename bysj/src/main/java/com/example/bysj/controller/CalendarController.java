package com.example.bysj.controller;


import com.example.bysj.dao.CalendarDao;
import com.example.bysj.pojo.Calendar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/calendar")
public class CalendarController {

    @Autowired
    CalendarDao calendarDao;

    @GetMapping
    public List<Calendar> list(){
        return calendarDao.findAll();
    }

    @GetMapping("/date")
    public Calendar date(@RequestParam String date){
        return calendarDao.findAllByDate(date);
    }

    @PostMapping
    public void save(@RequestBody Calendar calendar){
        calendarDao.save(calendar);
    }
}
