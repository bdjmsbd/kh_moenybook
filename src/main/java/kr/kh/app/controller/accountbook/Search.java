package kr.kh.app.controller.accountbook;

import java.io.IOException;
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
		
		String searchExpense = request.getParameter("expense");
		String searchIncome = request.getParameter("income");
		String searchBegin = request.getParameter("search_begin");
		String searchEnd = request.getParameter("search_end");
		
		System.out.println("searchExpense :" +searchExpense);
		System.out.println("searchIncome :" +searchIncome);
		System.out.println("searchBegin :" +searchBegin);
		System.out.println("searchEnd :" +searchEnd);
		
		if(searchBegin == null ||  searchBegin.trim().equals("")) searchBegin = "1900-01-01"; //임시
		if(searchEnd == null ||  searchEnd.trim().equals("")) searchEnd = "2024-12-31";
		
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		
		List<AccountBookVO> list = accountBookService.getAccountBookList(user, searchExpense, searchIncome, searchBegin, searchEnd);
		//System.out.println(list);

		List<AccountTypeVO> at_list = accountBookService.getAccountTypeList();
		List<PaymentPurposeVO> pp_list = accountBookService.getPaymentPurposeList();
		List<PaymentTypeVO> pt_list = accountBookService.getPaymentTypeList();
		
		request.setAttribute("searchPeriod", searchBegin+"~"+searchEnd);
		request.setAttribute("pp_list", pp_list);
		request.setAttribute("pt_list", pt_list);
		request.setAttribute("at_list", at_list);
		request.setAttribute("ab_list", list);
		
		request.getRequestDispatcher("/WEB-INF/views/accountbook/table.jsp").forward(request, response);
	}
}