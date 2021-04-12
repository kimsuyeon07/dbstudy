package main;

import java.util.List;
import java.util.Scanner;

import dao.EmployeesDao;
import dto.EmployeesDto;

public class EmployeesHandler {

	// field
	private EmployeesDao dao = EmployeesDao.getInstance();
	private Scanner sc = new Scanner(System.in);
	
	
	// method
	//
	// menu()
	public void menu() {
		System.out.println("======= 회원관리 ======");
		System.out.println("1. 부서별 사원 정보 찾기");
		System.out.println("0. 프로그램 종료");
		System.out.println("=====================");
	}
	// execute()
	public void execute() {
		while (true) {
			menu();
			System.out.print("선택 (0~1) >>> ");
			switch (sc.nextInt()) {
			case 0: System.out.println("프로그램 종료"); return;
			case 1: inquiryByDepartmentId(); break;
			default : System.out.println("잘못된 입력입니다. 다시 입력하세요.");
			}
		}
	}
			
	
	// 부서별 사원 수 조회
	public void inquiryByDepartmentId() {
		System.out.print("부서 번호(10~110) >>> ");
		int departmentId = sc.nextInt();
		
		List<EmployeesDto> list = dao.selectEmployeesByDepartmentId(departmentId);
		System.out.println("총 사원 수 : " + list.size() + "명");
		for (EmployeesDto dto : list) {
			System.out.println(dto);
		}
		
		
		
	}
		
	
	
	
	
}
