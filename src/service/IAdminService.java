package service;

import java.util.List;

import pojo.Admin;
import pojo.Movie;

public interface IAdminService {
	int addAdmin(Admin admin);
	Admin getAdmin(int id);
	
	//添加电影
	int addMovie(Movie movie);
	//更新电影
	int updateMovie(Movie movie);
	
	//全部管理员数量，分页全部管理员
	int getAllAdminCount();
	List<Admin> getAllAdmin(int page);
}
