package kr.kh.app.service;

import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.kh.app.dao.AccountBookDAO;
import kr.kh.app.model.dto.DayAmountDTO;
import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.AccountTypeVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PaymentPurposeVO;
import kr.kh.app.model.vo.PaymentTypeVO;

public class AccountBookService {

	private AccountBookDAO accountBookDao;

	public AccountBookService() {
		String resource = "kr/kh/app/config/mybatis-config.xml";
		InputStream inputStream;
		SqlSession session;
		try {

			inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sessionFactory.openSession(true);
			accountBookDao = session.getMapper(AccountBookDAO.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<PaymentPurposeVO> getPaymentPurposeList() {
		return accountBookDao.selectPaymentPurposeList();
	}

	public List<PaymentTypeVO> getPaymentTypeList() {
		return accountBookDao.selectPaymentTypeList();
	}

	public void insertAccountBook(AccountBookVO newAB) {
		accountBookDao.insertAccountBook(newAB);
	}

	public List<AccountBookVO> getAccountBookList(MemberVO user, String searchDate) {

		if (user == null) {
			return null;
		}

		return accountBookDao.selectAccountBookList(user, searchDate);
	}

	public List<AccountTypeVO> getAccountTypeList() {
		return accountBookDao.selectAccountTypeList();
	}

	public List<AccountBookVO> getAccountBookList(MemberVO user, String searchType, String searchBegin,
			String searchEnd) {

		if (user == null)
			return null;
		if (searchType == null)
			return null;

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-00");

//		// 문자열을 LocalDate로 변환
//    LocalDate date = LocalDate.parse(searchEnd, formatter);
//    
//    // 날짜 1일 증가
//    LocalDate nextDay = date.plusDays(1);
//    searchEnd = nextDay.format(formatter);

		List<AccountBookVO> list = new ArrayList<AccountBookVO>();

		// 0: 수입/지출 모두 조회, 1: 수입만 조회, 2: 지출만 조회
		switch (searchType) {
		case "0":
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 1));
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 2));
			break;
		case "1":
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 1));
			break;
		case "2":
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 2));
			break;
		}

		System.out.println(list);
		// 람다 표현식을 사용한 Comparator 정의
		Comparator<AccountBookVO> sortedList = (ab1, ab2) -> ab1.getAb_date().compareTo(ab2.getAb_date());

		// 정렬 수행
		list.sort(sortedList);

		System.out.println(list);

		return list;
	}

	public int totalAmount(List<AccountBookVO> ab_list, int accountBook_type) {
		int sum = 0;

		if (ab_list == null) {
			return 0;
		}
		for (AccountBookVO accountbook : ab_list) {
			if (accountbook.getAb_at_num() == accountBook_type)
				sum += accountbook.getAb_amount();
		}

		return sum;
	}

	public void dummyGen(MemberVO user) {

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		if (user == null) {
			System.err.println("더미생성 에러 발생. 로그인 확인하세요.");
			return;
		}

		String id = user.getMe_id(); // 아이디

		for (int i = 1; i < 150; i++) {
			int at = 1;
			int pp = (int) (Math.random() * 3) + 1;
			int pt = 1;
			int amount = ((int) (Math.random() * 100) + 1) * 500;
			String month = Integer.toString((int) (Math.random() * 12) + 1);
			month = (month.length() == 1) ? "0" + month : month;
			String day = Integer.toString((int) (Math.random() * 28) + 1);
			day = (day.length() == 1) ? "0" + day : day;
			String date = "2024-" + month + "-" + day;

			String detail = "더미데이터" + Integer.toString(i);

			try {
				AccountBookVO ab = new AccountBookVO(at, pp, pt, id, formatter.parse(date), amount, detail, 0, 0);
				accountBookDao.insertAccountBook(ab);

				System.out.println("더미데이터 생성 " + ab.getAb_detail());

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		for (int i = 150; i <= 500; i++) {
			int at = 2;
			int pp = (int) (Math.random() * 7) + 4;
			int pt = (int) (Math.random() * 4) + 2;
			int amount = ((int) (Math.random() * 100) + 1) * 500;
			String month = Integer.toString((int) (Math.random() * 12) + 1);
			month = (month.length() == 1) ? "0" + month : month;
			String day = Integer.toString((int) (Math.random() * 28) + 1);
			day = (day.length() == 1) ? "0" + day : day;
			String date = "2024-" + month + "-" + day;
			String detail = "더미데이터" + Integer.toString(i);
			try {
				AccountBookVO ab = new AccountBookVO(at, pp, pt, id, formatter.parse(date), amount, detail, 0, 0);
				accountBookDao.insertAccountBook(ab);

				System.out.println("더미데이터 생성 " + ab.getAb_detail());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public List<DayAmountDTO> getAmountList(MemberVO user, String date_amount) {
		if(user == null) return null;
		
		return accountBookDao.getAmountList(user.getMe_id(),date_amount);
	}

	public boolean deleteAccountBook(MemberVO user, String ab_numStr) {

		if (user == null || ab_numStr == null) {
			return false;
		}
		int res = accountBookDao.deleteAccountBook(user.getMe_id(), ab_numStr);

		// 일치하는 accountbook 정보가 없다면.
		if (res == 0) {
			return false;
		}

		return true;
	}

	public AccountBookVO getAccountBook(MemberVO user, String ab_numStr) {

		if (user == null || ab_numStr == null) {
			return null;
		}

		return accountBookDao.selectAccountBook(user.getMe_id(), ab_numStr);

	}

	public boolean updateAccountBook(AccountBookVO newAB) {

		int res = accountBookDao.updateAccountBook(newAB);

		if (res == 0) {
			return false;
		}

		return true;
	}
	
	public List<AccountBookVO> getExportList(MemberVO user) {
		if(user == null) return null;
		return accountBookDao.selectExportList(user.getMe_id());
	}

	public List<AccountBookVO> getAccountBookListWithRegularity(MemberVO user, String now_yyyy_MM) {

		List<AccountBookVO> tmpList = new ArrayList<>();

		if (user == null) {
			return null;
		}

		List<AccountBookVO> regularityList = accountBookDao.getAccountBookListWithRegularity(user.getMe_id());

		if (regularityList == null) {
			return null;
		}

		for (AccountBookVO tmp : regularityList) {

			int regularity = tmp.getAb_regularity();
			int period = tmp.getAb_period();

			if (regularity == 0 || period == 0) {
				continue;
			}

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String search_date_str = formatter.format(tmp.getAb_date());

			int year = Integer.parseInt(search_date_str.substring(0, 4));
			int month = Integer.parseInt(search_date_str.substring(5, 7));
			int monthOfDay = Integer.parseInt(search_date_str.substring(8, 10));

			// LocalDate 객체 생성
			LocalDate search_date = LocalDate.of(year, month, monthOfDay);

			int now_year = Integer.parseInt(now_yyyy_MM.substring(0, 4));
			int nom_month = Integer.parseInt(now_yyyy_MM.substring(5, 7));

			// 해당 월의 마지막 날을 객체로 생성
			LocalDate nowDate = LocalDate.of(now_year, nom_month, 1)
					.withDayOfMonth(LocalDate.of(now_year, nom_month, 1).lengthOfMonth());

			if (search_date.isAfter(nowDate)) {
				// System.out.println(searchDate + " is after " + nowDate);
				// 현재 날짜 이후에 등록한 가계부여서 확인할 필요가 없다.
				continue;
			}

			if (period == 3) {

				LocalDate tmp_searchDate = search_date;

				if (isSameMonth(tmp_searchDate, nowDate)) {
					// 동일한 달이므로 처음 등록한 날이므로 추가 등록할 필요가 없다.
					continue;
				}

				while (!isSameMonth(tmp_searchDate, nowDate)) {
					tmp_searchDate = tmp_searchDate.plusMonths(1);
				}

				// 원래 날짜의 일(day) 값 가져오기
				int dayOfMonth = search_date.getDayOfMonth();

				// 증가된 월의 마지막 날 계산
				LocalDate lastDayOfMonth = tmp_searchDate.withDayOfMonth(tmp_searchDate.lengthOfMonth());

				// 유효하지 않은 경우 마지막 날로 설정
				if (dayOfMonth > lastDayOfMonth.getDayOfMonth()) {
					tmp_searchDate = lastDayOfMonth;
				} else {
					tmp_searchDate = tmp_searchDate.withDayOfMonth(dayOfMonth);
				}

				// LocalDate를 Date로 변환
				Date tmp_date = convertLocalDateToDate(tmp_searchDate);

				tmp.setAb_date(tmp_date);
				tmp.setAb_detail(
						"[정기 " + (tmp.getAb_at_num() == 1 ? "수입" : "지출") + "]" + "[등록일: " + search_date_str + "]");
				tmpList.add(tmp.clone());

				continue;

			} else {

				int step = period * 7; // 1주일 7, 2주일 14

				// step일을 추가
				LocalDate tmp_searchDate = search_date;
				
				if (isSameMonth(tmp_searchDate, nowDate)) { 
					// 같은 달이면 기간만큼만 더해준다.
					tmp_searchDate = tmp_searchDate.plusDays(step);
					// 더해줬을 때 다음 달로 넘어간다면. 저장할 필요X
					if(!isSameMonth(tmp_searchDate, nowDate)) {
						continue;
					}
				} 
				else {
					// 같은 년월이 나올 때 까지
					do {
						tmp_searchDate = tmp_searchDate.plusDays(step);
					} while (!isSameMonth(tmp_searchDate, nowDate));
				}
				do {
					// LocalDate를 Date로 변환
					Date tmp_date = convertLocalDateToDate(tmp_searchDate);

					tmp.setAb_date(tmp_date);
					tmp.setAb_detail(
							"[정기 " + (tmp.getAb_at_num() == 1 ? "수입" : "지출") + "]" + "[등록일: " + search_date_str + "]");
					tmpList.add(tmp.clone());

					tmp_searchDate = tmp_searchDate.plusDays(step);

				} while (isSameMonth(tmp_searchDate, nowDate));
			}
		}

		return tmpList;
	}

	public static Date convertLocalDateToDate(LocalDate localDate) {
		// LocalDate를 LocalDateTime으로 변환 (자정으로 설정)
		Instant instant = localDate.atStartOfDay(ZoneId.systemDefault()).toInstant();
		return Date.from(instant);
	}

	public static LocalDate setYear(LocalDate date, int year) {
		return date.withYear(year);
	}

	public boolean isSameYear(LocalDate date1, LocalDate date2) {
		return date1.getYear() == date2.getYear();
	}

	public boolean isSameMonth(LocalDate date1, LocalDate date2) {
		return date1.getYear() == date2.getYear() && date1.getMonth() == date2.getMonth();
	}

	public static List<AccountBookVO> add_accountBookList(List<AccountBookVO> ab_list,
			List<AccountBookVO> regularity_list, String now_yyyy_MM_dd) {

		if (now_yyyy_MM_dd.length() == 7) { // yyyy-MM이라면 달 검색 한 것.

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

			for (AccountBookVO tmp : regularity_list) {
				Date tmpDate = tmp.getAb_date();
				String tmpDateStr = sdf.format(tmpDate);
				System.out.println(tmpDate);
				System.out.println(tmpDateStr);
				if (tmpDateStr.equals(now_yyyy_MM_dd)) {
					System.out.println("hey~");
					ab_list.add(tmp.clone());
					System.out.println(ab_list);
				}
			}
		} else { // yyyy-MM-dd 일 검색.

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			for (AccountBookVO tmp : regularity_list) {
				Date tmpDate = tmp.getAb_date();
				String tmpDateStr = sdf.format(tmpDate);
				if (tmpDateStr.equals(now_yyyy_MM_dd)) {
					ab_list.add(tmp);
				}
			}
		}
		return ab_list;
	}

	public List<DayAmountDTO> addRegularityListFromAmount(List<DayAmountDTO> amount_list,
			List<AccountBookVO> regularity_list) {

		System.out.println(amount_list);
		System.out.println(regularity_list);
		for (AccountBookVO tmpAb : regularity_list) {
			boolean res = false;

			for (DayAmountDTO tmpAmount : amount_list) {
				if (tmpAmount.getDate().equals(tmpAb.getAb_date())) {
					if (tmpAb.getAb_at_num() == 1) {
						System.out.println("a");
						tmpAmount.setTotalIncome(tmpAmount.getTotalIncome() + tmpAb.getAb_amount());
					} else {
						System.out.println("b");
						tmpAmount.setTotalExpense(tmpAmount.getTotalExpense() + tmpAb.getAb_amount());
					}
					res = true;
					break;
				}
			}
			if (!res) {
				// DayAmountDTO 
				DayAmountDTO da;
				if (tmpAb.getAb_at_num() == 1) {
					System.out.println("c");
					da = new DayAmountDTO(tmpAb.getAb_date(), tmpAb.getAb_amount(), 0);
				} else {
					System.out.println("d");
					da = new DayAmountDTO(tmpAb.getAb_date(), 0, tmpAb.getAb_amount());
				}
				amount_list.add(da);
			}
		}

		return amount_list;
	}

}