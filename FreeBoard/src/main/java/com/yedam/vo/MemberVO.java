package com.yedam.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
// lombok 활용
// 1.이클립스에 lombok 설치 2. 라이브러리 설치
// 롬복 어노테이션으로 사용 // 이클립스 경로에 한글이 있으면 안됨
//위치는 멤버 아래 c 멤버 아래 게터, 세터, 투스트링 만들어져 있음
@Getter
@Setter
@ToString
public class MemberVO {//밸류오브젝트
	private String memberId;
	private String password;
	private String memberName;
	private String phone;
	private String responsibility;
	private Date creationDate; //자바 유틸 데이트 임포트
	
}
