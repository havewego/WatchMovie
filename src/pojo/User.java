package pojo;

public class User {
	public static final int PAGE_SIZE = 8; // Ã¿Ò³¼ÇÂ¼Êý
	private int id;
	private String name;
	private String pwd;
	private String email;
	private String phone;
	private String pic;
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(int id, String name, String pwd, String email, String phone,String pic) {
		super();
		this.id = id;
		this.name = name;
		this.pwd = pwd;
		this.email = email;
		this.phone = phone;
		this.pic = pic;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", pwd=" + pwd + ", email=" + email + ", phone=" + phone + ", pic="
				+ pic + "]";
	}
	
}
