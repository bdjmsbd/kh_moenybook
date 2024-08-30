package kr.kh.app.controller.temp;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.dto.CalendarDTO;

@WebServlet("/moneybook")
public class moneybook extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int year = 0;
		int month = 0; // 0 ~ 11

		try {

			// 년도, 월 중 하나라도 지정(넘겨져 오지)되지 않으면 오늘날짜 기준으로 월달력 출력
			if (request.getParameter("year") == null || request.getParameter("month") == null) {
				Calendar today = Calendar.getInstance();
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
			cal.setFirstDay(firstDay);
			cal.setLastDate(lastDate);
			cal.setStartBlankCnt(startBlankCnt);
			cal.setEndBlankCnt(endBlankCnt);
			cal.setTdCnt(tdCnt);
			
			// System.out.println(cal);

			request.setAttribute("cal", cal);
			request.getRequestDispatcher("/WEB-INF/views/temp/moneybook.jsp").forward(request, response);

		} catch (Exception e) {
			
			e.printStackTrace();
			
			request.setAttribute("msg", "달력 생성중 에러 발생!");
			request.setAttribute("url", "/WEB-INF/views/main.jsp");
			request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
		}
	}

}
