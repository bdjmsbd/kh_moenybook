package kr.kh.app.service;

import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.kh.app.dao.MemberDAO;
import kr.kh.app.model.vo.MemberVO;

public class MemberService {
	
	private MemberDAO memberDao;

	public boolean signUp(MemberVO member) {
		if(member == null ||
			member.getMe_id() == null ||
			member.getMe_pw() == null ||
			member.getMe_email() == null) return false;
		
		if (checkRegex(member.getMe_id(), "^\\w{6,13}$")) return false;
		if (checkRegex(member.getMe_pw(), "^[a-zA-Z0-9!@#$%^&*()]{6,15}$")) return false;
		if (checkRegex(member.getMe_email(), "^[A-Za-z0-9_]+@[A-Za-z0-9_]+(\\.[A-Za-z]{2,}){1,}$")) return false;
		
		try {
			return memberDao.insertMember(member);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	private boolean checkRegex(String str, String regex) {

		if (str == null || str.trim().length() == 0) {
			return true;
		}

		if (Pattern.matches(regex, str)) {
			return false;
		}

		return true;

	}

	public boolean checkId(String me_id) {
		return memberDao.selectMember(me_id) == null;
	}

	
	public MemberVO login(MemberVO member) {
		if (member == null) {
			return null;
		}

		MemberVO user = memberDao.selectMember(member.getMe_id());

		// 가입되지 않은 아이디이면
		if (user == null) {
			return null;
		}
		// 비번이 같으면
		if (user.getMe_pw().equals(member.getMe_pw())) {
			return user;
		}
		return null;
	}
	
	public Cookie createCookie(MemberVO user, HttpServletRequest request) {
		if (user == null) {
			return null;
		}
		HttpSession session = request.getSession();
		// 쿠키는 이름, 값, 만료시간, path가 필요
		String me_cookie = session.getId();
		// 쿠키 이름이 AL, 값은 현재 세션 아이디값
		Cookie cookie = new Cookie("AL", me_cookie);
		cookie.setPath("/");
		int time = 60 * 60 * 24 * 7  * 1000;
		cookie.setMaxAge(time);
		user.setMe_cookie(me_cookie);
		// 만료시간은 현재 시간 + 1주일뒤
		Date date = new Date(System.currentTimeMillis() + time);
		user.setMe_limit(date);
		memberDao.updateMemberCookie(user);
		return cookie;
	}
	
	public MemberVO getMemberBySid(String sid) {
		return memberDao.selectMemberBySid(sid);
	}

	public void updateMemberCookie(MemberVO user) {
		memberDao.updateMemberCookie(user);
	}
}
