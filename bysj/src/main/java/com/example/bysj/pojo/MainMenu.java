package com.example.bysj.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

//主导航
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MainMenu {
    private int id;
    private String title;
    private String path;
    List<SubMenu> slist;



}
