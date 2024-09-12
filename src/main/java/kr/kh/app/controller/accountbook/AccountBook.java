package kr.kh.app.controller.accountbook;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.dto.CalendarDTO;
import kr.kh.app.model.dto.DayAmountDTO;
import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.AccountTypeVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PaymentPurposeVO;
import kr.kh.app.model.vo.PaymentTypeVO;
import kr.kh.app.service.AccountBookService;

@WebServlet("/accountbook")
public class AccountBook extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private AccountBookService accountBookService = new AccountBookService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int year = 0;
		int month = 0; // 0 ~ 11
		int day = 0;

		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		String searchType = request.getParameter("searchType");
		try {
			LocalDate today = LocalDate.now();
			
			// 년도, 월 중 하나라도 지정(넘겨져 오지)되지 않으면 오늘날짜 기준으로 월달력 출력
			if (request.getParameter("year") == null ||
				request.getParameter("month") == null) {
				year = today.getYear();
				month = today.getMonthValue() - 1;
			} else {
				// 출력하고자 하는 달력의 년도와 월
				year = Integer.parseInt(request.getParameter("year")); // 2022,..
				month = Integer.parseInt(request.getParameter("month")); // 0 ~ 11
				// 이전달 클릭 year, month-1 / 다음달 클릭 year, month+1
				// -1 -> 11,year-- 12 -> 0,year++
				if (month == -1) {
					month = 11;
					year = year - 1;
				}
				if (month == 12) {
					month = 0;
					year = year + 1;
				}
			}
			
			if(month == today.getMonthValue() - 1 && request.getParameter("day") == null) //처음 들어갔을 때
				day = today.getDayOfMonth();
			else if(request.getParameter("day") != null && !request.getParameter("day").equals(day))
				day = Integer.parseInt(request.getParameter("day"));
			
			// 출력하고자 달의 1일 객체 + 1일 요일 + 마지막 날짜
			Calendar firstDate = Calendar.getInstance();
			firstDate.set(Calendar.YEAR, year);
			firstDate.set(Calendar.MONTH, month);
			firstDate.set(Calendar.DATE, 1);
			int firstDay = firstDate.get(Calendar.DAY_OF_WEEK); // 1일의 요일 정보(1일,2월,....,7토)
			int lastDate = firstDate.getActualMaximum(Calendar.DATE);

			// 출력 알고리즘(td의 개수 구하기)
			int startBlankCnt = firstDay - 1;
			int endBlankCnt = 0;
			if ((startBlankCnt + lastDate) % 7 != 0) {
				endBlankCnt = 7 - (startBlankCnt + lastDate) % 7;
			}
			int tdCnt = startBlankCnt + lastDate + endBlankCnt;

			CalendarDTO cal = new CalendarDTO();
			
			cal.setYear(year);
			cal.setMonth(month);
			cal.setDay(day);
			cal.setFirstDay(firstDay);
			cal.setLastDate(lastDate);
			cal.setStartBlankCnt(startBlankCnt);
			cal.setEndBlankCnt(endBlankCnt);
			cal.setTdCnt(tdCnt);
			
			if (day != 0) {
				today = LocalDate.of(year, month + 1, day);
			} else if(day == 0 && today.getMonthValue() - 1 != month) {
				today = null;
			}
			
			List<AccountBookVO> ab_list = null;

			if (today != null) {
				DateTimeFormatter format;
				if (request.getParameter("year") == null || request.getParameter("month") == null) {
					format = DateTimeFormatter.ofPattern("yyyy-MM");
					searchType = "0";
				} else {
					format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				}
				ab_list = accountBookService.getAccountBookList(user, today.format(format));
			}
			
			List<AccountTypeVO> at_list = accountBookService.getAccountTypeList();
			List<PaymentPurposeVO> pp_list = accountBookService.getPaymentPurposeList();
			List<PaymentTypeVO> pt_list = accountBookService.getPaymentTypeList();
			
			String tmp_month = Integer.toString(month+1);
			tmp_month =(tmp_month.length()==1)?"0"+(tmp_month):tmp_month;
			// String tmp_day = Integer.toString(day);
			// tmp_day = (tmp_day.length()==1)?"0"+(tmp_day):tmp_day;
			String date_month = Integer.toString(year)+ "-" + tmp_month; // yyyy-MM
			// String date_day = Integer.toString(year)+ "-" + tmp_month+ "-" + tmp_day; // yyyy-MM-dd
			
			//System.out.println("달력에서 출력할 날" + date_amount);
			
			List<DayAmountDTO> amount_list = accountBookService.getAmountList(user, date_month);
			
			// 람다 표현식을 사용한 Comparator 정의
      Comparator<DayAmountDTO> sortedList = (a1, a2) -> a1.getDate().compareTo(a2.getDate());
      // 정렬 수행
      amount_list.sort(sortedList); 
      
			
      System.out.println(ab_list);
			for(DayAmountDTO tmp : amount_list) {
				tmp.initDay();
			}
			System.out.println(amount_list);

			request.setAttribute("amount_list", amount_list);
			request.setAttribute("searchType", searchType);

			request.setAttribute("pp_list", pp_list);
			request.setAttribute("pt_list", pt_list);
			request.setAttribute("at_list", at_list);
			request.setAttribute("amount_list", amount_list);
			
			request.setAttribute("cal", cal);
			request.setAttribute("ab_list", ab_list);
			request.setAttribute("selected", today);
			
			request.getRequestDispatcher("/WEB-INF/views/accountbook/accountbook.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			
			request.setAttribute("msg", "달력 생성중 에러 발생!");
			request.setAttribute("url", "/main");
			request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
		}
	}
}
