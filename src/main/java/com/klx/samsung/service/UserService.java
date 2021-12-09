package com.klx.samsung.service;

import com.klx.samsung.dao.UserMapper;
import com.klx.samsung.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    /**
     * 根据用户名和密码查询用户
     *
     * @param username 用户名
     * @param password 密码
     * @return 返回用户对象
     */
    public User getUserByNameAndPass(String username, String password) {
        return userMapper.getUserByNameAndPass(username, password);
    }

    public User getUserByNameAndPassWhitCartItem(String username, String password) {
        return userMapper.getUserByNameAndPassWhitCartItem(username, password);
    }

    /**
     * 管理员查询所有用户
     *
     * @return 返回用户纪录
     */
    public List<User> getAllUser() {
        return userMapper.getAllUser();
    }


    /**
     * 根据角色查询用户
     *
     * @param role 角色 1：管理员 2：超级管理员 0：普通用户
     * @return 返回用户纪录
     */
    public List<User> getUserByRole(Integer role) {
        return userMapper.getUserByRole(role);
    }

    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 返回用户纪录
     */
    public User getUserByName(String username) {
        return userMapper.getUserByName(username);
    }

    /**
     * 添加用户
     *
     * @param user 用户
     */
    public int addUser(User user) {
        return userMapper.addUser(user);
    }

    /**
     * 根据用户id删除用户
     *
     * @param uid 用户id
     * @return 返回执行结果
     */
    public int deleteUserById(Integer uid) {
        return userMapper.deleteUserById(uid);
    }

    /**
     * 根据id查询用户
     *
     * @param uid 用户id
     * @return 返回用户纪录
     */
    public User getUserById(Integer uid) {
        return userMapper.getUserById(uid);
    }

    /**
     * 设置管理员
     *
     * @param uid 用户id
     * @return 返回数据库执行结果
     */
    public int setRole(Integer uid, Integer role) {
        return userMapper.setRole(uid, role);
    }


    /**
     * 更新用户
     * @param user user
     * @return 返回数据库执行结果
     */
    public int updateUser(User user){
        return userMapper.updateUser(user);
    }
}
