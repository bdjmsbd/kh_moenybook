package kr.kh.app.service;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.kh.app.dao.AccountBookDAO;
import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.AccountTypeVO;

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
	
	public List<AccountTypeVO> getPaymentPurposeList() {
		return accountBookDao.selectPaymentPurposeList();
	}

	public List<AccountTypeVO> getPaymentTypeList() {
		return accountBookDao.selectPaymentTypeList();
	}

	public void insertAccountBook(AccountBookVO newAB) {
		accountBookDao.insertAccountBook(newAB);
	}

}
