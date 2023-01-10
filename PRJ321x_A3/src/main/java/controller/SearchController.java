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
 * Servlet implementation class SearchController
 */
public class SearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchController() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	private void doSearch(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			String txtSearch = request.getParameter("txtSearch");
			String category = request.getParameter("category");
			if(indexString == null) {
				indexString = "1";
			}
			int index = Integer.parseInt(indexString);
			
			ListProductDAO listProductDAO = new ListProductDAO();
			
			int count = listProductDAO.countP(txtSearch,category);
			int pageSize = 4;
			int endPage = 0;
			
			endPage = count / pageSize;
			if(count % pageSize != 0) {
				endPage++;
			}
			
			List<Product> searchList = listProductDAO.search(txtSearch, category, index, pageSize);
			HttpSession session = request.getSession();
			session.setAttribute("endPage", endPage);
			session.setAttribute("list", searchList);
			session.setAttribute("index", index);
			session.setAttribute("txtSearch", txtSearch);
			session.setAttribute("category", category);
			session.setAttribute("pageDisplay", "search");
			session.setAttribute("currentPage", "home-page");
			request.getRequestDispatcher(response.encodeURL("/search.jsp")).forward(request, response);
			
		} catch (Exception e) {
			Logger.getLogger(SearchController.class.getName()).log(Level.SEVERE, null, e);
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
		doSearch(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		doSearch(request, response);
	}

}
