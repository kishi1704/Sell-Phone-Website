package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import dao.OrdersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Cart;
import model.Orders;
import model.Product;
import model.ProductOrders;

/**
 * Servlet implementation class AddToCartController
 */
public class AddToCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddToCartController() {
		super();
		// TODO Auto-generated constructor stub
	}

	private void addToCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();

			if (session.getAttribute("user") == null) {
				session.setAttribute("previousPage", "/cart");
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=login"));
			} else {

				Product product = (Product) session.getAttribute("productInfo");
				Account acc = (Account) session.getAttribute("user");

				OrdersDAO ordersDAO = new OrdersDAO();
				Orders orders = null;
				Cart cart = null;
				if (session.getAttribute("orders") == null) {
					orders = ordersDAO.createOrder(acc);
					cart = new Cart();

					session.setAttribute("orders", orders);
					session.setAttribute("cart", cart);

				}

				orders = (Orders) session.getAttribute("orders");
				ProductOrders po = new ProductOrders(orders.getOrderId(), product.getId(), product.getName(), 1,
						product.getPrice(), product.getSrc());
				cart = (Cart) session.getAttribute("cart");
				cart.add(po);

				ordersDAO.updateCart(cart);
				orders.setPrice(cart.getPrice());
				ordersDAO.updateOrders(orders);

				session.setAttribute("cart", cart);
				session.setAttribute("orders", orders);

				session.setAttribute("currentPage", "cart-page");
				request.getRequestDispatcher(response.encodeURL("/cart.jsp")).forward(request, response);

			}
		} catch (Exception e) {
			Logger.getLogger(AddToCartController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void changePAmount(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();

			String productIdStr = request.getParameter("productId");
			int productId = Integer.parseInt(productIdStr);
			String amountStr = request.getParameter("productAmount");
			int amount = Integer.parseInt(amountStr);

			OrdersDAO ordersDAO = new OrdersDAO();
			Cart cart = (Cart) session.getAttribute("cart");
			Orders orders = (Orders) session.getAttribute("orders");
			cart.changeAmount(productId, amount);
			orders.setPrice(cart.getPrice());

			ordersDAO.updateOrders(orders);
			ordersDAO.updateProductOrders(cart.getProduct(productId));

			session.setAttribute("orders", orders);
			session.setAttribute("cart", cart);

			PrintWriter out = response.getWriter();

			out.println(cart.getPrice());
		} catch (Exception e) {
			Logger.getLogger(AddToCartController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void removeProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();

			String productIdStr = request.getParameter("productId");
			int productId = Integer.parseInt(productIdStr);

			OrdersDAO ordersDAO = new OrdersDAO();
			Cart cart = (Cart) session.getAttribute("cart");
			Orders orders = (Orders) session.getAttribute("orders");
			cart.remove(productId);
			orders.setPrice(cart.getPrice());

			ordersDAO.updateOrders(orders);
			ordersDAO.removeProductOrders(orders.getOrderId(), productId);

			session.setAttribute("orders", orders);
			session.setAttribute("cart", cart);

			PrintWriter out = response.getWriter();

			out.println(cart.getPrice());
		} catch (Exception e) {
			Logger.getLogger(AddToCartController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String action = request.getParameter("action");

		if (action == null) {
			addToCart(request, response);
		} else if (action.equals("showcart")) {
			session.setAttribute("currentPage", "cart-page");
			request.getRequestDispatcher(response.encodeURL("/cart.jsp")).forward(request, response);
		} else if (action.equals("changeamount")) {
			changePAmount(request, response);
		} else if (action.equals("removeproduct")) {
			removeProduct(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		doGet(request, response);
	}

}
