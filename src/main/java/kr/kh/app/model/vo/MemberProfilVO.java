package kr.kh.app.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberProfilVO {
	
	private int mp_num;
	private String mp_me_id;
	private String mp_nickname; 
	private String mp_pic_ori_name; 
	private String mp_pic_name; 
	
	
}