package kr.kh.app.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PaymentPurposeVO {
	private int pp_num;
	private String pp_name;
	private int pp_at_num;
}
