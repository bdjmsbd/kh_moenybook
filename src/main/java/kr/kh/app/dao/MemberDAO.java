package kr.kh.app.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

@Service
public interface MemberDAO {
	
	String getEmail(@Param("me_id")String string);
}
