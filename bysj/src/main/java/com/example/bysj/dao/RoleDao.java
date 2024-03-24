package com.example.bysj.dao;

import com.example.bysj.pojo.Role;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleDao {
    List<Role> getRole(String rolename);
    List<Role> getAllRole();

    int addRole(Role role);
    int delete(int roleId);
    int changeStatus(int roleId);

    //修改
    public int editUser(Role role);
    public Role getUpdateRole(int roleId);
}
