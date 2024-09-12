package kr.kh.app.model.dto;

import java.util.Date;

import lombok.Data;

@Data
public class DayAmountDTO {

	private Date date;
	private int totalIncome;
	private int totalExpense;
}