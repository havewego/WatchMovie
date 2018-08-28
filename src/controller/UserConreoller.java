package controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import pojo.Movie;
import pojo.User;
import service.IUserService;

@Controller
public class UserConreoller {
	@Autowired
	private IUserService userservice;
	
	
	//获得头像
	@RequestMapping("/getHeadpic")
	@ResponseBody
	public String getHeadpic(int id,HttpSession session) {
		if(id==0) {//其他页面获得头像
			try {
				id = (int) session.getAttribute("userid");
				User user = userservice.getUser(id);
				if(user==null) {
					return "<img src=\"/WatchMovie/WatchMovie/image/User/public.jpg\" style='height:80px;width:80px;border-radius: 50%'>";
				}else {
					if(user.getPic()==null) {
						return "<img src=\"/WatchMovie/WatchMovie/image/User/public.jpg\" style='height:80px;width:80px;border-radius: 50%'>";
					}
					return "<img src=\"/WatchMovie/WatchMovie/image/User/"+user.getPic()+"\" style='height:80px;width:80px;border-radius: 50%'>";
				}
			} catch (Exception e) {
				e.getMessage();
				return "<img src=\"/WatchMovie/WatchMovie/image/User/public.jpg\" style='height:80px;width:80px;border-radius: 50%'>";
			}
			
		}else {//登陆页面获得头像
			User user = userservice.getUser(id);
			if(user==null) {
				return "<img src=\"/WatchMovie/WatchMovie/image/User/public.jpg\" style='height:80px;width:80px;border-radius: 50%'>";
			}else {
				if(user.getPic()==null) {
					return "<img src=\"/WatchMovie/WatchMovie/image/User/public.jpg\" style='height:80px;width:80px;border-radius: 50%'>";
				}
				return "<img src=\"/WatchMovie/WatchMovie/image/User/"+user.getPic()+"\" style='height:80px;width:80px;border-radius: 50%'>";
			}
		}
			
	}
	//获得用户
	@RequestMapping("/getUser")
	@ResponseBody
	public User getUser(HttpSession session) {
		User user;
		try {
			int id = (int) session.getAttribute("userid");
			user = userservice.getUser(id);
			return user;
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			return null;
		}
	}
	//登陆
	@RequestMapping("/login")
	public String login(int id,String pwd,Model model,HttpSession session) {
		User user = userservice.getUser(id);
		if(user==null) {
			model.addAttribute("mess", "密码错误！");
			return "app/login";
		}
		if(pwd.equals(user.getPwd())) {
			session.setAttribute("userid", id);
			session.setAttribute("name", user.getName());
			return "app/index";
		}else {
			model.addAttribute("mess", "密码错误！");
			return "app/login";
		}
		
	}
	//退出登陆
	@RequestMapping("/exit")
	public String exit(HttpSession session) {
		session.invalidate();
		return "app/index";
	}
	//判断id是否可用
	@RequestMapping(value="/judgeName"/*,produces="text/html;charset=UTF-8"*/)
	@ResponseBody
	public String judgeName(int id) {
		User user = userservice.getUser(id);
		if(user==null) {
			
			return "<font color='green'>该用户id可用</font>";
		}else {
			return "<font color='red'>该用户id已被注册，重新输入</font>";
		}
	}
	//注册
	@RequestMapping("/register")
	public String register(User user,Model model) {
		System.out.println("头像"+user.getPic());
		int i = userservice.addUser(user);
		if(i>0) {
			model.addAttribute("mess", "注册成功！");
			return "app/login";
		}else {
			model.addAttribute("mess", "注册失败！");
			return "app/login";
		}
	}
	//更新个人信息
	@RequestMapping("/updateinfo")
	public ModelAndView update(Integer id,String name,String email,String phone,Part pic) {
		//System.out.println("+++++++++++++++++++"+id+name+email+phone+pic.getSubmittedFileName());
		ModelAndView mav = new ModelAndView();
		User user = userservice.getUser(id);
		//上传头像
		System.out.println("++++++++++++"+pic);
		String filename = pic.getSubmittedFileName();
		System.out.println("++++++++++++"+filename);
		//System.out.println("-----------------------"+filename);
		if("".equals(filename)) {
			filename = user.getPic();
		}else {
		}
		try {
			if(!filename.equals(user.getPic())) {
				pic.write("E:/Eclipse project/WatchMovie/WebContent/WatchMovie/image/User"+File.separator+filename);
			}else {
			}
			user.setName(name);
			user.setEmail(email);
			user.setPhone(phone);
			user.setPic(filename);
			userservice.updateUser(user);
			mav.setViewName("app/index");
			mav.addObject("mess", "更新成功");	
		} catch (IOException e) {
			mav.setViewName("app/updateinfo");
			mav.addObject("mess", "更新失败");
			e.printStackTrace();
			return mav;
		}
		return mav;
	}
	//更新密码
	@RequestMapping("/updatepwd")
	@ResponseBody
	public String updatapwd(String pwd,String newpwd,HttpSession session) {
		System.out.println("-------------++++++"+pwd+"++++++"+newpwd+"++++++");
		User user;
		try {
			int id = (int) session.getAttribute("userid");
			user = userservice.getUser(id);
			if(user.getPwd().equals(pwd)) {
				user.setPwd(newpwd);
				return "success";
			}else {
				return "fail";
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			return "fail";
		}
	}
	//后台所有用户翻页
	@RequestMapping("/allUser")
	@ResponseBody
	public String allUser(int page) {
		List<User> users = userservice.getAllUser(page);
		int count = userservice.getAllUserCount();
		int pages;//页数
		if (count % User.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / User.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / User.PAGE_SIZE + 1; // 对总页数赋值
        }
		StringBuffer sb = new StringBuffer();
		sb.append("<table class=\"table table-striped\"><thead><tr><th>用户ID</th><th>用户名字</th><th>用户邮箱</th><th>用户电话</th></tr></thead><tbody>");
		for (User user : users) {
			sb.append("<tr><td>"+user.getId()+"</td><td>"+user.getName()+"</td><td>"+user.getEmail()+"</td><td>"+user.getPhone()+"</td></tr>");
		}
		sb.append("</tbody></table>");
		//拼接翻页
		sb.append("<center style=\"position:absolute;bottom: 0;width: 100%;\"><div class=\"pagination\">");
		for (int i = 1; i <= pages; i++) {
			if(i==page) {
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<button onclick=\"jumpUser("+i+")\" class='page gradient'>"+i+"</button>");
			}
		}
		sb.append("</div></center>");
		return sb.toString();
	}
	
	//热门的电影
	@RequestMapping("/hotMovies")
	@ResponseBody
	public String hotMovies(int page) {
		List<Movie> movies = userservice.getAllMovieRank(page);
		int count  = userservice.getAll();
		int pages;
		if(count % Movie.PAGE_SIZE ==0) {  // 计算总页数,总记录数和每页显示的数
			pages = count / Movie.PAGE_SIZE;  // 对总页数赋值
		}else {
			pages = count / Movie.PAGE_SIZE + 1;  // 对总页数赋值
		}
		StringBuffer sb = new StringBuffer();
		sb.append("<ul>");
		for (Movie movie : movies) {
			sb.append("<li><a href=\"/WatchMovie/seemovie?id="+movie.getId()+"\">"+movie.getName()+"</a><span><img src=\"/WatchMovie/WatchMovie/app/images/hot.png\" /></span></li>");
		}
		sb.append("</ul>");
		//拼接翻页 style="position:absolute;bottom: 0;width: 100%;"
		sb.append("<center style=\"bottom: 0;width: 100%;\"><div class=\"pagination\">");
		for (int i = 1; i <= pages; i++) {
			if(i==page) {
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<button style=\"line-height: 24px;ertical-align: middle;\" onclick=\"jumpHotMovie("+i+")\" class='page gradient'>"+i+"</button>");
			}
		}
		sb.append("</div></center>");
		return sb.toString();
	}
	
	//搜索电影
	@RequestMapping("/search")
	@ResponseBody
	public Map search(String name,int page) {
		int count = userservice.getMovie(name);//电影数量
		int pages ;
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Movie.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
        }
		Map<String, Object> map = new HashMap();
		map.put("pages", pages);
		map.put("moviename", name);
		List<Movie> movies = userservice.getMovieByName(name, page);
		map.put("movies", movies);
		return map;
	}
	//观看页面搜索电影
	@RequestMapping("/seesearch")
	public String seesearch(int page,String name,HttpSession session,Model model) {
		int count = userservice.getMovie(name);//电影数量
		int pages ;//总页数
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Movie.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
        }
		//拼接翻页
        StringBuffer sb = new StringBuffer();// 实例化StringBuffer
		for(int i=1;i<=pages;i++) {	 // 通过循环构建分页导航条
			if(i==page) {	// 判断是否为当前页
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<a href=\"looksearch?page="+i+"&name="+name+"\" class='page gradient'>"+i+"</a>");
			}
		}
		List<Movie> movies = userservice.getMovieByName(name, page);
		model.addAttribute("guide", sb.toString());
		model.addAttribute("movies", movies);
		return "app/choose";
	}
	//搜索电影翻页
	@RequestMapping("/looksearch")
	public String looksearch(int page,String name,HttpSession session,Model model) {
		int count = userservice.getMovie(name);//电影数量
		int pages ;//总页数
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Movie.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
        }
		//拼接翻页
        StringBuffer sb = new StringBuffer();// 实例化StringBuffer
		for(int i=1;i<=pages;i++) {	 // 通过循环构建分页导航条
			if(i==page) {	// 判断是否为当前页
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<a href='looksearch?page="+i+"&name="+name+"' class='page gradient'>"+i+"</a>");
			}
		}
		List<Movie> movies = userservice.getMovieByName(name, page);
		model.addAttribute("guide", sb.toString());
		model.addAttribute("movies", movies);
		return "app/choose";
	}
	//全部电影
	@RequestMapping("/allmovie")
	@ResponseBody
	public Map allmovie() {
		int count = userservice.getAll();//电影数量
		int pages ;
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
	        pages = count / Movie.PAGE_SIZE; // 对总页数赋值
	    } else {
	        pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
	    }
		//session.setAttribute("pages", pages);
		List<Movie> movies = userservice.getAllMovie(1);
		Map<String, Object> map = new HashMap();
		map.put("pages", pages);
		map.put("movies", movies);
		return map;
	}
	//全部电影翻页
	@RequestMapping("/lookall")
	public String lookall(int page,Model model) {
		//String name = (String) session.getAttribute("moviename");
		int count = userservice.getAll();//电影数量
		int pages ;//总页数
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Movie.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
        }
		//拼接翻页
        StringBuffer sb = new StringBuffer();// 实例化StringBuffer
		for(int i=1;i<=pages;i++) {	 // 通过循环构建分页导航条
			if(i==page) {	// 判断是否为当前页
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<a href='lookall?page="+i+"' class='page gradient'>"+i+"</a>");
			}
		}
		List<Movie> movies = userservice.getAllMovie(page);
		model.addAttribute("guide", sb.toString());
		model.addAttribute("movies", movies);
		return "app/choose";
	}
	//按照电影类型
	@RequestMapping("/searchtype")
	@ResponseBody
	public Map searchtype(String type, Model model) {
		int count = userservice.getCountByType(type);//电影数量
		int pages ;
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Movie.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
        }
		Map<String, Object> map = new HashMap();
		map.put("pages", pages);
		map.put("movietype", type);
		List<Movie> movies = userservice.getMovieByType(type, 1);
		map.put("movies", movies);
		return map;
	}
	//按照电影类型翻页
	@RequestMapping("/looktype")
	public String looktype(int page,String type,Model model) {
		//String type = (String) session.getAttribute("movietype");
		int count = userservice.getCountByType(type);//电影数量
		int pages ;//总页数
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
	        pages = count / Movie.PAGE_SIZE; // 对总页数赋值
		} else {
	        pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
	    }
		//拼接翻页
	    StringBuffer sb = new StringBuffer();// 实例化StringBuffer
		for(int i=1;i<=pages;i++) {	 // 通过循环构建分页导航条
			if(i==page) {	// 判断是否为当前页
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<a href='looktype?page="+i+"&type="+type+"' class='page gradient'>"+i+"</a>");
			}
		}
		List<Movie> movies = userservice.getMovieByType(type, page);
		model.addAttribute("guide", sb.toString());
		model.addAttribute("movies", movies);
		return "app/choose";
	}	
	//跳转电影信息页面
	@RequestMapping("/seemovie")
	public String seemovie(int id,Model model) {
		//session.setAttribute("movieid", id);
		Movie movie = userservice.getMovieById(id);
		model.addAttribute("movie", movie);
		return "app/movieinfo";
	}
	//播放影片
	@RequestMapping("/play")
	public String play(int id,Model model) {
		Movie movie = userservice.getMovieById(id);
		int times = movie.getTimes();
		times++;
		userservice.updatetimes(times, id);
		model.addAttribute("movie", movie);
		//session.setAttribute("movie", movie);
		return "app/single";
	}
	
}
