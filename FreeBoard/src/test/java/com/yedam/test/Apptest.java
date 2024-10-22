package com.yedam.test;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DataSource;
import com.yedam.mapper.ReplyMapper;

public class Apptest {
	public static void main(String[] args) {
		
		SqlSession sqlSession = DataSource.getInstance().openSession();
		ReplyMapper mapper = sqlSession.getMapper(ReplyMapper.class);
		
		
		
/*
		SearchDTO search = new SearchDTO();
		search.setKeyword("HTML");
		search.setSearchCondition("T");
		search.setPage(1);

		List<BoardVO> list = mapper.listWithPage(search);
		for (BoardVO bvo : list) {
			System.out.println(bvo.toString());
		}
*/
		
		
		/*
		 * 
		 * BoardVO bvo = new BoardVO(); bvo.setTitle("mapper테스트1");
		 * bvo.setContent("정상작동1"); bvo.setWriter("user011");
		 */
		// 인서트
		/*
		 * if ( mapper.insertBoard(bvo) == 1) { sqlSession.commit(); }
		 */

		// 업데이트
		/*
		 * bvo.setBoardNo(5); if ( mapper.updateBoard(bvo) == 1) { sqlSession.commit();
		 * }
		 */

		// 딜리트
		/*
		 * bvo.setBoardNo(5); if ( mapper.deleteBoard(bvo.getBoardNo()) == 1) {
		 * sqlSession.commit(); }
		 */

		// selectBoard 상세조회
		/*
		 * bvo.setBoardNo(5); if(mapper.selectBoard(bvo.getBoardNo()) == null) {
		 * System.out.println("조회된 내용이 없습니다"); }
		 * 
		 * //select 전체조회 List<BoardVO> list = mapper.boardList(); for(BoardVO bvo2 :
		 * list) { System.out.println(bvo2.toString()); }
		 */
	}
}
