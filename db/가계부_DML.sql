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
INSERT INTO account_type(AT_NAME) VALUES('고정수입');
INSERT INTO account_type(AT_NAME) VALUES('지출');
INSERT INTO account_type(AT_NAME) VALUES('고정지출');

# 지출 방법 추가
INSERT INTO payment_type(pt_name) VALUES('수입');
INSERT INTO payment_type(pt_name) VALUES('현금');
INSERT INTO payment_type(pt_name) VALUES('카드');
INSERT INTO payment_type(pt_name) VALUES('계좌이체');
INSERT INTO payment_type(pt_name) VALUES('기타');

# 지출 목적 추가
INSERT INTO payment_purpose(pp_name) VALUES('월급');
INSERT INTO payment_purpose(pp_name) VALUES('생필품비');
INSERT INTO payment_purpose(pp_name) VALUES('문화비');
INSERT INTO payment_purpose(pp_name) VALUES('교통비');
INSERT INTO payment_purpose(pp_name) VALUES('전기요금');
INSERT INTO payment_purpose(pp_name) VALUES('수도요금');
INSERT INTO payment_purpose(pp_name) VALUES('가스요금');
INSERT INTO payment_purpose(pp_name) VALUES('핸드폰');
INSERT INTO payment_purpose(pp_name) VALUES('인터넷');
INSERT INTO payment_purpose(pp_name) VALUES('TV');
INSERT INTO payment_purpose(pp_name) VALUES('기타');
