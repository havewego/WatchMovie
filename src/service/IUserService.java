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
	//ȫ���û���������ҳȫ���û�
	int getAllUserCount();
	List<User> getAllUser(int page);
	
	//�������
	int addMess(Mess mess);
	//ɾ������
	int delMess(int id);
	//��Ӱ������������ҳ��Ӱ����
	int getMessCount(int movieid);
	List<Mess> getMessByMovie(int movieid,int page);
	//�û�������������ҳ�û�����
	int getMessByUserCount(int userid);
	List<Mess> getMessByUser(int userid,int page);
	//ȫ��������������ҳȫ������
	int getAllMessCount();
	List<Mess> getAllMess(int page);
	
	//������Ӱ����,��ҳ������Ӱ
	int getMovie(String name);
	List<Movie> getMovieByName(String name,int page);
	//�õ����е�Ӱ����,��ҳ���е�Ӱ
	int getAll();
	List<Movie> getAllMovie(int page);
	//��ҳ���е�Ӱ����
	List<Movie> getAllMovieRank(int page);
	//ͬһ���͵�Ӱ��������ҳ��ʾͳһ���͵�Ӱ
	int getCountByType(String type);
	List<Movie> getMovieByType(String type,int page);
	//�õ�һ����Ӱ
	Movie getMovieById(int id);
	//�õ�һ������
	Mess getMessById(int id);
	//���µ�Ӱ���Ŵ���
	int updatetimes(int times,int id);
}
