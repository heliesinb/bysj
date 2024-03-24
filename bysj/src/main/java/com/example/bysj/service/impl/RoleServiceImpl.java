package com.example.bysj.service.impl;

import com.example.bysj.dao.RoleDao;
import com.example.bysj.pojo.Role;
import com.example.bysj.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    RoleDao roleDao;

    @Override
    public List<Role> getRole(String rolename) {
        return roleDao.getRole(rolename);
    }

    @Override
    public List<Role> getAllRole() {
        return roleDao.getAllRole();
    }

    @Override
    public int addRole(Role role) {
        return roleDao.addRole(role);
    }

    @Override
    public int delete(int roleId) {
        return roleDao.delete(roleId);
    }

    @Override
    public int changeStatus(int roleId) {
        return roleDao.changeStatus(roleId);
    }

    @Override
    public int editUser(Role role) {
        return roleDao.editUser(role);
    }

    @Override
    public Role getUpdateRole(int roleId) {
        return roleDao.getUpdateRole(roleId);
    }
}
