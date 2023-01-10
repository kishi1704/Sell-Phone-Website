package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import context.DBContext;
import model.Product;

public class ListProductDAO {

	// return number of all products
	public int countP() throws Exception {
		return countP("", "all");
	}

	// return number of products by product name
	public int countP(String txtSearch, String category) throws Exception {
		Connection conn = new DBContext().getConnection();
		PreparedStatement stmt = null;
		String sql = "";

		// count products query
		if (txtSearch.equals("") && category.equals("all")) {
			sql = "select count(*) as count from Products";
			stmt = conn.prepareStatement(sql);
			
		} else if (category.equals("all")) {
			sql = "select count(*) as count from Products where product_name like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + txtSearch + "%");

		} else if (txtSearch.equals("")) {
			sql = "select count(*) as count from Products where product_brand like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + category + "%");
			
		} else {
			sql = "select count(*) as count from Products where product_name like ? and product_brand like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + txtSearch + "%");
			stmt.setString(2, "%" + category + "%");
		}

		ResultSet rs = stmt.executeQuery();
		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		conn.close();

		return count;
	}

	// return the list of all products
	public List<Product> search(int index, int pageSize) throws Exception {
		return search("", "all", index, pageSize);
	}

	// return the list of products by product name and product brand
	public List<Product> search(String txtSearch, String category, int index, int pageSize) throws Exception {
		Connection conn = new DBContext().getConnection();
		PreparedStatement stmt = null;
		String sql = "";

		// search products query
		if (txtSearch.equals("") && category.equals("all")) {
			sql = "with x as ( select ROW_NUMBER() over (order by product_id) as r\r\n" + ", * from Products)\r\n"
					+ "select * from x where r between ? and ?";

			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, index * pageSize - pageSize + 1);
			stmt.setInt(2, index * pageSize);
		} else if (category.equals("all")) {
			sql = "with x as ( select ROW_NUMBER() over (order by product_id) as r\r\n"
					+ ", * from Products where product_name like ?)\r\n" + "select * from x where r between ? and ?";

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + txtSearch + "%");
			stmt.setInt(2, index * pageSize - pageSize + 1);
			stmt.setInt(3, index * pageSize);
		} else if (txtSearch.equals("")) {
			sql = "with x as ( select ROW_NUMBER() over (order by product_id) as r\r\n"
					+ ", * from Products where product_brand like ?)\r\n" + "select * from x where r between ? and ?";

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + category + "%");
			stmt.setInt(2, index * pageSize - pageSize + 1);
			stmt.setInt(3, index * pageSize);
		} else {
			sql = "with x as ( select ROW_NUMBER() over (order by product_id) as r\r\n"
					+ ", * from Products where product_name like ? and product_brand like ?)\r\n"
					+ "select * from x where r between ? and ?";

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + txtSearch + "%");
			stmt.setString(2, "%" + category + "%");
			stmt.setInt(3, index * pageSize - pageSize + 1);
			stmt.setInt(4, index * pageSize);
		}

		// Get results
		ResultSet rs = stmt.executeQuery();

		List<Product> products = new ArrayList<>();

		while (rs.next()) {
			Product p = new Product(rs.getInt("product_id"), rs.getString("product_name"), rs.getString("product_des"),
					rs.getFloat("product_price"), rs.getString("product_img_source"), rs.getString("product_type"),
					rs.getString("product_brand"), rs.getInt("product_number"));

			products.add(p);
		}

		rs.close();

		conn.close();

		return products;
	}
	
	// Get product by product id
	public Product getProduct(int productId) throws Exception {
		Connection conn = new DBContext().getConnection();
		
		String sql = "select * from Products where product_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, productId);
		
		//Get result
		ResultSet rs = stmt.executeQuery();
		
		Product product = null;
		
		while(rs.next()) {
			product = new Product(rs.getInt("product_id"), rs.getString("product_name"), rs.getString("product_des"),
					rs.getFloat("product_price"), rs.getString("product_img_source"), rs.getString("product_type"),
					rs.getString("product_brand"), rs.getInt("product_number"));
		}
		
		rs.close();

		conn.close();
		return product;
	}

}
