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
	//����û�
	@Override
	public int addUser(User user) {
		// TODO Auto-generated method stub
		return usermapper.insertUser(user);
	}
	//�����û���Ϣ
	@Override
	public int updateUser(User user) {
		// TODO Auto-generated method stub
		return usermapper.updateUser(user);
	}
	//�õ��û���Ϣ
	@Override
	public User getUser(int id) {
		// TODO Auto-generated method stub
		return usermapper.getUser(id);
	}
	//�������
	@Override
	public int addMess(Mess mess) {
		// TODO Auto-generated method stub
		return messmapper.insertMess(mess);
	}
	//ɾ������
	@Override
	public int delMess(int id) {
		// TODO Auto-generated method stub
		return messmapper.deleteMess(id);
	}
	//���յ�Ӱid�õ���������
	@Override
	public int getMessCount(int movieid) {
		// TODO Auto-generated method stub
		return messmapper.getMessCount(movieid);
	}
	//�õ�ĳһҳ�ĵ�Ӱ����
	@Override
	public List<Mess> getMessByMovie(int movieid, int page) {
		// TODO Auto-generated method stub
		return messmapper.getMess(movieid, (page - 1) * Mess.PAGE_SIZE, Mess.PAGE_SIZE);
	}
	//�����û�id�õ�����
	@Override
	public int getMessByUserCount(int userid) {
		// TODO Auto-generated method stub
		return messmapper.getMessByUserCount(userid);
	}
	//�õ�ĳһҳ���û�����
	@Override
	public List<Mess> getMessByUser(int userid, int page) {
		// TODO Auto-generated method stub
		return messmapper.getMessByUser(userid, (page - 1) * Mess.PAGE_SIZE, Mess.PAGE_SIZE);
	}
	//�õ��������������ĵ�Ӱ����
	@Override
	public int getMovie(String name) {
		// TODO Auto-generated method stub
		return moviemapper.getMovies(name);
	}
	//�õ�ĳһҳ�ĵ�Ӱ���������ֲ���
	@Override
	public List<Movie> getMovieByName(String name, int page) {
		// TODO Auto-generated method stub
		return moviemapper.getMovieByName(name, (page - 1) * Movie.PAGE_SIZE, Movie.PAGE_SIZE);
	}
	//�õ����е�Ӱ������
	@Override
	public int getAll() {
		// TODO Auto-generated method stub
		return moviemapper.getAll();
	}
	//�õ�ĳһҳ�����е�Ӱ
	@Override
	public List<Movie> getAllMovie(int page) {
		// TODO Auto-generated method stub
		return moviemapper.getAllMovie((page - 1) * Movie.PAGE_SIZE, Movie.PAGE_SIZE);
	}
	
	//ͬһ���͵�Ӱ����
	@Override
	public int getCountByType(String type) {
		// TODO Auto-generated method stub
		return moviemapper.getCountByType(type);
	}
	//��ҳ��ʾͳһ���͵�Ӱ
	@Override
	public List<Movie> getMovieByType(String type, int page) {
		// TODO Auto-generated method stub
		return moviemapper.getMovieByType(type, (page - 1) * Movie.PAGE_SIZE, Movie.PAGE_SIZE);
	}
	
	//�õ�ĳһ����Ӱ����id
	@Override
	public Movie getMovieById(int id) {
		// TODO Auto-generated method stub
		return moviemapper.getMovieById(id);
	}
	//�õ�ĳһ�����۰���id
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
	
	//ȫ����������
	@Override
	public int getAllMessCount() {
		// TODO Auto-generated method stub
		return messmapper.getAllMessCount();
	}
	//��ҳȫ������
	@Override
	public List<Mess> getAllMess(int page) {
		// TODO Auto-generated method stub
		return messmapper.getAllMess((page - 1) * Mess.PAGE_SIZE, Mess.PAGE_SIZE);
	}
	//��ҳ���е�Ӱ����
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
