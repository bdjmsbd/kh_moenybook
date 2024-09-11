package kr.kh.app.service;

import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
		return accountBookDao.selectAccountBookList(user.getMe_id(), today);
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

}