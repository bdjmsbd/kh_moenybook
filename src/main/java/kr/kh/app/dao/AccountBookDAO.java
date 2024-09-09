package kr.kh.app.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import kr.kh.app.model.vo.AccountBookVO;
import kr.kh.app.model.vo.AccountTypeVO;

public interface AccountBookDAO {

	List<AccountTypeVO> selectPaymentPurposeList();

	List<AccountTypeVO> selectPaymentTypeList();

	void insertAccountBook(@Param("ab") AccountBookVO newAB);

}
