package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DataSource;
import com.yedam.mapper.MemberMapper;
import com.yedam.vo.MemberVO;

// mysql (insertMember,updateMember) 
// -> oracle (memberInsert, memberUpdate)
public class MemberServiceImpl implements MemberService{
	//인터페이스에 있는 메소드를 구현해야됨
	
	SqlSession sqlSession = DataSource.getInstance().openSession(true);
	MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
	
	@Override
	public boolean addMember(MemberVO member) {
		/*멤버 추가되면 해당되는 테이블마다 다 해줘야됨
		mapper.insertHR();
		mapper.salary();
		*/
		return mapper.insertMember(member) == 1;
	}
	
	@Override
	public boolean retireMember(String memberId) {
		return mapper.deleteMember(memberId) == 1;
	}
	
	@Override
	public List<MemberVO> memberList() {
		return mapper.members();
	}
}
