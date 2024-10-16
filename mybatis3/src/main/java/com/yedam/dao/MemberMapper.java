package com.yedam.dao;

import java.util.List;

import com.yedam.vo.Member;

//인터페이스는 기능정의.
//기능구현은 구현클래스로 실행.
public interface MemberMapper {
	public List<Member> members();
	public int insertMember(Member member);
	public int updateMember(Member member);
	public int deleteMember(String memberId);
	
	//8번 직접 타자 침
	public Member selectMember(String memberId); //단건조회
	//9번 membermapperxml로 이동
	//10번 member control
}
