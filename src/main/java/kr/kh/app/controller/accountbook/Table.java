package kr.kh.app.controller.accountbook;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

@WebServlet("/table")
public class Table extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private AccountBookService accountBookService = new AccountBookService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		String searchDate = request.getParameter("searchDate");
		//String date = request.getParameter("searchDate");
		
		if(searchDate == null) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			searchDate = sdf.format(now);
		}else {
			// CalendarDTO cal = new CalendarDTO();
			
			String year = searchDate.substring(0,4);
			String month = searchDate.substring(5,7);
			
		}
		
		List<AccountBookVO> ab_list = accountBookService.getAccountBookList(user, searchDate);
		List<AccountTypeVO> at_list = accountBookService.getAccountTypeList();
		List<PaymentPurposeVO> pp_list = accountBookService.getPaymentPurposeList();
		List<PaymentTypeVO> pt_list = accountBookService.getPaymentTypeList();

		if (ab_list != null) {
			// 람다 표현식을 사용한 Comparator 정의
			Comparator<AccountBookVO> sortedList = (ab1, ab2) -> ab1.getAb_date().compareTo(ab2.getAb_date());
			// 정렬 수행
			ab_list.sort(sortedList);

			int totalIncome = accountBookService.totalAmount(ab_list, 1);
			int totalExpense = accountBookService.totalAmount(ab_list, 2);

			request.setAttribute("totalIncome", totalIncome);
			request.setAttribute("totalExpense", totalExpense);
		}
		
		request.setAttribute("searchType", "0");
		request.setAttribute("curDate", searchDate);
		request.setAttribute("pp_list", pp_list);
		request.setAttribute("pt_list", pt_list);
		request.setAttribute("at_list", at_list);
		request.setAttribute("ab_list", ab_list);

		request.getRequestDispatcher("/WEB-INF/views/accountbook/table.jsp").forward(request, response);
	}

}
