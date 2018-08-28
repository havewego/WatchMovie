package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MessMapper;
import dao.MovieMapper;
import dao.UserMapper;
import pojo.Admin;
import pojo.Mess;
import pojo.Movie;
import pojo.User;
import service.IUserService;
@Service
public class UserService implements IUserService {
	@Autowired
	UserMapper usermapper;
	@Autowired
	MessMapper messmapper;
	@Autowired
	MovieMapper moviemapper;
	//添加用户
	@Override
	public int addUser(User user) {
		// TODO Auto-generated method stub
		return usermapper.insertUser(user);
	}
	//更新用户信息
	@Override
	public int updateUser(User user) {
		// TODO Auto-generated method stub
		return usermapper.updateUser(user);
	}
	//得到用户信息
	@Override
	public User getUser(int id) {
		// TODO Auto-generated method stub
		return usermapper.getUser(id);
	}
	//添加评论
	@Override
	public int addMess(Mess mess) {
		// TODO Auto-generated method stub
		return messmapper.insertMess(mess);
	}
	//删除评论
	@Override
	public int delMess(int id) {
		// TODO Auto-generated method stub
		return messmapper.deleteMess(id);
	}
	//按照电影id得到评论数量
	@Override
	public int getMessCount(int movieid) {
		// TODO Auto-generated method stub
		return messmapper.getMessCount(movieid);
	}
	//得到某一页的电影评论
	@Override
	public List<Mess> getMessByMovie(int movieid, int page) {
		// TODO Auto-generated method stub
		return messmapper.getMess(movieid, (page - 1) * Mess.PAGE_SIZE, Mess.PAGE_SIZE);
	}
	//按照用户id得到评论
	@Override
	public int getMessByUserCount(int userid) {
		// TODO Auto-generated method stub
		return messmapper.getMessByUserCount(userid);
	}
	//得到某一页的用户评论
	@Override
	public List<Mess> getMessByUser(int userid, int page) {
		// TODO Auto-generated method stub
		return messmapper.getMessByUser(userid, (page - 1) * Mess.PAGE_SIZE, Mess.PAGE_SIZE);
	}
	//得到按照名字搜索的电影数量
	@Override
	public int getMovie(String name) {
		// TODO Auto-generated method stub
		return moviemapper.getMovies(name);
	}
	//得到某一页的电影，按照名字查找
	@Override
	public List<Movie> getMovieByName(String name, int page) {
		// TODO Auto-generated method stub
		return moviemapper.getMovieByName(name, (page - 1) * Movie.PAGE_SIZE, Movie.PAGE_SIZE);
	}
	//得到所有电影的数量
	@Override
	public int getAll() {
		// TODO Auto-generated method stub
		return moviemapper.getAll();
	}
	//得到某一页的所有电影
	@Override
	public List<Movie> getAllMovie(int page) {
		// TODO Auto-generated method stub
		return moviemapper.getAllMovie((page - 1) * Movie.PAGE_SIZE, Movie.PAGE_SIZE);
	}
	
	//同一类型电影数量
	@Override
	public int getCountByType(String type) {
		// TODO Auto-generated method stub
		return moviemapper.getCountByType(type);
	}
	//分页显示统一类型电影
	@Override
	public List<Movie> getMovieByType(String type, int page) {
		// TODO Auto-generated method stub
		return moviemapper.getMovieByType(type, (page - 1) * Movie.PAGE_SIZE, Movie.PAGE_SIZE);
	}
	
	//得到某一个电影按照id
	@Override
	public Movie getMovieById(int id) {
		// TODO Auto-generated method stub
		return moviemapper.getMovieById(id);
	}
	//得到某一个评论按照id
	@Override
	public Mess getMessById(int id) {
		// TODO Auto-generated method stub
		return messmapper.getMessById(id);
	}
	@Override
	public int updatetimes(int times, int id) {
		// TODO Auto-generated method stub
		return moviemapper.updatetimes(times, id);
	}
	
	//全部评论数量
	@Override
	public int getAllMessCount() {
		// TODO Auto-generated method stub
		return messmapper.getAllMessCount();
	}
	//分页全部评论
	@Override
	public List<Mess> getAllMess(int page) {
		// TODO Auto-generated method stub
		return messmapper.getAllMess((page - 1) * Mess.PAGE_SIZE, Mess.PAGE_SIZE);
	}
	//分页所有电影排行
	@Override
	public List<Movie> getAllMovieRank(int page) {
		// TODO Auto-generated method stub
		return moviemapper.getAllMovieRank((page - 1) * Movie.PAGE_SIZE, Movie.PAGE_SIZE);
	}
	@Override
	public int getAllUserCount() {
		// TODO Auto-generated method stub
		return usermapper.getAllUserCount();
	}
	@Override
	public List<User> getAllUser(int page) {
		// TODO Auto-generated method stub
		return usermapper.getAllUser((page - 1) * User.PAGE_SIZE, User.PAGE_SIZE);
	}
	

}
