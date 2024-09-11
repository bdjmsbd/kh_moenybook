package kr.kh.app.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PostVO;
import kr.kh.app.service.MemberService;

@WebServlet("/mypage")
public class Mypage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		//마이페이지로 오기 전 URL을 가져옴
		String url = request.getHeader("Referer");
		//URL이 있거나 /mypage이 아니면 세션에 URL을 저장
		if(url != null && !url.contains("/mypage")) {
			request.getSession().setAttribute("prevUrl", url);
		}
		request.setAttribute("user", user);
	
		request.getRequestDispatcher("/WEB-INF/views/member/mypage.jsp").forward(request, response);
	}

}
