package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Admin;

public interface AdminMapper {
	//得到管理员
	Admin getAdmin(int id);
	//添加管理员
	int insertAdmin(Admin admin);
	//全部管理员数量
	int getAllAdminCount();
	//查看全部管理员
	List<Admin> getAllAdmin(@Param("page")int page,@Param("sum")int sum);
}
