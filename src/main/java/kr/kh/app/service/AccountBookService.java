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

	public List<AccountTypeVO> getAccountTypeList() {
		return accountBookDao.selectAccountTypeList();
	}
	
	public List<AccountBookVO> getAccountBookList(MemberVO user, String today) {
		if (user == null) return null;
		return accountBookDao.selectAccountBookList(user, today);
	}

	public List<AccountBookVO> getAccountBookList (MemberVO user, String searchExpense, String searchIncome, String searchBegin, String searchEnd) {
		if(user == null) return null;
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-00");
		
		// 문자열을 LocalDate로 변환
	    LocalDate date = LocalDate.parse(searchEnd, formatter);
	    
	    // 날짜 1일 증가
	    LocalDate nextDay = date.plusDays(1);
	    searchEnd = nextDay.format(formatter);
    
		List<AccountBookVO> list = new ArrayList<AccountBookVO>();
		
		if(searchIncome != null && searchIncome.equals("true")) {
			list.addAll(accountBookDao.selectAccountBookListFromDate(user.getMe_id(), searchBegin, searchEnd, 1));
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

	public List<AccountBookVO> getExportList(MemberVO user) {
		if(user == null) return null;
		return accountBookDao.selectExportList(user.getMe_id());
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