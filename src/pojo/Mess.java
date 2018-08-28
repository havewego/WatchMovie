package pojo;

public class Mess {
	public static final int PAGE_SIZE = 8; // Ã¿Ò³¼ÇÂ¼Êý
	private int id;
	private String text;
	private int userid;
	private int movieid;
	public Mess() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Mess(int id, String text, int userId, int movieId) {
		super();
		this.id = id;
		this.text = text;
		this.userid = userId;
		this.movieid = movieId;
	}
	public int getid() {
		return id;
	}
	public void setid(int id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userId) {
		this.userid = userId;
	}
	public int getMovieid() {
		return movieid;
	}
	public void setMovieid(int movieId) {
		this.movieid = movieId;
	}
	@Override
	public String toString() {
		return "Mess [id=" + id + ", text=" + text + ", userId=" + userid + ", movieId=" + movieid + "]";
	}
	
}
