package kr.kh.app.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.MemberService;
import kr.kh.app.service.MemberServiceImp;

@WebServlet("/signup")
public class SignUp extends HttpServlet {

	private static final long serialVersionUID = 1L;

	MemberService memberService = new MemberServiceImp();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/signup.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		String pw2 = req.getParameter("pw2");
		String email = req.getParameter("email");
		
		MemberVO member = new MemberVO(id, pw, email);
		
		if(!pw.equals(pw2)) throw new RuntimeException();
		
		try {
			if(memberService.signUp(member)) {
				req.setAttribute("msg", "회원가입에 성공하였습니다.");
				req.setAttribute("url", "/login");
			} else throw new RuntimeException();
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("msg", "회원가입에 실패하였습니다.");
			req.setAttribute("url", "/signup");
		}
		
		req.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(req, resp);
	}

}
