package kr.kh.app.service;

import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.kh.app.dao.AccountBookDAO;
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

	public List<AccountTypeVO> getAccountTypeList() {
		return accountBookDao.selectAccountTypeList();
	}
	
	public List<AccountBookVO> getAccountBookList(MemberVO user, String today) {
		if (user == null) return null;
		return accountBookDao.selectAccountBookList(user, today);
	}

	public List<AccountBookVO> getAccountBookList (MemberVO user, String searchExpense, String searchIncome, String searchBegin, String searchEnd) {
		if(user == null) return null;
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		// 문자열을 LocalDate로 변환
	    LocalDate date = LocalDate.parse(searchEnd, formatter);
	    
	    // 날짜 1일 증가
	    LocalDate nextDay = date.plusDays(1);
	    searchEnd = nextDay.format(formatter);
    
		List<AccountBookVO> list = new ArrayList<AccountBookVO>();
		
		if(searchIncome != null && searchIncome.equals("true")) {
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 1));
		}
		
		if(searchExpense != null && searchExpense.equals("true")) {
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 2));
		}
		
		if(searchIncome == null && searchExpense == null) {
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 1));
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 2));
		}
		
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

	public List<AccountBookVO> getExportList(MemberVO user) {
		if(user == null) return null;
		return accountBookDao.selectExportList(user.getMe_id());
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

}