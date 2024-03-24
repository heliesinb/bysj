package com.example.bysj.dao;

        import com.example.bysj.pojo.*;
        import org.apache.ibatis.annotations.Param;
        import org.springframework.stereotype.Repository;

        import java.util.List;

@Repository
public interface UserDao {
    public User getUserByMassage(@Param("username") String username,@Param("password") String password); //@Param("username")注解
    public List<User> getAllUser(@Param("username") String username, @Param("pageStart") int pageStart, @Param("pageSize") int pageSize);
    public int getUserCounts(@Param("username") String username);
    public int updateState(Integer id,Boolean state);
    public int addUser(User user);
    public int deleteUser(int id);
    //修改操作，修改+查询
    public User getUpdateUser(int id);
    public int editUser(User user);

    List<User> getList();
    int editRole(@Param("username")String username,@Param("roleId")int roleId);
    User check(@Param("username") String username);
    int regist(User user);

    //图表
    int countLoginRecord(String time);
    int countPerNum(String time);
    //添加登录的记录
    int addLoginRecord(LoginRecord loginRecord);
    int updateUserInfo(UserInfo userInfo);

    //个人信息
    UserInfo queryUserInfo(String username);
    int queryNum(String username);
    int addUserInfo(UserInfo userInfo);
    User selectByName(String username);

    int editPsw(PswForm pswForm);


    User getUserByUsername(@Param("username") String username);

}
