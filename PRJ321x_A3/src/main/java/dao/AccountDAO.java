package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import context.DBContext;
import model.Account;

public class AccountDAO {

	public boolean exist(String username) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "select count(*) as count from Account where user_mail like ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, "%" + username + "%");

		ResultSet rs = stmt.executeQuery();
		int count = 0;

		while(rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		conn.close();

		if (count != 1) {
			return false;
		}

		return true;
	}

	public Account getAccount(String username) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "select * from Account where user_mail like ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, "%" + username + "%");

		ResultSet rs = stmt.executeQuery();
		
		Account acc = null;
		
		if(rs.next()) {
			acc = new Account(rs.getString("user_mail"), rs.getString("password"), rs.getInt("account_role"), rs.getString("user_name"), rs.getString("user_address"), rs.getString("user_phone"));
		}
		
		rs.close();
		
		conn.close();
		return acc;
		
	}
	
	public void insertAccount(Account acc) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "insert into Account(user_mail, password, account_role, user_name, user_address, user_phone)\r\n"
				+ "values(?, ?, ?, ?, ?, ?)";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, acc.getUsr());
		stmt.setString(2, acc.getPwd());
		stmt.setInt(3, acc.getRole());
		stmt.setString(4, acc.getName());
		stmt.setString(5, acc.getAddress());
		stmt.setString(6, acc.getPhone());

		int affectedRows = stmt.executeUpdate();
		
		if (affectedRows == 0) {
			throw new SQLException("Create account failed");
		}
		
		stmt.close();
		
		conn.close();
	}

}
