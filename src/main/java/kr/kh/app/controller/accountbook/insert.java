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
import kr.kh.app.model.vo.AccountTypeVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.service.AccountBookService;
import kr.kh.app.service.MemberService;

@WebServlet("/accountbook/insert")
public class insert extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private MemberService memberService = new MemberService();
	private AccountBookService accountBookService = new AccountBookService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<AccountTypeVO> pp_list = accountBookService.getPaymentPurposeList();
		List<AccountTypeVO> pt_list = accountBookService.getPaymentTypeList();

		request.setAttribute("pp_list", pp_list);
		request.setAttribute("pt_list", pt_list);
		request.getRequestDispatcher("/WEB-INF/views/accountbook/insert.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		String ab_at_numStr = request.getParameter("ab_at_num");
		String ab_pp_numStr = request.getParameter("ab_pp_num");
		String ab_pt_numStr = request.getParameter("ab_pt_num");
		String ab_dateStr = request.getParameter("ab_date");
		String ab_amountStr = request.getParameter("ab_amount");
		String ab_detail = request.getParameter("ab_detail");

		// 수입 1, 지출 3, 정기성 여부 확인해서 정기성이면 +1 해준다.
		// 고정 수입 2, 고정 지출 4
		String regularity = request.getParameter("regularity");

		try {

			MemberVO user = (MemberVO) request.getSession().getAttribute("user");

			if (user == null) {
				throw new Exception();
			}

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			AccountBookVO newAB = new AccountBookVO(
					Integer.parseInt(ab_at_numStr), Integer.parseInt(ab_pp_numStr),
					Integer.parseInt(ab_pt_numStr), user.getMe_id(), formatter.parse(ab_dateStr),
					Integer.parseInt(ab_amountStr), ab_detail, Integer.parseInt(regularity));

			// System.out.println(newAB);
			
			accountBookService.insertAccountBook(newAB);

			request.setAttribute("msg", "새로운 가계부를 등록했습니다.");
		} catch (Exception e) {
			request.setAttribute("msg", "가계부를 등록하지 못했습니다.");
		}

		request.setAttribute("url", "/");
		request.getRequestDispatcher("/WEB-INF/views/message.jsp").forward(request, response);
	}

}