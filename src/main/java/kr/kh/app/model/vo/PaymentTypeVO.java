package kr.kh.app.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PaymentTypeVO {
	private int pt_num;
	private String pt_name;
	private int pt_at_num;
}