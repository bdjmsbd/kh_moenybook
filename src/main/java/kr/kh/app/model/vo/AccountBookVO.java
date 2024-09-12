package kr.kh.app.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AccountBookVO 
{

	private int ab_num;
	private int ab_at_num;
	private int ab_pp_num;
	private int ab_pt_num;
	private String ab_me_id;
	private Date ab_date;
	private int ab_amount;
	private int ab_regularity;
	private int ab_period;
	private String ab_detail;
	
	private int ex_sum;
	private int im_num;

	public AccountBookVO(int ab_at_num, int ab_pp_num, int ab_pt_num, String ab_me_id, Date ab_date, int ab_amount,
			String ab_detail, int ab_regularity, int ab_period) {

		try {

			this.ab_at_num = ab_at_num;
			this.ab_pp_num = ab_pp_num;
			this.ab_pt_num = ab_pt_num;
			this.ab_me_id = ab_me_id;
			this.ab_date = ab_date;
			this.ab_amount = ab_amount;
			this.ab_regularity = ab_regularity;
			this.ab_period = (ab_regularity == 0) ? 0 : ab_period;
			this.ab_detail = (ab_detail == null) ? "" : ab_detail;

		} catch (Exception e) {
			e.printStackTrace();
		}
	}



}
