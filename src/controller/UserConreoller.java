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
	
	
	//���ͷ��
	@RequestMapping("/getHeadpic")
	@ResponseBody
	public String getHeadpic(int id,HttpSession session) {
		if(id==0) {//����ҳ����ͷ��
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
			
		}else {//��½ҳ����ͷ��
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
	//����û�
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
	//��½
	@RequestMapping("/login")
	public String login(int id,String pwd,Model model,HttpSession session) {
		User user = userservice.getUser(id);
		if(user==null) {
			model.addAttribute("mess", "�������");
			return "app/login";
		}
		if(pwd.equals(user.getPwd())) {
			session.setAttribute("userid", id);
			session.setAttribute("name", user.getName());
			return "app/index";
		}else {
			model.addAttribute("mess", "�������");
			return "app/login";
		}
		
	}
	//�˳���½
	@RequestMapping("/exit")
	public String exit(HttpSession session) {
		session.invalidate();
		return "app/index";
	}
	//�ж�id�Ƿ����
	@RequestMapping(value="/judgeName"/*,produces="text/html;charset=UTF-8"*/)
	@ResponseBody
	public String judgeName(int id) {
		User user = userservice.getUser(id);
		if(user==null) {
			
			return "<font color='green'>���û�id����</font>";
		}else {
			return "<font color='red'>���û�id�ѱ�ע�ᣬ��������</font>";
		}
	}
	//ע��
	@RequestMapping("/register")
	public String register(User user,Model model) {
		System.out.println("ͷ��"+user.getPic());
		int i = userservice.addUser(user);
		if(i>0) {
			model.addAttribute("mess", "ע��ɹ���");
			return "app/login";
		}else {
			model.addAttribute("mess", "ע��ʧ�ܣ�");
			return "app/login";
		}
	}
	//���¸�����Ϣ
	@RequestMapping("/updateinfo")
	public ModelAndView update(Integer id,String name,String email,String phone,Part pic) {
		//System.out.println("+++++++++++++++++++"+id+name+email+phone+pic.getSubmittedFileName());
		ModelAndView mav = new ModelAndView();
		User user = userservice.getUser(id);
		//�ϴ�ͷ��
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
			mav.addObject("mess", "���³ɹ�");	
		} catch (IOException e) {
			mav.setViewName("app/updateinfo");
			mav.addObject("mess", "����ʧ��");
			e.printStackTrace();
			return mav;
		}
		return mav;
	}
	//��������
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
	//��̨�����û���ҳ
	@RequestMapping("/allUser")
	@ResponseBody
	public String allUser(int page) {
		List<User> users = userservice.getAllUser(page);
		int count = userservice.getAllUserCount();
		int pages;//ҳ��
		if (count % User.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / User.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / User.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		StringBuffer sb = new StringBuffer();
		sb.append("<table class=\"table table-striped\"><thead><tr><th>�û�ID</th><th>�û�����</th><th>�û�����</th><th>�û��绰</th></tr></thead><tbody>");
		for (User user : users) {
			sb.append("<tr><td>"+user.getId()+"</td><td>"+user.getName()+"</td><td>"+user.getEmail()+"</td><td>"+user.getPhone()+"</td></tr>");
		}
		sb.append("</tbody></table>");
		//ƴ�ӷ�ҳ
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
	
	//���ŵĵ�Ӱ
	@RequestMapping("/hotMovies")
	@ResponseBody
	public String hotMovies(int page) {
		List<Movie> movies = userservice.getAllMovieRank(page);
		int count  = userservice.getAll();
		int pages;
		if(count % Movie.PAGE_SIZE ==0) {  // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
			pages = count / Movie.PAGE_SIZE;  // ����ҳ����ֵ
		}else {
			pages = count / Movie.PAGE_SIZE + 1;  // ����ҳ����ֵ
		}
		StringBuffer sb = new StringBuffer();
		sb.append("<ul>");
		for (Movie movie : movies) {
			sb.append("<li><a href=\"/WatchMovie/seemovie?id="+movie.getId()+"\">"+movie.getName()+"</a><span><img src=\"/WatchMovie/WatchMovie/app/images/hot.png\" /></span></li>");
		}
		sb.append("</ul>");
		//ƴ�ӷ�ҳ style="position:absolute;bottom: 0;width: 100%;"
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
	
	//������Ӱ
	@RequestMapping("/search")
	@ResponseBody
	public Map search(String name,int page) {
		int count = userservice.getMovie(name);//��Ӱ����
		int pages ;
		if (count % Movie.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / Movie.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		Map<String, Object> map = new HashMap();
		map.put("pages", pages);
		map.put("moviename", name);
		List<Movie> movies = userservice.getMovieByName(name, page);
		map.put("movies", movies);
		return map;
	}
	//�ۿ�ҳ��������Ӱ
	@RequestMapping("/seesearch")
	public String seesearch(int page,String name,HttpSession session,Model model) {
		int count = userservice.getMovie(name);//��Ӱ����
		int pages ;//��ҳ��
		if (count % Movie.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / Movie.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		//ƴ�ӷ�ҳ
        StringBuffer sb = new StringBuffer();// ʵ����StringBuffer
		for(int i=1;i<=pages;i++) {	 // ͨ��ѭ��������ҳ������
			if(i==page) {	// �ж��Ƿ�Ϊ��ǰҳ
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
	//������Ӱ��ҳ
	@RequestMapping("/looksearch")
	public String looksearch(int page,String name,HttpSession session,Model model) {
		int count = userservice.getMovie(name);//��Ӱ����
		int pages ;//��ҳ��
		if (count % Movie.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / Movie.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		//ƴ�ӷ�ҳ
        StringBuffer sb = new StringBuffer();// ʵ����StringBuffer
		for(int i=1;i<=pages;i++) {	 // ͨ��ѭ��������ҳ������
			if(i==page) {	// �ж��Ƿ�Ϊ��ǰҳ
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
	//ȫ����Ӱ
	@RequestMapping("/allmovie")
	@ResponseBody
	public Map allmovie() {
		int count = userservice.getAll();//��Ӱ����
		int pages ;
		if (count % Movie.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
	        pages = count / Movie.PAGE_SIZE; // ����ҳ����ֵ
	    } else {
	        pages = count / Movie.PAGE_SIZE + 1; // ����ҳ����ֵ
	    }
		//session.setAttribute("pages", pages);
		List<Movie> movies = userservice.getAllMovie(1);
		Map<String, Object> map = new HashMap();
		map.put("pages", pages);
		map.put("movies", movies);
		return map;
	}
	//ȫ����Ӱ��ҳ
	@RequestMapping("/lookall")
	public String lookall(int page,Model model) {
		//String name = (String) session.getAttribute("moviename");
		int count = userservice.getAll();//��Ӱ����
		int pages ;//��ҳ��
		if (count % Movie.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / Movie.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		//ƴ�ӷ�ҳ
        StringBuffer sb = new StringBuffer();// ʵ����StringBuffer
		for(int i=1;i<=pages;i++) {	 // ͨ��ѭ��������ҳ������
			if(i==page) {	// �ж��Ƿ�Ϊ��ǰҳ
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
	//���յ�Ӱ����
	@RequestMapping("/searchtype")
	@ResponseBody
	public Map searchtype(String type, Model model) {
		int count = userservice.getCountByType(type);//��Ӱ����
		int pages ;
		if (count % Movie.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / Movie.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / Movie.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		Map<String, Object> map = new HashMap();
		map.put("pages", pages);
		map.put("movietype", type);
		List<Movie> movies = userservice.getMovieByType(type, 1);
		map.put("movies", movies);
		return map;
	}
	//���յ�Ӱ���ͷ�ҳ
	@RequestMapping("/looktype")
	public String looktype(int page,String type,Model model) {
		//String type = (String) session.getAttribute("movietype");
		int count = userservice.getCountByType(type);//��Ӱ����
		int pages ;//��ҳ��
		if (count % Movie.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
	        pages = count / Movie.PAGE_SIZE; // ����ҳ����ֵ
		} else {
	        pages = count / Movie.PAGE_SIZE + 1; // ����ҳ����ֵ
	    }
		//ƴ�ӷ�ҳ
	    StringBuffer sb = new StringBuffer();// ʵ����StringBuffer
		for(int i=1;i<=pages;i++) {	 // ͨ��ѭ��������ҳ������
			if(i==page) {	// �ж��Ƿ�Ϊ��ǰҳ
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
	//��ת��Ӱ��Ϣҳ��
	@RequestMapping("/seemovie")
	public String seemovie(int id,Model model) {
		//session.setAttribute("movieid", id);
		Movie movie = userservice.getMovieById(id);
		model.addAttribute("movie", movie);
		return "app/movieinfo";
	}
	//����ӰƬ
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
