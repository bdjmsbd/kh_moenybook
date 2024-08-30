package kr.kh.app.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.MemberService;
import kr.kh.app.service.MemberServiceImp;

@WebServlet("/logout")
public class Logout extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImp();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user != null) {
			user.setMe_cookie(null);
			user.setMe_limit(null);
			memberService.updateMemberCookie(user);
		}
		
		//로그아웃 직전 URL을 가져옴
		String url = request.getHeader("Referer");
		//URL이 있거나 /logout이 아니면 세션에 URL을 저장
		if(url != null && !url.contains("/logout")) {
			request.getSession().setAttribute("prevUrl", url);
			request.getSession().setAttribute("logout", "logout");
		}
		
		// 세션에 있는 회원 정보를 지움
		request.getSession().removeAttribute("user");
		// 알림
		request.setAttribute("msg", "로그아웃을 했습니다.");
		request.setAttribute("url", "/");
		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}
