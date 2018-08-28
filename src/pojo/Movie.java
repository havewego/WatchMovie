package pojo;

public class Movie {
	public static final int PAGE_SIZE = 8; // Ã¿Ò³¼ÇÂ¼Êý
	private int id;
	private String name;
	private String pic;
	private String url;
	private String type;
	private String introduction;
	private int times;
	public Movie() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Movie(int id, String name, String pic, String url, String type, String introduction, int times) {
		super();
		this.id = id;
		this.name = name;
		this.pic = pic;
		this.url = url;
		this.type = type;
		this.introduction = introduction;
		this.times = times;
	}

	public int getTimes() {
		return times;
	}

	public void setTimes(int times) {
		this.times = times;
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
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	@Override
	public String toString() {
		return "Movie [id=" + id + ", name=" + name + ", pic=" + pic + ", url=" + url + ", type=" + type
				+ ", introduction=" + introduction + ", times=" + times + "]";
	}
	
}
