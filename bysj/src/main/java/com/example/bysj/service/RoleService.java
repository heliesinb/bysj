package com.example.bysj.service;

import com.example.bysj.pojo.Role;

import java.util.List;

public interface RoleService {
    List<Role> getRole(String rolename);
    List<Role> getAllRole();

    int addRole(Role role);
    int delete(int roleId);
    int changeStatus(int roleId);

    //修改
    public int editUser(Role role);
    public Role getUpdateRole(int roleId);
}
