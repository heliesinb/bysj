package com.example.bysj.dao;

import com.example.bysj.pojo.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuDao {
    public List<MainMenu> getMenus(String username);
    public List<MainMenu> getMainMenus();
    List<MainMenu> getAll();
    List<MainMenu> menuList();
    List<MainMenu> menu();
    int delete(int roleId);
    int add(@Param("roleId")int roleId, @Param("menuId")int menuId);
    List<Integer>  selectMenuByRoleId(@Param("roleId")Integer roleId);


}
