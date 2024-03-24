package com.example.bysj.service;

import com.example.bysj.pojo.MainMenu;
import com.example.bysj.pojo.SubMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuService {
    public List<MainMenu> getMenus(String username);
    public List<MainMenu> getMainMenus();
    List<MainMenu> getAll();
    List<MainMenu> menuList();
    List<MainMenu> menu();
    int delete(int roleId);
    int add(@Param("roleId")int roleId, @Param("menuId")int menuId);
    List<Integer>  selectMenuByRoleId(@Param("roleId")Integer roleId);

}
