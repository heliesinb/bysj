package com.example.bysj.pojo;

import lombok.Data;

@Data
public class Notice {
    private int id;
    private String time;
    private String content;
    private boolean state;

}
