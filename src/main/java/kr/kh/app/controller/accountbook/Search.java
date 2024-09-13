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

@WebServlet("/accountbook/search")
public class Search extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private AccountBookService accountBookService = new AccountBookService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String searchType = request.getParameter("at_num");
		String searchBegin = request.getParameter("search_begin");
		String searchEnd = request.getParameter("search_end");
		
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		List<AccountBookVO> list;
		if(searchBegin == null ||  searchBegin.trim().equals("") || searchBegin.equals("NaN") || 
				searchEnd == null ||  searchEnd.trim().equals("") || searchEnd.equals("NaN")){
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			String searchDate = sdf.format(date);
			list = accountBookService.getAccountBookList(user, searchDate);
			
			request.setAttribute("curDate", searchDate);
 		}
		else {
			list = accountBookService.getAccountBookList(user, searchType, searchBegin, searchEnd);
			request.setAttribute("searchBegin", searchBegin);
			request.setAttribute("searchEnd", searchEnd);
		}
		
		List<AccountTypeVO> at_list = accountBookService.getAccountTypeList();
		List<PaymentPurposeVO> pp_list = accountBookService.getPaymentPurposeList();
		List<PaymentTypeVO> pt_list = accountBookService.getPaymentTypeList();
		int totalIncome = accountBookService.totalAmount(list, 1);
		int totalExpense = accountBookService.totalAmount(list, 2);
		
		request.setAttribute("searchType", searchType);
		request.setAttribute("totalIncome", totalIncome);
		request.setAttribute("totalExpense", totalExpense);
		request.setAttribute("pp_list", pp_list);
		request.setAttribute("pt_list", pt_list);
		request.setAttribute("at_list", at_list);
		request.setAttribute("ab_list", list);
		
		request.getRequestDispatcher("/WEB-INF/views/accountbook/table.jsp").forward(request, response);
	}
}