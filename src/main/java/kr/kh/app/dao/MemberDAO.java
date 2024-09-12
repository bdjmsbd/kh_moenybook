package kr.kh.app.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.app.model.vo.MemberVO;

public interface MemberDAO {

	boolean insertMember(@Param("user")MemberVO newUser);

	MemberVO selectMember(@Param("me_id")String me_id);
	
	void updateMemberCookie(@Param("user")MemberVO user);

	MemberVO selectMemberBySid(@Param("sid")String sid);

	void deleteMember(@Param("user")MemberVO user);

	boolean updateMemberPw(@Param("user")MemberVO user, @Param("newpw")String newpw);

	boolean updateMemberEmail(@Param("user")MemberVO user, @Param("newemail")String newemail);

}