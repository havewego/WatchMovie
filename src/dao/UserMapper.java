package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.User;

public interface UserMapper {
	//得到用户
	User getUser(int id);
	//更新信息
	int updateUser(User user);
	//插入
	int insertUser(User user);
	
	//全部管理员数量
	int getAllUserCount();
	//查看全部管理员
	List<User> getAllUser(@Param("page")int page,@Param("sum")int sum);
}
