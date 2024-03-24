package com.example.bysj.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

//分支导航
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubMenu {
    private int id;
    private String title;
    private String path;


}
