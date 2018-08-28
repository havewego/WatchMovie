package service;

import java.util.List;

import pojo.Admin;
import pojo.Movie;

public interface IAdminService {
	int addAdmin(Admin admin);
	Admin getAdmin(int id);
	
	//��ӵ�Ӱ
	int addMovie(Movie movie);
	//���µ�Ӱ
	int updateMovie(Movie movie);
	
	//ȫ������Ա��������ҳȫ������Ա
	int getAllAdminCount();
	List<Admin> getAllAdmin(int page);
}
