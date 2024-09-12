package kr.kh.app.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.MemberService;

@WebServlet("/member/updatepw")
public class Updatepw extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService memberService = new MemberService();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		request.setAttribute("user", user);
		
		request.getRequestDispatcher("/WEB-INF/views/member/updatepw.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		String oldpw = request.getParameter("oldpw");
		String newpw = request.getParameter("newpw");
		String newpw2 = request.getParameter("newpw2");
		
		if (!user.getMe_pw().equals(oldpw)) {
			request.setAttribute("msg", "기존 비밀번호를 잘못 입력했습니다.");
		} else if (!newpw.equals(newpw2)) {
			request.setAttribute("msg", "새 비밀번호가 일치하지 않습니다.");
		} else {
			try {
				if (memberService.updateMemberPw(user, newpw)) {
					request.setAttribute("msg", "비밀번호가 변경되었습니다.");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		request.setAttribute("url", "/mypage");
		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}