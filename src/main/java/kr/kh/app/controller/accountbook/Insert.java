package kr.kh.app.controller.accountbook;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.AccountTypeVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PaymentPurposeVO;
import kr.kh.app.model.vo.PaymentTypeVO;
import kr.kh.app.service.AccountBookService;
import kr.kh.app.service.MemberService;

@WebServlet("/accountbook/insert")
public class Insert extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private MemberService memberService = new MemberService();
	private AccountBookService accountBookService = new AccountBookService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<PaymentPurposeVO> pp_list = accountBookService.getPaymentPurposeList();
		List<PaymentTypeVO> pt_list = accountBookService.getPaymentTypeList();

		request.setAttribute("pp_list", pp_list);
		request.setAttribute("pt_list", pt_list);
		request.getRequestDispatcher("/WEB-INF/views/accountbook/insert.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ab_at_numStr = request.getParameter("ab_at_num");
		String ab_pp_numStr = request.getParameter("ab_pp_num");
		String ab_pt_numStr = request.getParameter("ab_pt_num");
		String ab_dateStr = request.getParameter("ab_date");
		String ab_amountStr = request.getParameter("ab_amount");
		String ab_detail = request.getParameter("ab_detail");

		// 정기적인 지, 일회성인 지 판단. 정기적인 경우 주기 추가
		String ab_regularityStr = request.getParameter("ab_regularity");
		String ab_periodStr = request.getParameter("ab_period");
		if(ab_periodStr == null) ab_periodStr = "0";
		
//		System.out.println("ab_at_numStr :"+ ab_at_numStr);
//		System.out.println("ab_pp_numStr :"+ ab_pp_numStr);
//		System.out.println("ab_pt_numStr :"+ ab_pt_numStr);
//		System.out.println("ab_dateStr :"+ ab_dateStr);
//		System.out.println("ab_amountStr :"+ ab_amountStr);
//		System.out.println("ab_detail :"+ ab_detail);
//		System.out.println("ab_regularityStr :"+ ab_regularityStr);
//		System.out.println("ab_periodStr :"+ ab_periodStr);

		try {
			
			MemberVO user = (MemberVO) request.getSession().getAttribute("user");

			if (user == null) {
				throw new Exception();
			}
			
			if(ab_detail==null) ab_detail ="";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			
			AccountBookVO newAB = new AccountBookVO(
					Integer.parseInt(ab_at_numStr.trim()), Integer.parseInt(ab_pt_numStr.trim()),
					Integer.parseInt(ab_pp_numStr.trim()), user.getMe_id(), formatter.parse(ab_dateStr.trim()),
					Integer.parseInt(ab_amountStr.trim()), ab_detail, Integer.parseInt(ab_regularityStr.trim()),
					Integer.parseInt(ab_periodStr.trim()));
			
//			System.out.println(newAB);
			
			accountBookService.insertAccountBook(newAB);

			request.setAttribute("msg", "새로운 가계부를 등록했습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "가계부를 등록하지 못했습니다.");
		}

		request.setAttribute("url", "/accountbook");
		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}