package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import context.DBContext;
import model.Account;
import model.Cart;
import model.Orders;
import model.ProductOrders;

public class OrdersDAO {

	public Orders createOrder(Account acc) throws Exception {
		Connection conn = new DBContext().getConnection();

		Date date = new Date(System.currentTimeMillis());
		Orders orders = new Orders(1, date, acc.getAddress(), acc.getPhone(), acc.getUsr());

		String sql = "insert into Orders(user_mail,order_status,order_date,order_address,order_phone)\r\n"
				+ "values(?, ?, ?, ?, ?)";

		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

		stmt.setString(1, acc.getUsr());
		stmt.setInt(2, 1);
		stmt.setDate(3, date);
		stmt.setString(4, acc.getAddress());
		stmt.setString(5, acc.getPhone());

		int affectedRows = stmt.executeUpdate();

		if (affectedRows == 0) {
			throw new SQLException("Create orders failed");
		}

		ResultSet rs = stmt.getGeneratedKeys();

		if (rs.next()) {
			orders.setOrderId(rs.getInt(1));
		} else {
			throw new SQLException("Create orders failed");
		}

		rs.close();

		conn.close();

		return orders;
	}

	public void updateCart(Cart cart) throws Exception {
		Connection conn = new DBContext().getConnection();

		for (ProductOrders po : cart.getItems()) {
			String sql = null;
			if (existProductOrders(po)) {
				sql = "update Orders_detail\r\n" + "set amount_product = ?, total_price_product = ?\r\n"
						+ "where order_id = ? and product_id = ?";
			} else {

				sql = "insert into Orders_detail(amount_product, total_price_product, order_id, product_id)\r\n"
						+ "values(?, ?, ?, ?)";
			}

			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setInt(1, po.getAmountProduct());
			stmt.setFloat(2, po.getTotalPriceProduct());
			stmt.setInt(3, po.getOrderId());
			stmt.setInt(4, po.getProductId());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Update product orders failed");
			}

			stmt.close();
		}

		conn.close();

	}

	private boolean existProductOrders(ProductOrders po) throws Exception {
		Connection conn = new DBContext().getConnection();
		String sql = "select count(*) as count from Orders_detail where order_id = ? and product_id = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1, po.getOrderId());
		stmt.setInt(2, po.getProductId());

		ResultSet rs = stmt.executeQuery();

		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		conn.close();

		if (count < 1) {
			return false;
		}

		return true;
	}

	public boolean existOrders(String user_mail) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "select count(*) as count from Orders where user_mail like ? and order_status = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, "%" + user_mail + "%");
		// Order status = 0 - Cancel, 1 - Checkout, 2 - archived
		stmt.setInt(2, 1);

		ResultSet rs = stmt.executeQuery();
		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		conn.close();

		if (count < 1) {
			return false;
		}

		return true;
	}

	public Orders getOrders(String user_mail) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "select * from Orders where user_mail like ? and order_status = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, "%" + user_mail + "%");
		// Order status = 0 - Cancel, 1 - Checkout, 2 - archived
		stmt.setInt(2, 1);

		ResultSet rs = stmt.executeQuery();
		Orders orders = null;

		if (rs.next()) {
			orders = new Orders(rs.getInt("order_id"), rs.getInt("order_status"), rs.getDate("order_date"),
					rs.getString("order_address"), rs.getString("order_phone"), rs.getString("user_mail"));
		}

		rs.close();

		conn.close();
		return orders;
	}

	public void updateOrders(Orders orders) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "update Orders\r\n"
				+ "set order_status = ?, order_discount_code = ?, order_address = ?, order_phone = ?\r\n"
				+ "where order_id = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1, orders.getStatus());
		stmt.setString(2, orders.getDiscount());
		stmt.setString(3, orders.getAddress());
		stmt.setString(4, orders.getPhoneNumber());
		stmt.setInt(5, orders.getOrderId());

		int affectedRows = stmt.executeUpdate();

		if (affectedRows == 0) {
			throw new SQLException("Update orders failed");
		}

		stmt.close();

		conn.close();
	}

	public Cart getCart(int order_id) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "select od.order_id, od.product_id, p.product_name, od.amount_product, p.product_price, p.product_img_source from Orders_detail as od\r\n"
				+ "join Products as p\r\n" + "on od.product_id = p.product_id\r\n" + "where od.order_id = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1, order_id);

		ResultSet rs = stmt.executeQuery();
		Cart cart = new Cart();

		while (rs.next()) {
			ProductOrders po = new ProductOrders(rs.getInt("order_id"), rs.getInt("product_id"),
					rs.getString("product_name"), rs.getInt("amount_product"),
					(float) (Math.round(rs.getDouble("product_price") * 100.0) / 100.0),
					rs.getString("product_img_source"));

			cart.add(po);
		}

		rs.close();
		conn.close();

		return cart;
	}

	public void removeProductOrders(int order_id, int product_id) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "delete from Orders_detail where order_id = ? and product_id = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1, order_id);
		stmt.setInt(2, product_id);

		int affectedRows = stmt.executeUpdate();

		if (affectedRows == 0) {
			throw new SQLException("Deleted orders product failed");
		}

		stmt.close();

		conn.close();
	}

	public void updateProductOrders(ProductOrders po) throws Exception {
		Connection conn = new DBContext().getConnection();

		String sql = "update Orders_detail\r\n" + "set amount_product = ?, total_price_product = ?\r\n"
				+ "where order_id = ? and product_id = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1, po.getAmountProduct());
		stmt.setFloat(2, po.getTotalPriceProduct());
		stmt.setInt(3, po.getOrderId());
		stmt.setInt(4, po.getProductId());

		int affectedRows = stmt.executeUpdate();

		if (affectedRows == 0) {
			throw new SQLException("Update product order failed");
		}

		stmt.close();

		conn.close();
	}
}
