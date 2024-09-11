package kr.kh.app.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import kr.kh.app.service.MemberService;
@WebServlet("/check/id")
public class CheckId extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	MemberService memberService = new MemberService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String me_id = request.getParameter("me_id");
		
		JSONObject jobj = new JSONObject();
		
		boolean res;
		try {
			res = memberService.checkId(me_id);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			res = false;
		}
		
		jobj.put("result", res);
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(jobj);
		
	}


}