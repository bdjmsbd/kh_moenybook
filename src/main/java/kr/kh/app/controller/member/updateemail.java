package kr.kh.app.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.MemberService;

@WebServlet("/member/updateemail")
public class updateemail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService memberService = new MemberService();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		request.setAttribute("user", user);
		request.getRequestDispatcher("/WEB-INF/views/member/updateemail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		String newemail = request.getParameter("newemail");
		
		if (user.getMe_email().equals(newemail)) {
			request.setAttribute("msg", "기존 이메일과 일치합니다.");
		} else {
			try {
				if (memberService.updateMemberEmail(user, newemail)) {
					request.setAttribute("msg", "이메일이 변경되었습니다.");
					MemberVO member = new MemberVO(user.getMe_id(), user.getMe_pw(), "");
					MemberVO newuser = memberService.login(member);
					// 3. 가져온 회원 정보를 세션에 저장
					request.getSession().setAttribute("user", newuser);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("url", "/mypage");
		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}
