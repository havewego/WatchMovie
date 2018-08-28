package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Movie;

public interface MovieMapper {
	//�õ�һ����Ӱ
	Movie getMovieById(int id);
	//�õ�ȫ����Ӱ����
	int getAll();
	//��ҳ��ʾȫ����Ӱ
	List<Movie> getAllMovie(@Param("page")int page,@Param("sum")int sum);
	//��ҳ��ʾ��Ӱ����
	List<Movie> getAllMovieRank(@Param("page")int page,@Param("sum")int sum);
	//�����õ���Ӱ����
	int getMovies(@Param("name")String name);
	//��ҳ��ʾ������Ӱ
	List<Movie> getMovieByName(@Param("name")String name,@Param("page")int page,@Param("sum")int sum);
	//��Ӱ���͵õ���Ӱ����
	int getCountByType(@Param("type") String type);
	//��ҳ��ʾ�������͵ĵ�Ӱ
	List<Movie> getMovieByType(@Param("type")String name,@Param("page")int page,@Param("sum")int sum);
	//��ӵ�Ӱ
	int insertMovie(Movie movie);
	//���µ�Ӱ��Ϣ
	int updateMovie(Movie movie);
	//���µ�Ӱ���Ŵ���
	int updatetimes(@Param("times")int times,@Param("id")int id);
}
