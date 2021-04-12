package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.EmployeesDto;

public class EmployeesDao {

	// field
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	private String sql;
	private int result;
	
	// (singleton)constructor
	private EmployeesDao() {}
	private static EmployeesDao dao = new EmployeesDao();
	public static EmployeesDao getInstance() {
		return dao;
	}
	
	// 접속
	public Connection getConnetion() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "HR";
		String password = "1111";
		
		return DriverManager.getConnection(url, user, password);
	}
	// 접속 해제
	public void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if (rs != null) rs.close();
			if (ps != null) ps.close();
			if (con != null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
			
	// 부서별 사원 조회
	public List<EmployeesDto> selectEmployeesByDepartmentId(int departmentId) {
		List<EmployeesDto> list = new ArrayList<EmployeesDto>();
		try {
			con = getConnetion();
			sql = "   SELECT e.first_name "
					+ "    , e.LAST_NAME "
					+ "    , d.DEPARTMENT_NAME AS 부서명 "
					+ "    , e.SALARY AS 연봉 "
					+ "    , e.HIRE_DATE AS 입사일 "  // 칼럼과 FROM 분리(띄어쓰기 반드시!)
					+ " FROM DEPARTMENTS d INNER JOIN EMPLOYEES e "
					+ "   ON d.DEPARTMENT_ID = e.DEPARTMENT_ID "
					+ "WHERE e.DEPARTMENT_ID = ? ";
			ps = con.prepareStatement(sql);
			ps.setInt(1, departmentId);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				EmployeesDto dto = new EmployeesDto();
				dto.setFirstName(rs.getString("first_name"));
				dto.setLastName(rs.getNString("LAST_NAME"));
				dto.setDepartmentName(rs.getString("부서명"));  // 별명을 줬다면 '별명'으로 작성해야 한다.
				dto.setSalary(rs.getDouble("연봉"));
				dto.setHireDate(rs.getDate("입사일"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
		}
		return list;
	}
	
	
	
	
	
	
	
}
