package 도서관리;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 목록(조회조건), 등록, 수정, 삭제, 단건조회.
public class MemberDao extends DAO{
	//싱글턴 방식.
	private static MemberDao instance = new MemberDao();
	private MemberDao() {}
	public static MemberDao getInstance() {
		return instance;
	}
	
	//Connection, getOpen(), getClose(); 셋다 가지고옴
	//아이디와 비밀번호 확인해서 true 반환/ false 반환
	Member checkMember(String id, String pw) {//반환타입 - 여러값을 반환해야될때는 클래스
		String sql = "select member_name, responsibility from tbl_member " //count는 없더라도 0반환해줌
		           + "where member_id = ? and password = ? ";
		getOpen();
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pw);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				Member member = new Member();
				member.setMemberName(rs.getString("member_name"));
				member.setRespondibility(rs.getString("responsibility"));
				return member;
				/*if(cnt > 0) {//id, pw값이 정상적이면.
					return rs.getString(2);
				}*//* else {
					return false; 예외가 발생하면 if 실행안해서 반환값이 없어서 오류뜸
				}*/
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null; // ""동일.
 	}
	
	//목록조회.
	List<Member> memberList() {
		
		String sql = "select member_id "
		           + "       ,member_name "
				   + "       ,password "
		           + "       , phone "
				   + "       , responsibility "
		           + "       , creation_date "
				   + "from tbl_member " ;
		
		List<Member> result = new ArrayList<>();
		getOpen();
		
		try {
			psmt = conn.prepareStatement(sql);
			
			//ResultSet 객체 - 조회한 데이터를 담는곳
			rs = psmt.executeQuery(); // 조회 : 데이터 변경이 없는것
			while(rs.next()) {  //ResultSet(컬렉션)의 next 메소드 사용
				// 처음에는 데이터 없을때, 다음이 있으면 다음으로 옮겨가고 true를 반환
				Member member = new Member();
				member.setMemeberId(rs.getString("member_id"));
				member.setPassword(rs.getString("password"));
				member.setMemberName(rs.getString("member_name"));
				member.setPhone(rs.getString("phone"));
				member.setRespondibility(rs.getString("responsibility"));
				member.setCreationDate(rs.getDate("creation_date"));
				
				result.add(member);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
		
	}//end memberList()
	
}
