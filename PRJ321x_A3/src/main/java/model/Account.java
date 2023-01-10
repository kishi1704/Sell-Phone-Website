package model;

public class Account {
	private String usr;
	private String pwd;
	private int role; // 0-both admin and user, 1-user, 2-admin
	private String name;
	private String address;
	private String phone;
	private String message;

	public Account() {
		
	}

	public Account(String usr, String pwd, int role, String name, String address, String phone) {
		this.usr = usr;
		this.pwd = pwd;
		this.role = role;
		this.name = name;
		this.address = address;
		this.phone = phone;
	}

	public String getUsr() {
		return usr;
	}

	public void setUsr(String usr) {
		this.usr = usr;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	
	public String getMessage() {
		return message;
	}
	
	public boolean validate() {
		String regexMail = "^[A-Z0-9_a-z]+@[A-Z0-9\\.a-z]+\\.[A-Za-z]{2,6}$";
		String regex = "[a-zA-Z0-9_!@#$%^&*]+";
		
		if(usr.equals("") || pwd.equals("")) {
			message = "No username or password set";
			return false;
		}
		
		if(!usr.matches(regexMail) || !pwd.matches(regex)) {
			message = "Invalid username or password";
			return false;
		}
		return true;
	}
	
	public boolean registerValidate() {
		if(name.equals("")) {
			message = "No user's fullname set";
			return false;
		}
		
		if(phone.length() > 10) {
			message = "Invalid phone number";
			return false;
		}
		
		return validate();
	}

}
