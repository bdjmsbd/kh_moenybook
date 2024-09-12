package kr.kh.app.controller.post;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.CommunityVO;
import kr.kh.app.model.vo.PostVO;
import kr.kh.app.pagination.Criteria;
import kr.kh.app.pagination.PageMaker;
import kr.kh.app.pagination.PostCriteria;
import kr.kh.app.service.PostService;
import kr.kh.app.service.PostServiceImp;

@WebServlet("/post/list")
public class PostList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PostService postService = new PostServiceImp();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String num = request.getParameter("co_num");
		CommunityVO community = postService.getCommunity(num);
		
		String page = request.getParameter("page");
		String search = request.getParameter("search");
		String type = request.getParameter("type");
		Criteria cri = new PostCriteria(num, page, search, type, 5);
		
		List<PostVO> list = postService.getPostList(cri);
		PageMaker pm = postService.getPostPageMaker(cri);
		
		request.setAttribute("co", community);
		request.setAttribute("list", list);
		request.setAttribute("pm", pm);
		request.getRequestDispatcher("/WEB-INF/views/post/list.jsp").forward(request, response);
	}
	
}