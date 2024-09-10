package kr.kh.app.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AccountBookVO {
	
	private int ab_num;
	private int ab_at_num;
	private int ab_pp_num;
	private String ab_me_id;
	private Date ab_date;
	private int ab_amount;
	private String ab_detail;

}