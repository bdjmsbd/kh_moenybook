USE accountBook;

INSERT INTO MEMBER_STATE(MS_NAME) VALUES('기간 정지'), ('영구 정지'), ('사용');
# 신고 타입을 추가 : 욕설, 허위사실유포, 광고, 음란, 커뮤니티에 맞지 않음, 기타
INSERT INTO REPROT_TYPE(RT_NAME) 
VALUES('욕설'),('허위사실유포'),('광고'),('음란'),('커뮤니티에 맞지 않음'),('기타');

# '공지' 커뮤니티를 등록 
INSERT INTO COMMUNITY(CO_NAME) VALUES('공지');

# '수다', '질문', '꿀팁' 커뮤니티를 추가
INSERT INTO COMMUNITY(CO_NAME) VALUES('수다');
INSERT INTO COMMUNITY(CO_NAME) VALUES('질문');
INSERT INTO COMMUNITY(CO_NAME) VALUES('꿀팁');

# 지출 종류 추가
INSERT INTO account_type(AT_NAME) VALUES('수입');
INSERT INTO account_type(AT_NAME) VALUES('지출');

# 지출 방법 추가
INSERT INTO payment_type(pt_name, pt_at_num) VALUES('수입', 1);
INSERT INTO payment_type(pt_name, pt_at_num) VALUES('현금', 2);
INSERT INTO payment_type(pt_name, pt_at_num) VALUES('카드', 2);
INSERT INTO payment_type(pt_name, pt_at_num) VALUES('계좌이체', 2);
INSERT INTO payment_type(pt_name, pt_at_num) VALUES('기타', 2);

# 지출 목적 추가
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('월급',1);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('용돈',1);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('기타 수입', 1);

INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('생필품비', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('문화비', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('교통비', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('전기요금', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('수도요금', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('가스요금', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('핸드폰', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('인터넷', 2);
INSERT INTO payment_purpose(pp_name, pp_at_num) VALUES('기타 지출', 2);


#INSERT INTO `accountbook`.`member` (`me_id`, `me_pw`, `me_email`, `me_authority`, `me_fail`, `me_report`, `me_ms_name`) VALUES ('a', 'a', 'a@a.com', 'ADMIN', '0', '0', '사용');
#INSERT INTO `accountbook`.`accountbook` (`ab_at_num`, `ab_pp_num`, `ab_pt_num`, `ab_me_id`, `ab_date`, `ab_amount`, `ab_regularity`, `ab_period`, `ab_detail`) 
#VALUES ('2', '1', '1', 'a', '2024-08-10', '50000', '1', '1', 'qwe');