package com.example.bysj.service.impl;

import com.example.bysj.pojo.LoginRecord;
import com.example.bysj.pojo.PswForm;
import com.example.bysj.pojo.User;
import com.example.bysj.pojo.UserInfo;
import com.example.bysj.dao.UserDao;
import com.example.bysj.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;

    @Override
    public User getUserByMassage(String username, String password) {
        return userDao.getUserByMassage(username,password);
    }

    @Override
    public List<User> getAllUser(String username, int pageStart, int pageSize) {
        return userDao.getAllUser(username,pageStart,pageSize);
    }

    @Override
    public int getUserCounts(String username) {
        return userDao.getUserCounts(username);
    }

    @Override
    public int updateState(Integer id, Boolean state) {
        return userDao.updateState(id,state);
    }

    @Override
    public int addUser(User user) {
        return userDao.addUser(user);
    }

    @Override
    public int deleteUser(int id) {
        return userDao.deleteUser(id);
    }

    @Override
    public User getUpdateUser(int id) {
        return userDao.getUpdateUser(id);
    }

    @Override
    public int editUser(User user) {
        return userDao.editUser(user);
    }

    @Override
    public List<User> getList() {
        return userDao.getList();
    }

    @Override
    public int editRole(String username, int roleId) {
        return userDao.editRole(username,roleId);
    }

    @Override
    public User check(String username) {
        return userDao.check(username);
    }

    @Override
    public int regist(User user) {
        return userDao.regist(user);
    }



    @Override
    public int addLoginRecord(LoginRecord loginRecord) {
        return userDao.addLoginRecord(loginRecord);
    }

    @Override
    public int updateUserInfo(UserInfo userInfo) {
        return userDao.updateUserInfo(userInfo);
    }

    @Override
    public UserInfo queryUserInfo(String username) {
        return userDao.queryUserInfo(username);
    }

    @Override
    public int queryNum(String username) {
        return userDao.queryNum(username);
    }

    @Override
    public int addUserInfo(UserInfo userInfo) {
        return userDao.addUserInfo(userInfo);
    }

    @Override
    public User selectByName(String username) {
        return userDao.selectByName(username);
    }



    @Override
    public int editPsw(PswForm pswForm) {
        return userDao.editPsw(pswForm);
    }

    @Override
    public User getUserByUsername(String username) {
        return userDao.getUserByUsername(username);
    }
}
