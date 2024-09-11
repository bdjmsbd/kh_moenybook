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

	public List<AccountBookVO> getAccountBookList(MemberVO user, LocalDate selected) {
		if (user == null) return null;
		DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return accountBookDao.selectAccountBookList(user.getMe_id(), selected.format(format));
	}

	public List<AccountTypeVO> getAccountTypeList() {
		return accountBookDao.selectAccountTypeList();
	}
}