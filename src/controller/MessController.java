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
	 * �������
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
	 * ҳ���ʼʱչʾ�ĵ�һҳ���ԣ�����������ۺ�ĵ�һҳ����
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
		int pages;//ҳ��
		if (count % Mess.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / Mess.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / Mess.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		//ƴ������
		StringBuffer sb = new StringBuffer();//ʵ����StringBuffer
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
		//ƴ�ӷ�ҳ
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
	 * ��ҳ��ʾ��������
	 * @param page
	 * @return
	 */
	@RequestMapping("/showAllMess")
	@ResponseBody
	public String showAllMess(int page) {
		List<Mess> messes = userservice.getAllMess(page);
		int count = userservice.getAllMessCount();
		int pages;//ҳ��
		if (count % Mess.PAGE_SIZE == 0) { // ������ҳ��,�ܼ�¼����ÿҳ��ʾ����
            pages = count / Mess.PAGE_SIZE; // ����ҳ����ֵ
        } else {
            pages = count / Mess.PAGE_SIZE + 1; // ����ҳ����ֵ
        }
		StringBuffer sb = new StringBuffer();
		//sb.append("<table class=\"table table-striped\"><thead><tr><th>��ӰID</th><th>��������</th><th>�û�ID</th></tr></thead><tbody>");
		sb.append("<table class=\"table table-striped\"><thead><tr><th>��Ӱ����</th><th>��������</th><th>�û�ID</th></tr></thead><tbody>");
		for (Mess mess : messes) {
			int movieid = mess.getMovieid();
			Movie movie = userservice.getMovieById(movieid);
			//sb.append("<tr><td>"+mess.getMovieid()+"</td><td>"+mess.getText()+"</td><td>"+mess.getUserid()+"</td></tr>");
			sb.append("<tr><td>"+movie.getName()+"</td><td>"+mess.getText()+"</td><td>"+mess.getUserid()+"</td></tr>");
		}
		sb.append("</tbody></table>");
		//ƴ�ӷ�ҳ
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
