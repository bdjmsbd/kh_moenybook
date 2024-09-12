package kr.kh.app.controller.accountbook;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.dto.CalendarDTO;
import kr.kh.app.model.vo.MemberVO;
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
		
		try {
			Calendar today = Calendar.getInstance();
			
			// 년도, 월 중 하나라도 지정(넘겨져 오지)되지 않으면 오늘날짜 기준으로 월달력 출력
			if (request.getParameter("year") == null ||
				request.getParameter("month") == null) {
				year = today.get(Calendar.YEAR);
				month = today.get(Calendar.MONTH);
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
			
			if(request.getParameter("day") == null)
				day = today.get(Calendar.DATE);
			else if(!request.getParameter("day").equals(day))
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
			
			request.setAttribute("cal", cal);
			request.getRequestDispatcher("/WEB-INF/views/accountbook/accountbook.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			
			request.setAttribute("msg", "달력 생성중 에러 발생!");
			request.setAttribute("url", "/main");
			request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
		}
	}

}