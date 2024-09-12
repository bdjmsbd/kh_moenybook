package kr.kh.app.service;

import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
		
		if(user == null) {
			return null;
		}
	
		return accountBookDao.selectAccountBookList(user, searchDate);
	}

	public List<AccountTypeVO> getAccountTypeList() {
		return accountBookDao.selectAccountTypeList();
	}

	public List<AccountBookVO> getAccountBookList
	(MemberVO user, String searchType, String searchBegin, String searchEnd) {
		
		if(user == null) return null;
		if(searchType == null) return null;
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-00");
		
//		// 문자열을 LocalDate로 변환
//    LocalDate date = LocalDate.parse(searchEnd, formatter);
//    
//    // 날짜 1일 증가
//    LocalDate nextDay = date.plusDays(1);
//    searchEnd = nextDay.format(formatter);
    
		List<AccountBookVO> list = new ArrayList<AccountBookVO>();
		
		// 0: 수입/지출 모두 조회, 1: 수입만 조회, 2: 지출만 조회
		switch(searchType) {
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
		
		if(ab_list == null) {
			return 0;
		}
		for(AccountBookVO accountbook : ab_list) {
			if(accountbook.getAb_at_num() == accountBook_type) sum += accountbook.getAb_amount(); 
		}
		
		return sum;
	}
	
	public void dummyGen() {
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		String id = "a"; // 아이디
		
		for(int i=1; i<500; i++) {
			int at = 1;
			int pp = (int)(Math.random() * 3) +1;
			int pt = 1;
			int amount = ((int)(Math.random() * 100) + 1) * 500;
			String month = Integer.toString((int)(Math.random() * 12) +1); 
			month = (month.length()==1)?"0"+month:month;
			String day = Integer.toString((int)(Math.random() * 28) +1); 
			day = (day.length()==1)?"0"+day:day;
			String date = "2024-"+ month + "-" + day;
			
			String detail = "더미데이터"+ Integer.toString(i);
			
			try {
				AccountBookVO ab = new AccountBookVO(1, pp, pt, id, formatter.parse(date), amount, detail, 0, 0);
				accountBookDao.insertAccountBook(ab);
				
				System.out.println("더미데이터 생성 " + ab.getAb_detail());
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		for(int i=500; i<=1000; i++) {
			int at = 2;
			int pp = (int)(Math.random() * 7) +4;
			int pt = (int)(Math.random() * 4) +2;
			int amount = ((int)(Math.random() * 100) + 1) * 500;
			String month = Integer.toString((int)(Math.random() * 12) +1); 
			month = (month.length()==1)?"0"+month:month;
			String day = Integer.toString((int)(Math.random() * 28) +1); 
			day = (day.length()==1)?"0"+day:day;
			String date = "2024-"+ month + "-" + day;
			String detail = "더미데이터"+ Integer.toString(i);
			try {
				AccountBookVO ab = new AccountBookVO(2, pp, pt, id, formatter.parse(date), amount, detail, 0, 0);
				accountBookDao.insertAccountBook(ab);
				
				System.out.println("더미데이터 생성 " + ab.getAb_detail());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public List<DayAmountDTO> getAmountList(MemberVO user, String date_amount) {
		
		
		return accountBookDao.getAmountList(user.getMe_id(),date_amount);
	}

	public boolean deleteAccountBook(MemberVO user, String ab_numStr) {
		
		if(user == null || ab_numStr == null) {
			return false;
		}
		int res = accountBookDao.deleteAccountBook(user.getMe_id(), ab_numStr);
		
		// 일치하는 accountbook 정보가 없다면.
		if(res == 0) { 
			return false; 
		}
		 
		return true;
	}

	public AccountBookVO getAccountBook(MemberVO user, String ab_numStr) {
		
		if(user == null || ab_numStr == null) {
			return null;
		}

		return accountBookDao.selectAccountBook(user.getMe_id(), ab_numStr);

	}

	public boolean updateAccountBook(AccountBookVO newAB) {

		int res = accountBookDao.updateAccountBook(newAB);
		
		if(res ==0) { return false;}
		
		return true;
	}

}