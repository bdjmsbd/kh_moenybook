package kr.kh.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.app.dao.MemberDAO;

@Service
public class MemberServiceImp implements MemberService {

	@Autowired
	MemberDAO memberDao;
	
	@Override
	public String getEmail(String string) {
		return memberDao.getEmail(string);
	}

}
