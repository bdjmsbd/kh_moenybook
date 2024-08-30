package kr.kh.app.service;

import java.io.InputStream;
import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.kh.app.dao.MemberDAO;
import kr.kh.app.model.vo.MemberVO;

public class MemberServiceImp implements MemberService {

	private MemberDAO memberDao;

	public MemberServiceImp() {
		String resource = "kr/kh/app/config/mybatis-config.xml";
		InputStream inputStream;
		SqlSession session;
		try {

			inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			session = sessionFactory.openSession(true);
			memberDao = session.getMapper(MemberDAO.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean signUp(String id, String pw, String pw_ckh, String email) {

		if (checkRegex(id, "^\\w{6,13}$")) {
			return false;
		}

		if (checkRegex(pw, "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[^\\w])([^\\w]{1}|[\\w]{1}){6,15}$")) {
			return false;
		}

		if (checkRegex(pw_ckh, "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[^\\w])([^\\w]{1}|[\\w]{1}){6,15}$")) {
			return false;
		}

		if (checkRegex(email, "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$")) {
			return false;
		}

		if (!pw.equals(pw_ckh)) {
			return false;
		}

		MemberVO newUser = new MemberVO(id, pw, email);
		try {
			memberDao.insertMember(newUser);

		} catch (Exception e) {

			e.printStackTrace();
			return false;
		}

		return true;
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

	@Override
	public boolean checkId(String me_id) {

		return memberDao.selectMember(me_id) == null;
	}

	@Override
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

	@Override
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

	@Override
	public MemberVO getMemberBySid(String sid) {
		// TODO Auto-generated method stub
		return memberDao.selectMemberBySid(sid);
	}

	@Override
	public void updateMemberCookie(MemberVO user) {
		// TODO Auto-generated method stub
		memberDao.updateMemberCookie(user);
	}

}
