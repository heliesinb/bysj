package com.example.bysj.service.impl;

import com.example.bysj.dao.MenuDao;
import com.example.bysj.pojo.MainMenu;
import com.example.bysj.pojo.SubMenu;
import com.example.bysj.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    MenuDao menuDao;

    @Override
    public List<MainMenu> getMenus(String username) {
        return menuDao.getMenus(username);
    }

    @Override
    public List<MainMenu> getMainMenus() {
        return menuDao.getMainMenus();
    }

    @Override
    public List<MainMenu> getAll() {
        return menuDao.getAll();
    }

    @Override
    public List<MainMenu> menuList() {
        return menuDao.menuList();
    }

    @Override
    public List<MainMenu> menu() {
        return menuDao.menu();
    }

    @Override
    public int delete(int roleId) {
        return menuDao.delete(roleId);
    }

    @Override
    public int add(int roleId, int menuId) {
        return menuDao.add(roleId,menuId);
    }

    @Override
    public List<Integer> selectMenuByRoleId(Integer roleId) {
        return menuDao.selectMenuByRoleId(roleId);
    }




}
