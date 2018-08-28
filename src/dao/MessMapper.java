package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Mess;

public interface MessMapper {
	//添加评论
	int insertMess(Mess mess);
	//删除评论
	int deleteMess(int id);
	//影片评论数量
	int getMessCount(int movieid);
	//获得影片评论
	List<Mess> getMess(@Param("movieid")int movieid,@Param("page")int page,@Param("sum")int sum);
	//我的评论数量
	int getMessByUserCount(int userid);
	//查看我的评论
	List<Mess> getMessByUser(@Param("userid")int userid,@Param("page")int page,@Param("sum")int sum);
	//全部评论数量
	int getAllMessCount();
	//查看全部评论
	List<Mess> getAllMess(@Param("page")int page,@Param("sum")int sum);
	
	//得到一条评论
	Mess getMessById(int id);
}
