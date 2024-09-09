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
	private int ab_pt_num;
	private String ab_me_id;
	private Date ab_date;
	private int ab_amount;
	private String ab_detail;

	public AccountBookVO(int ab_at_num, int ab_pp_num, int ab_pt_num, String ab_me_id, Date ab_date, int ab_amount, String ab_detail, int regularity) {

		// ab_num : 수입 1 , 고정 수입 2, 지출 3, 고정 지출 4
		this.ab_at_num = (regularity == 1) ? ab_at_num + 1 : ab_at_num;
		this.ab_pp_num = ab_pp_num;
		this.ab_pt_num = ab_pt_num;
		this.ab_me_id = ab_me_id;
		this.ab_date = ab_date;
		this.ab_amount = ab_amount;
		this.ab_detail = ab_detail;
	}

}
