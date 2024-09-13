package kr.kh.app.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;

import kr.kh.app.model.vo.MemberVO;

@WebFilter({ "/accountbook", "/accountbook/delete", "/table", "/accountbook/insert", "/accountbook/search", "/accountbook/update", /*"/graph/export",*/ "/dummyGen" })
public class GuestFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		MemberVO user = (MemberVO) req.getSession().getAttribute("user");

		if (user == null) {
			request.setAttribute("msg", "로그인이 필요한 서비스 입니다.");
			request.setAttribute("url", "/login");
			request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(req, response);
		}
		chain.doFilter(request, response);
	}

}
