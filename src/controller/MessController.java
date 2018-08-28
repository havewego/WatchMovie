package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Mess;
import pojo.Movie;
import pojo.User;
import service.IUserService;

@Controller
public class MessController {
	@Autowired
	private IUserService userservice;
	/**
	 * 添加评论
	 * @param text
	 * @param session
	 * @return
	 */
	@RequestMapping("/addcontent")
	public String addcontent(String text,int movieid,HttpSession session) {
		int userid = 0;
		try {
			userid = (int) session.getAttribute("userid");
		} catch (Exception e) {
			e.getMessage();
			return "error";
		}
		//int movieid = (int) session.getAttribute("movieid");
		Mess mess = new Mess();
		mess.setMovieid(movieid);
		mess.setUserid(userid);
		mess.setText(text);
		userservice.addMess(mess);
		return "forward:/showmoviecontent?page=1";
	}
	/**
	 * 页面初始时展示的第一页留言，或者添加评论后的第一页评论
	 * @param session
	 * @return
	 */
	@RequestMapping("/showmoviecontent")
	@ResponseBody
	public String showmoviecontent(int page,int movieid) {
		System.out.println(page);
		//int userid = (int) session.getAttribute("userid");
		//int movieid = (int) session.getAttribute("movieid");
		List<Mess> messes = userservice.getMessByMovie(movieid, page);
		int count = userservice.getMessCount(movieid);
		int pages;//页数
		if (count % Mess.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Mess.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Mess.PAGE_SIZE + 1; // 对总页数赋值
        }
		//拼接留言
		StringBuffer sb = new StringBuffer();//实例化StringBuffer
		for (Mess mess : messes) {
			User user = userservice.getUser(mess.getUserid());
			sb.append("<div class='comment-content' style=\"margin-top: 30px;min-height:100px;\">");
			sb.append("<div class=\"comment-user-avatar\">");
			if(user.getPic()==null) {
				sb.append("<a href=\"//i.youku.com/i/UNDk3MTk3OTY5Mg==\" ><img src=\"/WatchMovie/WatchMovie/image/User/public.jpg\" style=\"width: 80px;height: 80px;border-radius: 50%;\"></a></div>");
			}else {
				sb.append("<a href=\"//i.youku.com/i/UNDk3MTk3OTY5Mg==\" ><img src=\"/WatchMovie/WatchMovie/image/User/"+user.getPic()+"\" style=\"width: 80px;height: 80px;border-radius: 50%;\"></a></div>");
			}
			sb.append("<div class=\"comment-section\" style=\"margin-left: 100px\"><div class=\"comment-user-info\">");
			sb.append("<a href=\"#\" class=\"redname\" style=\"color: orange;\">"+user.getName()+"</a></div>");
			sb.append("<div class=\"comment-text\"><p>"+mess.getText()+"</p></div></div></div>");
			sb.append("<hr color=\"gray\">");
		}
		//拼接翻页
		sb.append("<center style=\"position:absolute;bottom: 0;width: 100%;\"><div class=\"pagination\" id=\"page\">");
		for (int i = 1; i <= pages; i++) {
			if(i==page) {
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				//sb.append("<a href='#' onclick=\"jump("+i+")\" class='page gradient'>"+i+"</a>");
				sb.append("<button style=\"line-height: 24px;ertical-align: middle;\" onclick=\"jump("+i+")\"  class=\"page gradient\">"+i+"</button>");
			}
		}
		sb.append("</div></center>");	
		return sb.toString();
	}
	/**
	 * 分页显示所有评论
	 * @param page
	 * @return
	 */
	@RequestMapping("/showAllMess")
	@ResponseBody
	public String showAllMess(int page) {
		List<Mess> messes = userservice.getAllMess(page);
		int count = userservice.getAllMessCount();
		int pages;//页数
		if (count % Mess.PAGE_SIZE == 0) { // 计算总页数,总记录数和每页显示的数
            pages = count / Mess.PAGE_SIZE; // 对总页数赋值
        } else {
            pages = count / Mess.PAGE_SIZE + 1; // 对总页数赋值
        }
		StringBuffer sb = new StringBuffer();
		//sb.append("<table class=\"table table-striped\"><thead><tr><th>电影ID</th><th>评论详情</th><th>用户ID</th></tr></thead><tbody>");
		sb.append("<table class=\"table table-striped\"><thead><tr><th>电影名字</th><th>评论详情</th><th>用户ID</th></tr></thead><tbody>");
		for (Mess mess : messes) {
			int movieid = mess.getMovieid();
			Movie movie = userservice.getMovieById(movieid);
			//sb.append("<tr><td>"+mess.getMovieid()+"</td><td>"+mess.getText()+"</td><td>"+mess.getUserid()+"</td></tr>");
			sb.append("<tr><td>"+movie.getName()+"</td><td>"+mess.getText()+"</td><td>"+mess.getUserid()+"</td></tr>");
		}
		sb.append("</tbody></table>");
		//拼接翻页
		sb.append("<center style=\"position:absolute;bottom: 0;width: 100%;\"><div class=\"pagination\" >");
		for (int i = 1; i <= pages; i++) {
			if(i==page) {
				sb.append("<span class='page active'>"+i+"</span>");
			}else {
				sb.append("<button onclick=\"jumpMess("+i+")\" class='page gradient'>"+i+"</button>");
			}
		}
		sb.append("</div></center>");
		return sb.toString();
		
	}
	
}
