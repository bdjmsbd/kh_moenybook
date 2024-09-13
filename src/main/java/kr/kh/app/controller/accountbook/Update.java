package kr.kh.app.controller.accountbook;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PaymentPurposeVO;
import kr.kh.app.model.vo.PaymentTypeVO;
import kr.kh.app.service.AccountBookService;
import kr.kh.app.service.MemberService;

@WebServlet("/accountbook/update")
public class Update extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private AccountBookService accountBookService = new AccountBookService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			MemberVO user = (MemberVO) request.getSession().getAttribute("user");
			String ab_numStr = request.getParameter("ab_num");

			AccountBookVO ab = accountBookService.getAccountBook(user, ab_numStr);
			if (ab == null)
				throw new RuntimeException();

			List<PaymentPurposeVO> pp_list = accountBookService.getPaymentPurposeList();
			List<PaymentTypeVO> pt_list = accountBookService.getPaymentTypeList();

			request.setAttribute("ab", ab);
			request.setAttribute("pp_list", pp_list);
			request.setAttribute("pt_list", pt_list);
			request.getRequestDispatcher("/WEB-INF/views/accountbook/update.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();

			request.setAttribute("msg", "수정 실패!(자료를 불러올 수 없습니다.)");
			request.setAttribute("url", "/");
			request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ab_numStr = request.getParameter("ab_num");

		String ab_at_numStr = request.getParameter("ab_at_num");
		String ab_pp_numStr = request.getParameter("ab_pp_num");
		String ab_pt_numStr = request.getParameter("ab_pt_num");
		String ab_dateStr = request.getParameter("ab_date");
		String ab_amountStr = request.getParameter("ab_amount");
		String ab_detail = request.getParameter("ab_detail");

		// 정기적인 지, 일회성인 지 판단. 정기적인 경우 주기 추가
		String ab_regularityStr = request.getParameter("ab_regularity");
		String ab_periodStr = request.getParameter("ab_period");
		if (ab_periodStr == null)
			ab_periodStr = "0";

		String url = request.getHeader("Referer");

		try {

			MemberVO user = (MemberVO) request.getSession().getAttribute("user");

			if (user == null) {
				throw new Exception();
			}

			if (ab_detail == null)
				ab_detail = "";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			AccountBookVO newAb = new AccountBookVO(Integer.parseInt(ab_at_numStr.trim()),
					Integer.parseInt(ab_pt_numStr.trim()), Integer.parseInt(ab_pp_numStr.trim()), user.getMe_id(),
					formatter.parse(ab_dateStr.trim()), Integer.parseInt(ab_amountStr.trim()), ab_detail,
					Integer.parseInt(ab_regularityStr.trim()), Integer.parseInt(ab_periodStr.trim()));

			newAb.setAb_num(Integer.parseInt(ab_numStr.trim()));
			System.out.println(newAb);

			boolean res = accountBookService.updateAccountBook(newAb);

			if (!res)
				throw new Exception();

			if (res)

				request.setAttribute("msg", "수정 성공!");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "수정 실패!");
		}

		if (url.contains("/table")) {
			request.setAttribute("url", "/table");
		} else if (url.contains("/accountbook")) {
			request.setAttribute("url", "/accountbook");
		}

		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}