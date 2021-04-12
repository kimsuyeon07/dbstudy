package main;

import java.util.List;
import java.util.Scanner;

import dao.MembersDao;
import dto.MembersDto;

// 비즈니스 로직(bussiness login)
// 
public class MembersHandler {

	// field
	private MembersDao dao = MembersDao.getInstance();
	private Scanner sc = new Scanner(System.in);
	
	
	// method
	private void menu() {
		System.out.println("=== 회원관리 ===");
		System.out.println("0. 프로그램 종료");
		System.out.println("1. 가입");
		System.out.println("2. 탈퇴");
		System.out.println("3. 수정");
		System.out.println("4. 아이디 찾기");
		System.out.println("5. 회원 검색");
		System.out.println("6. 전체 회원 조회");
		System.out.println("==============");
	}
	
	public void execute() {
		while (true) {
			menu();
			System.out.print("선택 (0~) >>> ");
			switch (sc.nextInt()) {
			case 0: System.out.println("프로그램을 종료합니다."); return;
			case 1: join(); break;
			case 2: leave(); break;
			case 3: modify(); break;
			case 4: findID(); break;
			case 5: inquiryMember(); break;
			case 6: inquiryAll(); break;
			default: System.out.println("잘못된 번호입니다. 다시입력하세요.");
			}
		}
	}
	
	
	// join() : 가입
	public void join() {
		// - 사용자 입력받기
		System.out.print("신규 아이디 >>> ");
		String mId = sc.next();
		System.out.print("이메일 >>> ");
		String mEmail = sc.next();
		// 아이디 중복체크
		// 일치하는 mId나 mEmail이 이미 DB에 있으면(doubleCheck()메소드 사용) join()메소드 종료.
		if (dao.doubleCheck(mId, mEmail)) {  
			System.out.println("이미 가입된 정보입니다. 다른 정보로 가입하세요."); return;
		}
		// - 입력받은 값을 DTO로 전달하기
			System.out.print("사용자 명 >>> ");
		String mName = sc.next();
		MembersDto dto = new MembersDto();
		dto.setmId(mId);
		dto.setmName(mName);
		dto.setmEmail(mEmail);
		// MembersDto dto2 = new MembersDto(0L, mId, mName, mEmail, null);  // 0L : mNo타입을 Long타입으로 지정해두었기 때문에.
		// ↑ 가능은 하나, 위의 각각 전달하는 방식을 선호
		
		int result = dao.insertMembers(dto);
		if (result > 0) {
			System.out.println(mId + "님이 가입되었습니다.");
		} else {  // result == 0 인 경우
			System.out.println(mId + "님의 가입이 실패했습니다.");
		}
	}
	
	
	// leave() : 탈퇴
	public void leave() {
		System.out.print("탈퇴할 아이디 >>> ");
		String mId = sc.next();
		
		System.out.print("탈할까요 (y/n) >>> ");
		String yn = sc.next();
		
		if (yn.equalsIgnoreCase("y")) {
			int result = dao.delectMembers(mId);
			if (result > 0) {
				System.out.println(mId + "님이 탈퇴되었습니다. 감사합니다.");
			} else { System.out.println(mId + "님이 탈퇴되지 않았습니다"); }
		} else {
			System.out.println("탈퇴 작업이 취소되었습니다.");
		}
	}
		
	
	// modify() : 정보 수정
	public void modify() {
		System.out.print("수정할 회원 아이디 >>> ");
		String mId = sc.next();
		System.out.print("수정할 이름 >>> ");
		String mName = sc.next();
		System.out.print("수정할 이메일 >>> ");
		String mEmail = sc.next();
		
		MembersDto dto = new MembersDto();
		dto.setmId(mId);
		dto.setmName(mName);
		dto.setmEmail(mEmail);
		
		int result = dao.updateMembers(dto);
		if (result > 0) {
			System.out.println(mId + "님의 정보가 수정되었습니다.");
		} else { 
			System.out.println(mId + "님의 정보 수정이 실패하였습니다."); 
		}
	} 
	
	
	// findId() : 아이디 찾기
	public void findID() {
		System.out.print("가입 이메일 입력 >>> ");
		String mEmail = sc.next();
		
		String mId = dao.findmIdBymEmail(mEmail);
		if (mId != null) {
			System.out.println("아이디는 " + mId + "입니다.");
		} else {
			System.out.println("일치하는 정보가 없습니다.");
		}
	}
	
	
	// inquiryMember() : 회원 검색
	public void inquiryMember() {
		System.out.print("조회할 회원 아이디 >>> ");
		String mId = sc.next();
		
		MembersDto dto = dao.selectMembersDtoMymId(mId);
		if (dto != null) {
			System.out.println("조회결과 : " + dto);
		} else {
			System.out.println(mId + "아이디를 가진 회원이 없습니다.");
		}
	}
	
	
	// inquiryAll() : 전체 회원 조회
	public void inquiryAll() {
		List<MembersDto> list = dao.selectMembersList();
		System.out.println("전체 회원 수 : " + list.size() + "명");
		// 출력
		for (MembersDto dto : list) {
			System.out.println(dto);
		}
	}
	
	
	
	
	
	
	
	
		
	
	
}
