package controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pojo.Admin;
import pojo.Mess;
import pojo.Movie;
import pojo.User;
import service.IAdminService;
import service.IUserService;
import util.MySendMail;

@Controller
public class AdminController {
	@Autowired
	private IUserService userservice;
	@Autowired
	private IAdminService adminservice;
	
	/**
	 * 生成随机数
	 * @param num 位数
	 * @return
	 */
	public static String createRandomNum(int num) {
		String randomNumStr = "";
		for (int i = 0; i < num; i++) {
			int randomNum = (int) (Math.random() * 10);
			randomNumStr += randomNum;
		}
		return randomNumStr;
	}

	//注册管理员
	@RequestMapping("/adminRegister")
	public String adminRegister(Admin admin,Model model) {
		System.out.println(admin);
		int i = adminservice.addAdmin(admin);
		if(i>0) {
			model.addAttribute("mess", "注册成功！");
			return "admin/Login";
		}else {
			model.addAttribute("mess", "注册失败！");
			return "admin/Login";
		}
	}

	// 注册发送邮箱验证码
	@RequestMapping("/sentcode")
	@ResponseBody
	public String sentcode(String email, HttpSession session) {
		String code = createRandomNum(6);
		session.setAttribute("code", code);
		session.setMaxInactiveInterval(180);
		boolean state = MySendMail.sendMail(email, code);
		System.out.println("-------------------" + state);
		System.out.println(state == true);
		if (state == true) {
			return "success";
		} else {
			return "fail";
		}

	}
	//邮箱验证码验证
	@RequestMapping("/judgecode")
	@ResponseBody
	public String judgecode(String code,HttpSession session) {
		String oldcode = (String) session.getAttribute("code");
		if(code.equals(oldcode)) {
			return "success";
		}else {
			return "fail";
		}
	}
	//判断管理员ID
	@RequestMapping("/judgeAdminid")
	@ResponseBody
	public String judgeAdminid(int id) {
		Admin admin = adminservice.getAdmin(id);
		if(admin==null) {
			return "success";
		}else {
			return "fail";
		}
	}
	

	//登陆发送邮箱验证码
	@RequestMapping("/loginsentcode")
	@ResponseBody
	public String loginsentcode(int id,HttpSession session) {
		Admin admin = adminservice.getAdmin(id);
		if(admin==null) {
			return "fail";
		}else {
			String code = createRandomNum(6);
			session.setAttribute("code", code);
			session.setMaxInactiveInterval(180);
			boolean state = MySendMail.sendMail(admin.getEmail(), code);
			System.out.println("-------------------"+state);
			System.out.println(state==true);
			if(state==true) {
				return "success";
			}else {
				return "fail";
			}
		}		
	}
	//管理员登陆
	@RequestMapping("/adminlogin")
	public String adminlogin(int id,String pwd,Model model,HttpSession session) {
		Admin admin = adminservice.getAdmin(id);
		if(admin==null) {
			model.addAttribute("mess", "密码错误！");
			return "admin/Login";
		}
		if(pwd.equals(admin.getPwd())) {
			session.setAttribute("adminid", id);
			model.addAttribute("admin", admin);
			model.addAttribute("adminCount", adminservice.getAllAdminCount());
			model.addAttribute("userCount", userservice.getAllUserCount());
			model.addAttribute("movieCount", userservice.getAll());
			model.addAttribute("messCount", userservice.getAllMessCount());
			return "admin/Index";
		}else {
			model.addAttribute("mess", "密码错误！");
			return "admin/Login";
		}	
	}
	//得到各个信息的数量
	@RequestMapping("/getCount")
	@ResponseBody
	public Map getCount() {
		Map<String, Integer> map = new HashMap<>();
		map.put("adminCount", adminservice.getAllAdminCount());
		map.put("userCount", userservice.getAllUserCount());
		map.put("movieCount", userservice.getAll());
		map.put("messCount", userservice.getAllMessCount());
		return map;
	}
	//管理员退出
	@RequestMapping("/adminExit")
	public String adminExit(HttpSession session) {
		session.invalidate();
		return "admin/Index";
	}
	//跳转到更新电影页面
	@RequestMapping("/goUpdateMovie")
	public String goUpdateMovie(int id,Model model) {
		try {
			Movie movie = userservice.getMovieById(id);
			if(movie==null) {
				return "admin/Index";
			}else {
				model.addAttribute("movie", movie);
				return "admin/UploadMovie";
			}
		} catch (Exception e) {
			e.getMessage();
			return "admin/Index";
		}
	}
	
	//后台显示管理员
	@RequestMapping("/allAdmin")
	@ResponseBody
	public String allAdmin(int page) {
		List<Admin> admins = adminservice.getAllAdmin(page);
		int count = adminservice.getAllAdminCount();
		int pages;//页数
		if (count % Admin.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Admin.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Admin.PAGE_SIZE + 1; // 对总页数赋值
        }
		StringBuffer sb = new StringBuffer();
		sb.append("<table class=\"table table-striped\"><thead><tr><th>管理员ID</th><th>管理员Email</th></tr></thead><tbody>");
		for (Admin admin : admins) {
			sb.append("<tr><td>"+admin.getId()+"</td><td>"+admin.getEmail()+"</td></tr>");
		}
		sb.append("</tbody></table>");
		//拼接翻页
		sb.append("<center style=\"position:absolute;bottom: 0;width: 100%;\"><div class=\"pagination\">");
		for (int i = 1; i <= pages; i++) {
			if(i==page) {
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<button onclick=\"jumpAdmin("+i+")\" class='page gradient'>"+i+"</button>");
			}
		}
		sb.append("</div></center>");
		return sb.toString();
	}
	//后台显示电影的排行
	@RequestMapping("/AdminMovieRank")
	@ResponseBody
	public String AdminMovieRank(int page) {
		List<Movie> movies = userservice.getAllMovieRank(page);
		int count = userservice.getAll();
		int pages;//页数
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Movie.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
        }
		StringBuffer sb = new StringBuffer();
		sb.append("<table class=\"table table-striped\"><thead><tr><th>电影ID</th><th>电影名字</th><th>电影类型</th><th>电影播放次数</th></tr></thead><tbody>");
		for (Movie movie : movies) {
			sb.append("<tr><td>"+movie.getId()+"</td><td>"+movie.getName()+"</td><td>"+movie.getType()+"</td><td>"+movie.getTimes()+"</td></tr>");
		}
		sb.append("</tbody></table>");
		//拼接翻页
		sb.append("<center style=\"position:absolute;bottom: 0;width: 100%;\"><div class=\"pagination\">");
		for (int i = 1; i <= pages; i++) {
			if(i==page) {
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<button onclick=\"jumpMovie("+i+")\" class='page gradient'>"+i+"</button>");
			}
		}
		sb.append("</div></center>");
		return sb.toString();
	}
	
	//后台显示全部电影
	@RequestMapping("/adminAllMovie")
	@ResponseBody
	public String adminAllMovie(int page) {
		List<Movie> movies = userservice.getAllMovie(page);
		int count = userservice.getAll();
		int pages;//页数
		if (count % Movie.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Movie.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // 对总页数赋值
        }
		StringBuffer sb = new StringBuffer();
		sb.append("<div class=\"row-fluid padd-bottom\">");
		for(int i = 0;i < movies.size();i++) {
			if(i==3||i==7) {
				sb.append("<div class=\"span3\"><a href=\"/WatchMovie/goUpdateMovie?id="+movies.get(i).getId()+"\" class=\"thumbnail\">");
				sb.append("<img style=\"height: 250px;width: 100%;\" src=\"/WatchMovie/WatchMovie/image/movie/"+movies.get(i).getPic()+"\"/></a>");
				sb.append("<center><h3><a href=\"/WatchMovie/goUpdateMovie?id="+movies.get(i).getId()+"\">"+movies.get(i).getName()+"</a></h3></center></div></div>");
			}else if(i==4) {
				sb.append("<div class=\"row-fluid padd-bottom\">");
				sb.append("<div class=\"span3\"><a href=\"/WatchMovie/goUpdateMovie?id="+movies.get(i).getId()+"\" class=\"thumbnail\">");
				sb.append("<img style=\"height: 250px;width: 100%;\" src=\"/WatchMovie/WatchMovie/image/movie/"+movies.get(i).getPic()+"\"/></a>");
				sb.append("<center><h3><a href=\"/WatchMovie/goUpdateMovie?id="+movies.get(i).getId()+"\">"+movies.get(i).getName()+"</a></h3></center></div>");
			}else {
				sb.append("<div class=\"span3\"><a href=\"/WatchMovie/goUpdateMovie?id="+movies.get(i).getId()+"\" class=\"thumbnail\">");
				sb.append("<img style=\"height: 250px;width: 100%;\" src=\"/WatchMovie/WatchMovie/image/movie/"+movies.get(i).getPic()+"\"/></a>");
				sb.append("<center><h3><a href=\"/WatchMovie/goUpdateMovie?id="+movies.get(i).getId()+"\">"+movies.get(i).getName()+"</a></h3></center></div>");
			}
		}
		//拼接翻页 <a href="/WatchMovie/goUpdateMovie?id="+movies.get(i).getId()+"">
		sb.append("<center style=\"position:absolute;bottom: 0;width: 100%;\"><div class=\"pagination\">");
		for (int i = 1; i <= pages; i++) {
			if(i==page) {
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<button onclick=\"jumpAllMovie("+i+")\" class='page gradient'>"+i+"</button>");
			}
		}
		sb.append("</div></center>");
		return sb.toString();
	}
	
	//更新电影
	@RequestMapping("/UpdateMovie")
	public String UpdateMovie(Integer uid,String uname,String uintroduction,String uurl,String utype,Part upic,Model model) {
		Movie movie = userservice.getMovieById(uid);
		String filename = upic.getSubmittedFileName();
		//若海报为空，则为以前的
		if("".equals(filename)) {
			filename = movie.getPic();
		}else {
		}
		//若介绍为空，则为以前的
		if("".equals(uintroduction)) {	
		}else {
			movie.setIntroduction(uintroduction);
		}
		movie.setPic(filename);
		movie.setName(uname);
		movie.setType(utype);
		movie.setUrl(uurl);
		try {
			//上传头像
			if(filename.equals(movie.getPic())) {
			}else {
				upic.write("E:/Eclipse project/WatchMovie/WebContent/WatchMovie/image/movie"+File.separator+filename);
			}
			adminservice.updateMovie(movie);
			model.addAttribute("info", "更新成功！");
			return "admin/Index";
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			return "forward:/goUpdateMovie?id="+uid;
		}	
	}
	//上传电影
	@RequestMapping("/UploadMovie")
	public ModelAndView UploadMovie(String name,String introduction,String url,String type,Part pic) {
		ModelAndView mav = new ModelAndView();
		Movie movie = new Movie();
		movie.setName(name);
		movie.setIntroduction(introduction);
		movie.setUrl(url);
		movie.setType(type);
		//获得电影海报图片名
		System.out.println("_______________"+pic);
		String fileName = pic.getSubmittedFileName();
		movie.setPic(fileName);
		try {
			//上传头像
			pic.write("E:/Eclipse project/WatchMovie/WebContent/WatchMovie/image/movie"+File.separator+fileName);
			adminservice.addMovie(movie);
			mav.addObject("info", "上传成功！");
			//model.addAttribute("info", "上传成功！");
			//return "admin/Index";
			mav.setViewName("admin/Index");
			return mav;
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			//model.addAttribute("info", "上传失败！");
			//return "admin/UploadMovie";
			mav.addObject("info", "上传失败！");
			mav.setViewName("admin/UploadMovie");
			return mav;
		}
	}
	
}
