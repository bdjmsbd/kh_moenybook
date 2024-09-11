package kr.kh.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.AccountTypeVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PaymentPurposeVO;
import kr.kh.app.model.vo.PaymentTypeVO;

public interface AccountBookDAO {

	List<PaymentPurposeVO> selectPaymentPurposeList();

	List<PaymentTypeVO> selectPaymentTypeList();

	void insertAccountBook(@Param("ab") AccountBookVO newAB);

	List<AccountBookVO> selectAccountBookList(@Param("user") MemberVO user, @Param("date")String searchDate);

	List<AccountTypeVO> selectAccountTypeList();

}