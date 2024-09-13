package kr.kh.app.controller.accountbook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.AccountBookService;

@WebServlet("/dummyGen")
public class DummyGen extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private AccountBookService accountBookService = new AccountBookService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		
		accountBookService.dummyGen(user);
		
		request.setAttribute("msg", "더미 데이터 생성!");
		request.setAttribute("url", "/");
	

	request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}