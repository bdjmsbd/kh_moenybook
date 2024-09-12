package kr.kh.app.controller.post;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PostVO;
import kr.kh.app.service.PostService;
import kr.kh.app.service.PostServiceImp;

@WebServlet("/post/add")
public class PostAdd extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private PostService postService = new PostServiceImp();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String co_num = request.getParameter("co_num");
		
		request.setAttribute("co_num", co_num);
		request.getRequestDispatcher("/WEB-INF/views/post/add.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title = request.getParameter("po_title");
		String content = request.getParameter("po_content");
		String co_num_str = request.getParameter("po_co_num");
		
		PostVO post = new PostVO();
		int co_num = 0;
		try {
			co_num = Integer.parseInt(co_num_str);
			MemberVO user = (MemberVO)request.getSession().getAttribute("user");
			post = new PostVO(co_num, title, content, user.getMe_id());
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		boolean res = postService.insertPost(post);
		
		if(res) {
			request.setAttribute("msg", "게시글을 등록했습니다.");
			request.setAttribute("url", "/post/list?co_num=" + co_num);
		}else {
			request.setAttribute("msg", "게시글을 등록하지 못했습니다.");
			request.setAttribute("url", "/post/insert?co_num=" + co_num);
		}
		
		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}