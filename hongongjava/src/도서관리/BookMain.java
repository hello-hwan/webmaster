package 도서관리;

import java.util.Scanner;

public class BookMain {
	
	static Scanner sc = new Scanner(System.in);

	public static void main(String[] args) {
		//도서관리 - 행이 추가되면 1을 받아서 성공, 아니면 실패라고 출력
		
//		MemberDao mdao = new MemberDao();
		
		MemberDao mdao = MemberDao.getInstance(); 
		//싱글턴 방식- 생성자 호출 막고 객체도 생성후 막아서 메소드로 호출 - 서버 메모리 절약
		Member member = null;
		//로그인 체크.
		while(true) {
			System.out.print("아이디를 입력>> ");
			String id =sc.nextLine();
			System.out.print("비밀번호를 입력>> ");
			String pw = sc.nextLine();
			
			//아이디와 비밀번호 확인해서 (where 조건문)
			//정상적인 로그인 되면 "홍길동" 환영메세지
			//권한추가
			
			member = mdao.checkMember(id, pw);
			if(member != null){
				System.out.println(member.getMemberName() +"님 환영합니다");
				break;
			}
			System.out.println("아이디와 비밀번호를 확인하세요!");
			
		}//end of 로그인 체크
		//권한이 User => 도서관리 처리.
		if(member.getRespondibility().equals("User")) {
			bookManage();
		}
		if(member.getRespondibility().equals("Admin")) {
			memberManage();
		}
		//권한이 Admin => 회원관리 처리.
		
	}//end of main
	
	
	static void bookManage() {//도서관리.
		Book book = null;
		BookDao dao = new BookDao();
		boolean run = true;
		int cnt = 0;
		
		//메인메뉴
		while(run) {
			System.out.println("-----------------------------------------------------------");
			System.out.println("1.도서등록 2.도서검색 3.도서전체조회 4.도서삭제 5.도서 정보 변경 6.종료");
			System.out.println("-----------------------------------------------------------");
			System.out.print("선택> ");
			int selNum = Integer.parseInt(sc.nextLine());
			
			switch(selNum) {
			//선택1번: 도서등록
			case 1 :
				System.out.println("-------");
				System.out.println("도서등록");
				System.out.println("-------");
				
				//데이터 베이스에 추가하기 위하여 객체에 값 넣는 작업
				System.out.print("책제목> ");
				String title = sc.nextLine();
				System.out.print("저자> ");
				String writer = sc.nextLine();
				System.out.print("가격> ");
				int price =Integer.parseInt(sc.nextLine());
				System.out.print("책번호> ");
				String bNum = sc.nextLine();
				
				//DateBase에 넣을 객체 생성 (Book 객체)
				book = new Book(title, writer,price,bNum);
				//DataBase에 접근 메소드를 사용하기 위한 객체 생성 (BookDao 객체)
				//DataBase에 조회, 삽입, 수정, 삭제하는 작업
				//여기서는 dao객체의 메소드를 사용하여 book 객체를 넣어서 인트cnt 값으로 반환 
				//select문에서 리턴값을 int로 지정하여서 받을값을 미리 int cnt=0;으로 저장
				cnt = dao.insert(book);
				
				if(cnt == 1) {
					System.out.println("추가성공");
				}else {
					System.out.println("추가실패");
				}
				break;
				
			case 2 :
				//선택2번: 도서검색 - 책 제목으로 검색
				System.out.println("-------");
				System.out.println("도서검색");
				System.out.println("-------");
				System.out.print("도서제목: ");
				
				String bookSel = sc.nextLine();
				dao.select(bookSel);
				break;
				
				//선택3번: 도서전체 조회
			case 3 :
				System.out.println("---------");
				System.out.println("도서전체조회");
				System.out.println("---------");
				
				dao.selectAll();
				break;
				
			case 4 :
				//선택4번: 도서삭제
				System.out.println("------");
				System.out.println("도서삭제");
				System.out.println("------");
				System.out.print("삭제할 도서번호: ");
				String bookNum = sc.nextLine();
				
				dao.delete(bookNum);
				
				break;
				
			case 5 :
				//선택5번: 도서 정보 변경 - 책제목:변경할 책번호, 변경할 책가격입력=> 수정
				System.out.println("------");
				System.out.println("도서가격, 도서번호 변경");
				System.out.println("------");
				
				System.out.print("책제목> ");
				String title1 = sc.nextLine();
				System.out.print("변경할 가격> ");
				int price1 =Integer.parseInt(sc.nextLine());
				System.out.print("변경할 번호> ");
				String bNum1 = sc.nextLine();
				
				dao.update(title1, price1, bNum1);
				break;
				
			case 6 :
				//선택 6번 종료
				System.out.println("연결 종료");
				run = false;
				break;
				
			}
			
		}//end of while.
		
		sc.close();
		
	}// end of 도서관리.
	
	static void memberManage() {//회원관리.
		
		System.out.println("-------");
		System.out.println("멤버 관리");
		System.out.println("-------");
		System.out.println("멤버 이름> ");
		String mName = sc.nextLine();
		
		
		/*
		case 6 :
			//선택 6번 회원목록
			List<Member> list = mdao.memberList();
			
			System.out.println("-------");
			System.out.println("회원목록");
			System.out.println("-------");
			
			for(Member member : list) {
				System.out.println(member.toString());
			}
			break;
			*/
	}//end of 회원관리.
	
}// end of class
