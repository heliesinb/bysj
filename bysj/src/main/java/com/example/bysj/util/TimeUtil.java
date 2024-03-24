package com.example.bysj.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class TimeUtil {
    public static String getTimeNow(String pattern,int num) {
        final LocalDateTime localDate = LocalDateTime.now().plusDays(num);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(pattern);
        return localDate.format(dateTimeFormatter);
    }
}
