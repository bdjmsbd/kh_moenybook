package kr.kh.app.model.dto;

import lombok.Data;

@Data
public class CalendarDTO {
	
	private int year;
	private int month;
	private int day;
	private int firstDay;
	private int lastDate;
	private int startBlankCnt;
	private int endBlankCnt;
	private int tdCnt;
}
