package kr.kh.app.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.MemberService;

@WebServlet("/member/deletemember")
public class deletemember extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService memberService = new MemberService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/deletemember.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		String pw = request.getParameter("pw");

		try {
			if (user.getMe_pw().equals(pw)) {
				memberService.deletmemeber(user);
				request.setAttribute("msg", "회원 탈퇴가 완료되었습니다.");
				request.setAttribute("url", "/");
			} else {
				throw new RuntimeException();
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "회원 탈퇴에 실패하였습니다.");
			request.setAttribute("url", "/mypage");
		}

		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}
