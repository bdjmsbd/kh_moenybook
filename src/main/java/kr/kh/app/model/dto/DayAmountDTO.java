package kr.kh.app.model.dto;

import java.util.Calendar;
import java.util.Date;

import lombok.Data;

@Data
public class DayAmountDTO {

	private Date date;
	private int totalIncome;
	private int totalExpense;
	
	private int day;
	
	public void initDay() {
		
		 // Calendar 객체 생성 및 Date 설정
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(date);

    // 일(day) 추출
    int dom = calendar.get(Calendar.DAY_OF_MONTH);

    // 결과 출력
    System.out.println("일(day): " + dom);
    
    this.day = dom;
	}
	
}