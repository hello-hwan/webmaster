package 도서관리;

import java.util.Date;

// 오라클- 칼럼명 대소문자 구분x member_id ->자바 대소문자 구분 memberId
public class Member {
	//필드
	private String memeberId;
	private String password;
	private String memberName;
	private String phone;
	private String respondibility;
	private Date creationDate;
	
	//Getter, Setter
	public String getMemeberId() {
		return memeberId;
	}
	public void setMemeberId(String memeberId) {
		this.memeberId = memeberId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRespondibility() {
		return respondibility;
	}
	public void setRespondibility(String respondibility) {
		this.respondibility = respondibility;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	
	@Override
	public String toString() {
		return memeberId + password +memberName +phone +respondibility +creationDate;
	}
	
}
