package kr.kh.app.controller.accountbook;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.dto.CalendarDTO;
import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.AccountTypeVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PaymentPurposeVO;
import kr.kh.app.model.vo.PaymentTypeVO;
import kr.kh.app.service.AccountBookService;

@WebServlet("/table")
public class Table extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private AccountBookService accountBookService = new AccountBookService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		String searchDate = request.getParameter("searchDate");
		
		if(searchDate == null) {
			searchDate = "";
		}else {
			// CalendarDTO cal = new CalendarDTO();
			
			String year = searchDate.substring(0,4);
			String month = searchDate.substring(5,7);
			
			System.out.println("year :" + year);
			System.out.println("month :" + month);
			
		}
		
		List<AccountBookVO> ab_list = accountBookService.getAccountBookList(user,searchDate);
		List<AccountTypeVO> at_list = accountBookService.getAccountTypeList();
		List<PaymentPurposeVO> pp_list = accountBookService.getPaymentPurposeList();
		List<PaymentTypeVO> pt_list = accountBookService.getPaymentTypeList();
		
		Date date = new Date();
		if(ab_list != null) {
			date = ab_list.get(0).getAb_date();
			System.out.println("date: "+ date);
		}
		
		request.setAttribute("date", date);
		request.setAttribute("pp_list", pp_list);
		request.setAttribute("pt_list", pt_list);
		request.setAttribute("at_list", at_list);
		request.setAttribute("ab_list", ab_list);
		
		request.getRequestDispatcher("/WEB-INF/views/accountbook/table.jsp").forward(request, response);
	}

}
