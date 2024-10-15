package 도서관리;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAO {
	//Dao 클래스 만드는 이유: 데이터베이스와 java 연결하는 메소드 작성
		//Dao 클래스에서 sql문 작성하고 데이터 베이스에 연동
		//Dao에서 만들어둔 객체를 이용하여 데이터 베이스 자료 추가,제거,수정,조회
		//select, insert , update, delete
		
		//필드
		
		//Connection 변수 만드는 이유?
		// Connection 개체가 url, uid ,upw 정보를 가지고 java db연결
		// url은 jdbc:oracle:thin:@localhost:1521:xe
		// uid = java
		// upw = 1234
		Connection conn = null;
		PreparedStatement psmt;
		ResultSet rs; //조회한 결과를 담는곳 -배열처럼
		
		//메소드
		//1. 연결설정 메소드 (void) 항상반복
		public void getOpen() {
			try {
				Class.forName("oracle.jdbc.OracleDriver");
				//특정 클래스 강제구동 메소드
				//forName은 throws가 있기때문에 try catch문 실행
				//Connection 객체는 new 연산자로 생성불가능
				//DriverManager클래스의 정적메소드 getConnection
				//이거를 사용해서 객체 생성해야됨
				
				conn = DriverManager.getConnection(
						"jdbc:oracle:thin:@localhost:1521:xe",
						"java",
						"1234"
						);
				System.out.println("연결성공");
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		//2. 연결 끊기 메소드 (void) 항상반복
		public void getClose() {
			if(conn != null) {
				try {
					conn.close();
					System.out.println("연결종료");
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
}//end class
