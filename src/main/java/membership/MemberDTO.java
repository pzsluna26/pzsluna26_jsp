package membership;

public class MemberDTO {
	//맴버 변수 선언
	private String id;
	private String pass;
	private String name;
	private String regidate;
	
	//맴버 변수멸 게터와 세터
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	@Override
	public String toString() {
		return "MemberDTO [toString()=" + super.toString() + "]";
	}
	
}
