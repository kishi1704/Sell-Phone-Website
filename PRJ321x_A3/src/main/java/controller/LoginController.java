package controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import dao.AccountDAO;
import dao.OrdersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Orders;

/**
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * Do login
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String loginType = request.getParameter("logintype");

			Account acc = new Account();
			acc.setUsr(username);
			acc.setPwd(password);

			AccountDAO accDAO = new AccountDAO();

			HttpSession session = request.getSession();

			// Check data from form is correct
			if (!acc.validate()) {
				session.setAttribute("error", acc.getMessage());
				session.setAttribute("username", username);
				session.setAttribute("password", password);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=login"));

			} else if (accDAO.exist(username)) {
				acc = accDAO.getAccount(username);
				if (loginType.equals("user") && (acc.getRole() == 1 || acc.getRole() == 0)) {
					OrdersDAO ordersDAO = new OrdersDAO();
					if(ordersDAO.existOrders(acc.getUsr())) {
						Orders orders = ordersDAO.getOrders(acc.getUsr());
						session.setAttribute("orders", orders);
						session.setAttribute("cart", ordersDAO.getCart(orders.getOrderId()));
					}
					
					if(session.getAttribute("previousPage") == null) {
						session.setAttribute("previousPage", "/home");
					}
					session.setAttribute("user", acc);
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + session.getAttribute("previousPage")));

				} else if (loginType.equals("admin") && (acc.getRole() == 2 || acc.getRole() == 0)) {
					session.setAttribute("name", acc.getName());
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/dashboard"));
				} else {
					session.setAttribute("error", "Please login with different role");
					session.setAttribute("username", username);
					session.setAttribute("password", password);
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=login"));
				}

			} else {
				session.setAttribute("error", "Wrong username or password");
				session.setAttribute("username", username);
				session.setAttribute("password", password);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=login"));
			}

		} catch (Exception e) {
			Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
		}

	}

	private void doRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String fullname = request.getParameter("fullname");
			String address = request.getParameter("address");
			String phone = request.getParameter("phone");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String rpPassword = request.getParameter("rppassword");
			String accountRoleStr = request.getParameter("accountrole");
			int accountRole = Integer.parseInt(accountRoleStr);

			Account acc = new Account(username, password, accountRole, fullname, address, phone);
			AccountDAO accDAO = new AccountDAO();

			HttpSession session = request.getSession();

			// Check data from form is correct
			if (!password.equals(rpPassword)) {
				session.setAttribute("errorR", "Repeat password must be same");
				session.setAttribute("fullnameR", fullname);
				session.setAttribute("addressR", address);
				session.setAttribute("phoneR", phone);
				session.setAttribute("usernameR", username);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=register"));
			} else if (!acc.registerValidate()) {
				session.setAttribute("errorR", acc.getMessage());
				session.setAttribute("fullnameR", fullname);
				session.setAttribute("addressR", address);
				session.setAttribute("phoneR", phone);
				session.setAttribute("usernameR", username);
				session.setAttribute("passwordR", password);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=register"));

			} else if (accDAO.exist(username)) {
				session.setAttribute("errorR", "Account already exists");
				session.setAttribute("fullnameR", fullname);
				session.setAttribute("addressR", address);
				session.setAttribute("phoneR", phone);
				session.setAttribute("usernameR", username);
				session.setAttribute("passwordR", password);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=register"));

			} else {
				accDAO.insertAccount(acc);
				session.setAttribute("errorR", "");
				session.setAttribute("fullnameR", "");
				session.setAttribute("addressR", "");
				session.setAttribute("phoneR", "");
				session.setAttribute("usernameR", "");
				session.setAttribute("passwordR", "");
				session.setAttribute("username", username);
				session.setAttribute("password", password);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=login"));
			}

		} catch (Exception e) {
			Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
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
		String action = request.getParameter("action");

		if (action.equalsIgnoreCase("login") || action == null) {
			request.getRequestDispatcher(response.encodeURL("/login.jsp")).forward(request, response);
		} else if (action.equalsIgnoreCase("register")) {
			request.getRequestDispatcher(response.encodeURL("/register.jsp")).forward(request, response);
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
		String action = request.getParameter("action");

		if (action.equalsIgnoreCase("dologin")) {
			doLogin(request, response);
		} else if (action.equalsIgnoreCase("doregister")) {
			doRegister(request, response);
		}
	}

}
