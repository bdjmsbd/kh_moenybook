package kr.kh.app.controller.accountbook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.AccountBookService;

@WebServlet("/accountbook/delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private AccountBookService accountBookService = new AccountBookService();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ab_numStr = request.getParameter("ab_num");
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		boolean res = accountBookService.deleteAccountBook(user, ab_numStr);
		
		String url = request.getHeader("Referer");
		
		
		if(res) {
			request.setAttribute("msg", "삭제 성공!");
		} else {
			request.setAttribute("msg", "삭제 실패!");
		}
		
		if(url.contains("/table")) {
			request.setAttribute("url", "/table");
		} else if(url.contains("/accountbook")) {
			request.setAttribute("url", "/accountbook");
		}
		
		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}



}
