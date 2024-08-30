package kr.kh.app.service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import kr.kh.app.model.vo.MemberVO;

public interface MemberService {

	boolean signUp(String id, String pw, String pw_ckh, String email);

	boolean checkId(String me_id);

	MemberVO login(MemberVO member);

	Cookie createCookie(MemberVO user, HttpServletRequest request);

	MemberVO getMemberBySid(String sid);

	void updateMemberCookie(MemberVO user);

}
