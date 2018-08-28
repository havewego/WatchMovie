package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Mess;

public interface MessMapper {
	//�������
	int insertMess(Mess mess);
	//ɾ������
	int deleteMess(int id);
	//ӰƬ��������
	int getMessCount(int movieid);
	//���ӰƬ����
	List<Mess> getMess(@Param("movieid")int movieid,@Param("page")int page,@Param("sum")int sum);
	//�ҵ���������
	int getMessByUserCount(int userid);
	//�鿴�ҵ�����
	List<Mess> getMessByUser(@Param("userid")int userid,@Param("page")int page,@Param("sum")int sum);
	//ȫ����������
	int getAllMessCount();
	//�鿴ȫ������
	List<Mess> getAllMess(@Param("page")int page,@Param("sum")int sum);
	
	//�õ�һ������
	Mess getMessById(int id);
}
