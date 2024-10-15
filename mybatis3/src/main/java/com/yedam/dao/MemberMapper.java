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
}
