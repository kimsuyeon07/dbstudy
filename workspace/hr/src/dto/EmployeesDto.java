package dto;

import java.sql.Date;

public class EmployeesDto {
	
	
	// field : employees 테이블
	private int depatmentId;
	private String firstName;
	private String lastName;
	private double salary;
	private Date hireDate;

	// field : departments 테이블
	private String departmentName;
	
	
	// getter and setter
	public int getDepatmentId() {
		return depatmentId;
	}
	public void setDepatmentId(int depatmentId) {
		this.depatmentId = depatmentId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public Date getHireDate() {
		return hireDate;
	}
	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	
	
	
	

	// toString()
	@Override
	public String toString() {
		return "[firstName=" + firstName + ", lastName=" + lastName + ", salary=" + salary + ", hireDate="
				+ hireDate + ", departmentName=" + departmentName + "]";
	}
	
	































	
	
	

	
	
	
	
	
	
	
}
