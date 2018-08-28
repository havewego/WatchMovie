package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Admin;

public interface AdminMapper {
	//�õ�����Ա
	Admin getAdmin(int id);
	//��ӹ���Ա
	int insertAdmin(Admin admin);
	//ȫ������Ա����
	int getAllAdminCount();
	//�鿴ȫ������Ա
	List<Admin> getAllAdmin(@Param("page")int page,@Param("sum")int sum);
}
