package test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import pojo.Admin;
import pojo.Mess;
import pojo.Movie;
import pojo.User;
import service.IAdminService;
import service.IUserService;

class Test {
	ApplicationContext context;
	@Autowired
	IUserService userservice;
	@Autowired
	IAdminService adminservice;
	@BeforeEach
	void set () {
		context = new ClassPathXmlApplicationContext("bean.xml");
		userservice = (IUserService)context.getBean("userService");
		adminservice = (IAdminService)context.getBean("adminService");
		
	}
	@org.junit.jupiter.api.Test
	void testSql () {
		/*System.out.println(userservice);
		System.out.println(userservice.getAllMovie(1));
		System.out.println(userservice.getAll());*/
		/*System.out.println(userservice.getMessByUserCount(0));
		System.out.println(userservice.getMessByUser(0, 1));*/
		/*System.out.println(userservice.getMovie("h"));
		System.out.println(userservice.getMovieByName("h", 1));*/
		/*User user = new User(3,"123","123","123",123,"123");
		userservice.addUser(user);*/
		/*User user = new User(3,"1","1","123",123,"123");
		userservice.updateUser(user);*/
		//userservice.delMess(1);
		//userservice.addMess(new Mess(1,"hshs",0,1));
		/*System.out.println(userservice.getMessCount(0));
		System.out.println(userservice.getMessByMovie(0, 1));*/
		//adminservice.addAdmin(new Admin(2, "123"));
		//System.out.println(adminservice.);
		//System.out.println(adminservice.addAdmin(new Admin(4, "123")));
		//System.out.println(adminservice.getAdmin(4));
		//System.out.println(adminservice.addMovie(new Movie(15, "15", "153", "1534", "5413", "5135")));
		//System.out.println(userservice.getMovieByType("¶¯×÷", 2));
		/*int times = userservice.getMovieById(1).getTimes();
		times ++;
		userservice.updatetimes(times, 1);
		System.out.println(userservice.getMovieById(1).getTimes());*/
	}

}
