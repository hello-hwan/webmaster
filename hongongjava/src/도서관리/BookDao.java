package 도서관리;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BookDao extends DAO{
	
	//데이터 추가
	//3. insert 메소드
	
	public int insert(Book book) {//인서트할 내용을 객체로 받아와서 처리
		getOpen();// Connection 객체 메소드로 생성 후 db와연결
		try {
			String sql = "insert into book (title, writer, price, bNum) "
					+    "values (?, ?, ?, ?) ";
			//sql문은 무조건 String sql = "sql명령어"
			//?는 무조건 setString(setInt)로 1번부터 차례대로 생성
			//한줄 끝날때 반드시 띄어쓰기할것-안하면 붙여서 쓰는걸로 돼서 오류남
			
			//PreparedStatement = sql문을 실행하기 위한 객체
			//conn객체의 prepareStatement() 메서드로 객체를 받아옴
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, book.getTitle());
			pstmt.setString(2, book.getWriter());
			pstmt.setInt(3, book.getPrice());
			pstmt.setString(4, book.getbNum());
			
			//sql문장 실행
			int rows = pstmt.executeUpdate();
			return rows;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		getClose();
		return 0;
		}
	
	//4. select: 조건에 따른 검색 (책제목)메소드
	public void select(String title) {
		//Connection 객체 conn으로 url, id, pw 연결
		getOpen();
		
		try {
			//squl문 작성
			String sql = "select * " +
						 "from book " +
						 "where title = ? ";
			
			//작성한 sql문을 실행시키기 위한 메소드 PreparedStatement 객체 작성
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			//?를 처리하기 위한 메소드 실행
			pstmt.setString(1,title);
			
			//sql 실행문 
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Book book1 = new Book();
				book1.setTitle(rs.getString(1));
				book1.setWriter(rs.getString(2));
				book1.setPrice(rs.getInt(3));
				book1.setbNum(rs.getString(4));
				System.out.println(book1.getTitle() + book1.getWriter() + book1.getPrice() + book1.getbNum());
			}
			rs.close();
			pstmt.close();
			
//			System.out.println(rs);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		getClose();
	}
	
	//5. select: 목록전체 조회 메소드
	public void selectAll() {
		
		getOpen();
		
		String sql = "select * " +
				    "from book ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getString(1) + rs.getString(2) + rs.getInt(3) + rs.getString(4));
			}
			
			rs.close();
			pstmt.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		getClose();
	}
	
	//6. delete 메소드 (북번호 이용)
	
	public void delete(String bNum) {
		
		getOpen();
		String sql = "delete from book " +
				"where bNum = ? ";
		
		PreparedStatement pstmt;
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bNum);
			
			int rows = pstmt.executeUpdate();
			
			if(rows == 1) {
				System.out.println("삭제행 수: " + rows);
			}
			
			pstmt.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		getClose();
		
	}
	
	//7. update 메소드 (책제목의 가격과 책번호 수정)
	
	public void update(String title, int price, String bNum) {
		getOpen();
		
		String sql = "update book " +
		             "set price = ?, bNum = ? " +
				     "where title = " + title ;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, price);
			pstmt.setString(2, bNum);
			
			int rows = pstmt.executeUpdate();
			
			if(rows == 1) {
				System.out.println(rows +" 행 수정되었습니다");
				return;
			}
			rs.close();
			pstmt.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return;
	}
	
}//end class
