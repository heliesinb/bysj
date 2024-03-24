package com.example.bysj.dao;

import com.example.bysj.pojo.Calendar;
import org.springframework.data.jpa.repository.JpaRepository;


public interface CalendarDao extends JpaRepository<Calendar, Integer> {

    Calendar findAllByDate(String date);

}
