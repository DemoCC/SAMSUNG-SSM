package com.klx.samsung.dao;

import com.klx.samsung.domain.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    /**
     * 根据名称和密码查询用户
     *
     * @return 返回一个用户
     */
    User getUserByNameAndPass(@Param("name") String username, @Param("password") String password);

    //带购物车的用户信息
    User getUserByNameAndPassWhitCartItem(@Param("name") String username, @Param("password") String password);

    /**
     * 查询所有用户
     *
     * @return 返回所有用户
     */
    List<User> getAllUser();

    /**
     * 根据角色查询用户
     *
     * @param role 角色  1：管理员 2：超级管理员 0：普通用户
     * @return 返回管理员列表
     */
    List<User> getUserByRole(@Param("role") Integer role);

    /**
     * 通过用户名查询用户
     *
     * @param username 用户名
     * @return 返回用户
     */
    User getUserByName(@Param("name") String username);

    /**
     * 添加（注册）用户
     *
     * @param user 创建一个用户
     */
    int addUser(User user);

    /**
     * 根据id删除用户
     *
     * @param uid 用户id
     */
    int deleteUserById(@Param("id") Integer uid);

    /**
     * 根据id查询用户
     *
     * @param uid 用户id
     * @return 返回用户纪录
     */
    User getUserById(@Param("id") Integer uid);

    /**
     * 更新用户
     *
     * @param user user
     */
    int updateUser(User user);

    /**
     * 设置用户权限
     *
     * @param uid 用户id
     */
    int setRole(@Param("id") Integer uid, @Param("role") Integer role);

    /**
     * 移除用户管理员权限
     *
     * @param uid 用户id
     */
    int removeAdmin(@Param("id") Integer uid);

}
