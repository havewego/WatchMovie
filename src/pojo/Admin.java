package pojo;

public class Admin {
	public static final int PAGE_SIZE = 8; // Ã¿Ò³¼ÇÂ¼Êý
	private int id;
	private String pwd;
	private String email;
	
	public Admin() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Admin(int id, String pwd, String email) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.email = email;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Admin [id=" + id + ", pwd=" + pwd + ", email=" + email + "]";
	}
	
}
