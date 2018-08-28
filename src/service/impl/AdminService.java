package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AdminMapper;
import dao.MovieMapper;
import pojo.Admin;
import pojo.Mess;
import pojo.Movie;
import service.IAdminService;
@Service
public class AdminService implements IAdminService {
	@Autowired
	AdminMapper adminmapper;
	@Autowired
	MovieMapper moviemapper;
	@Override
	public int addAdmin(Admin admin) {
		return adminmapper.insertAdmin(admin);
	}

	@Override
	public Admin getAdmin(int id) {
		// TODO Auto-generated method stub
		return adminmapper.getAdmin(id);
	}
	//添加电影
	@Override
	public int addMovie(Movie movie) {
		// TODO Auto-generated method stub
		return moviemapper.insertMovie(movie);
	}
	//更新电影
	@Override
	public int updateMovie(Movie movie) {
		// TODO Auto-generated method stub
		return moviemapper.updateMovie(movie);
	}

	@Override
	public int getAllAdminCount() {
		// TODO Auto-generated method stub
		return adminmapper.getAllAdminCount();
	}

	@Override
	public List<Admin> getAllAdmin(int page) {
		// TODO Auto-generated method stub
		return adminmapper.getAllAdmin((page - 1) * Admin.PAGE_SIZE, Admin.PAGE_SIZE);
	}
	

}
