package controller;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import dao.ListProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;

/**
 * Servlet implementation class HomeController
 */
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
    }
    
    /**
     * Go to home page
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void goHome(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
    	try {
			String indexString = request.getParameter("index");
			if(indexString == null) {
				indexString = "1";
			}
			int index = Integer.parseInt(indexString);
			
			ListProductDAO listProductDAO = new ListProductDAO();
			
			int count = listProductDAO.countP();
			int pageSize = 4; // Product per page
			int endPage = 0;
			
			endPage = count / pageSize;
			if(count % pageSize != 0) {
				endPage++;
			}
			
			List<Product> totalList = listProductDAO.search(index, pageSize);
			HttpSession session = request.getSession();
			session.setAttribute("endPage", endPage);
			session.setAttribute("list", totalList);
			session.setAttribute("index", index);
			session.setAttribute("currentPage", "home-page");
			session.setAttribute("txtSearch", "");
			session.setAttribute("category", "all");
			session.setAttribute("pageDisplay", "home");
			request.getRequestDispatcher(response.encodeURL("/home.jsp")).forward(request, response);
			
		} catch (Exception e) {
			Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, e);
		}
    }
    
    /**
     * Show product information
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void showProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
    	try {
			String productIdStr = request.getParameter("productid");
			int productId = Integer.parseInt(productIdStr);
			
			ListProductDAO listProductDAO = new ListProductDAO();
			
			Product product = listProductDAO.getProduct(productId);
			HttpSession session = request.getSession();
			
			session.setAttribute("productInfo", product);
			request.getRequestDispatcher(response.encodeURL("/product.jsp")).forward(request, response);
			
		} catch (Exception e) {
			Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, e);
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		if(action == null || action.equals("home")) {
			goHome(request, response);
		}else if(action.equals("showproduct")) {
			showProduct(request, response);
		}else if(action.equals("login")) {
			
			session.setAttribute("error", "");
			session.setAttribute("username", "");
			session.setAttribute("password", "");
			session.setAttribute("previousPage", "/home");
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=login"));
		}else if(action.equals("register")) {
			session.setAttribute("errorR", "");
			session.setAttribute("fullnameR", "");
			session.setAttribute("addressR", "");
			session.setAttribute("phoneR", "");
			session.setAttribute("usernameR", "");
			session.setAttribute("passwordR", "");
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/login?action=register"));
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
