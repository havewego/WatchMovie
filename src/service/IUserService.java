package service;

import java.util.List;

import pojo.Admin;
import pojo.Mess;
import pojo.Movie;
import pojo.User;

public interface IUserService {
	
	int addUser(User user);
	int updateUser(User user);
	User getUser(int id);
	//全部用户数量，分页全部用户
	int getAllUserCount();
	List<User> getAllUser(int page);
	
	//添加留言
	int addMess(Mess mess);
	//删除留言
	int delMess(int id);
	//电影评论数量，分页电影评论
	int getMessCount(int movieid);
	List<Mess> getMessByMovie(int movieid,int page);
	//用户评论数量，分页用户评论
	int getMessByUserCount(int userid);
	List<Mess> getMessByUser(int userid,int page);
	//全部评论数量，分页全部评论
	int getAllMessCount();
	List<Mess> getAllMess(int page);
	
	//搜索电影数量,分页搜索电影
	int getMovie(String name);
	List<Movie> getMovieByName(String name,int page);
	//得到所有电影数量,分页所有电影
	int getAll();
	List<Movie> getAllMovie(int page);
	//分页所有电影排行
	List<Movie> getAllMovieRank(int page);
	//同一类型电影数量，分页显示统一类型电影
	int getCountByType(String type);
	List<Movie> getMovieByType(String type,int page);
	//得到一部电影
	Movie getMovieById(int id);
	//得到一条评论
	Mess getMessById(int id);
	//更新电影播放次数
	int updatetimes(int times,int id);
}
