package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Movie;

public interface MovieMapper {
	//得到一部电影
	Movie getMovieById(int id);
	//得到全部电影数量
	int getAll();
	//分页显示全部电影
	List<Movie> getAllMovie(@Param("page")int page,@Param("sum")int sum);
	//分页显示电影排行
	List<Movie> getAllMovieRank(@Param("page")int page,@Param("sum")int sum);
	//搜索得到电影数量
	int getMovies(@Param("name")String name);
	//分页显示搜索电影
	List<Movie> getMovieByName(@Param("name")String name,@Param("page")int page,@Param("sum")int sum);
	//电影类型得到电影数量
	int getCountByType(@Param("type") String type);
	//分页显示按照类型的电影
	List<Movie> getMovieByType(@Param("type")String name,@Param("page")int page,@Param("sum")int sum);
	//添加电影
	int insertMovie(Movie movie);
	//更新电影信息
	int updateMovie(Movie movie);
	//更新电影播放次数
	int updatetimes(@Param("times")int times,@Param("id")int id);
}
