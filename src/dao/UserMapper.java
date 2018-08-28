package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.User;

public interface UserMapper {
	//�õ��û�
	User getUser(int id);
	//������Ϣ
	int updateUser(User user);
	//����
	int insertUser(User user);
	
	//ȫ������Ա����
	int getAllUserCount();
	//�鿴ȫ������Ա
	List<User> getAllUser(@Param("page")int page,@Param("sum")int sum);
}
