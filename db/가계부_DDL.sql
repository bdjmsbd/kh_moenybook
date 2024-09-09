DROP DATABASE IF EXISTS accountBook;

CREATE DATABASE accountBook;

USE accountBook;

DROP TABLE IF EXISTS `accountBook`;

CREATE TABLE `accountBook` (
	`ab_num`	int primary key auto_increment	NOT NULL,
	`ab_at_num`	int	NOT NULL,
	`ab_pp_num`	int	NOT NULL,
	`ab_pt_num`	int	NOT NULL,
	`ab_me_id`	varchar(15)	NOT NULL,
	`ab_date`	date	NOT NULL,
	`ab_amount`	int	NOT NULL,
    `ab_regularity` int NOT NULL default 0, /* 0: 일회성, 1: 고정(주기적)*/
	`ab_period` int NOT NULL default 0,
	`ab_detail`	text	NULL
);

DROP TABLE IF EXISTS `account_type`;

CREATE TABLE `account_type` (
	`at_num`	int primary key auto_increment	NOT NULL,
	`at_name`	varchar(10)	NOT NULL
);

DROP TABLE IF EXISTS `payment_purpose`;

CREATE TABLE `payment_purpose` (
	`pp_num`	int primary key auto_increment	NOT NULL,
	`pp_name`	varchar(20)	NOT NULL,
    `pp_at_num` int not null /* 1: 수입, 2: 지출*/
);

DROP TABLE IF EXISTS `payment_type`;

CREATE TABLE `payment_type` (
	`pt_num`	int primary key auto_increment	NOT NULL,
	`pt_name`	varchar(10)	NOT NULL,
    `pt_at_num` int not null /* 1: 수입, 2: 지출*/
);


DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
	`me_id`	varchar(13)  primary key	NOT NULL,
	`me_pw`	varchar(255)			NOT NULL,
	`me_email`	varchar(50) unique	NOT NULL,
	`me_authority`	varchar(5)		NOT NULL DEFAULT 'USER',
	`me_fail`	int					NOT NULL DEFAULT 0,
	`me_cookie`	varchar(255)		NULL,
	`me_limit`	datetime			NULL,
	`me_report`	int					NOT NULL DEFAULT 0,
	`me_ms_name`	varchar(10)		NOT NULL,
	`me_stop`	datetime			NULL
);

DROP TABLE IF EXISTS `member_profil`;

CREATE TABLE `member_profil` (
	`mp_num`	int primary key auto_increment	NOT NULL,
	`mp_me_id`	varchar(15)	NOT NULL,
	`mp_nickname`	varchar(10)	NULL,
    `mp_pic_ori_name`	varchar(255)	NULL,
	`mp_pic_name`	varchar(255)	NULL
);

DROP TABLE IF EXISTS `community`;

CREATE TABLE `community` (
	`co_num`	int primary key auto_increment	NOT NULL,
	`co_name`	varchar(50) unique	NULL
);

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
	`po_num`	int primary key auto_increment	NOT NULL,
	`po_title`	varchar(50)		NOT NULL,
	`po_content`	longtext	NOT NULL,
	`po_me_id`	varchar(13)		NOT NULL,
	`po_co_num`	int				NOT NULL,
	`po_date`	datetime		NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`po_view`	int				NOT NULL DEFAULT 0,
	`po_report`	int				NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
	`fi_num`	int primary key auto_increment	NOT NULL,
	`fi_ori_name`	varchar(255)NOT NULL,
	`fi_name`	varchar(255)	NOT NULL,
	`fi_po_num`	int				NOT NULL
);

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
	`cm_num`	int  primary key	NOT NULL,
	`cm_content`varchar(200)		NOT NULL,
	`cm_po_num`	int					NOT NULL,
	`cm_ori_num`int					NOT NULL,
	`cm_date`	datetime			NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`cm_me_id`	varchar(13)			NOT NULL,
	`cm_report`	int					NOT NULL DEFAULT 0,
	`cm_state`	int					NOT NULL DEFAULT 0 # 0:삭제 안됨, 1:작성자가 삭제,2:관리자에 의해 삭제
);

DROP TABLE IF EXISTS `recommend`;

CREATE TABLE `recommend` (
	`re_num`	int primary key auto_increment	NOT NULL,
	`re_state`	int								NOT NULL,
	`re_po_num`	int								NOT NULL,
	`re_me_id`	varchar(13)						NOT NULL
);

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
	`rp_num`	int primary key auto_increment	NOT NULL,
	`rp_me_id`	varchar(13)						NOT NULL,
	`rp_table`	varchar(10)						NOT NULL,
	`rp_target`	int								NOT NULL,
	`rp_rt_name`	varchar(15)						NOT NULL
);

DROP TABLE IF EXISTS `reprot_type`;

CREATE TABLE `reprot_type` (
	`rt_name`	varchar(15)  primary key	NOT NULL
);

DROP TABLE IF EXISTS `member_state`;

CREATE TABLE `member_state` (
	`ms_name`	varchar(10) primary key	NOT NULL
);

ALTER TABLE `accountBook` ADD CONSTRAINT `FK_account_type_TO_accountBook_1` FOREIGN KEY (
	`ab_at_num`
)
REFERENCES `account_type` (
	`at_num`
);

ALTER TABLE `accountBook` ADD CONSTRAINT `FK_payment_purpose_TO_accountBook_1` FOREIGN KEY (
	`ab_pp_num`
)
REFERENCES `payment_purpose` (
	`pp_num`
);

ALTER TABLE `accountBook` ADD CONSTRAINT `FK_payment_type_TO_accountBook_1` FOREIGN KEY (
	`ab_pt_num`
)
REFERENCES `payment_type` (
	`pt_num`
);

ALTER TABLE `accountBook` ADD CONSTRAINT `FK_member_TO_accountBook_1` FOREIGN KEY (
	`ab_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `payment_purpose` ADD CONSTRAINT `FK_account_type_TO_payment_purpose_1` FOREIGN KEY (
	`pp_at_num`
)
REFERENCES `account_type` (
	`at_num`
);

ALTER TABLE `payment_type` ADD CONSTRAINT `FK_account_type_TO_payment_type_1` FOREIGN KEY (
	`pt_at_num`
)
REFERENCES `account_type` (
	`at_num`
);

ALTER TABLE `member` ADD CONSTRAINT `FK_member_state_TO_member_1` FOREIGN KEY (
	`me_ms_name`
)
REFERENCES `member_state` (
	`ms_name`
);

ALTER TABLE `post` ADD CONSTRAINT `FK_member_TO_post_1` FOREIGN KEY (
	`po_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `post` ADD CONSTRAINT `FK_community_TO_post_1` FOREIGN KEY (
	`po_co_num`
)
REFERENCES `community` (
	`co_num`
);

ALTER TABLE `file` ADD CONSTRAINT `FK_post_TO_file_1` FOREIGN KEY (
	`fi_po_num`
)
REFERENCES `post` (
	`po_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_post_TO_comment_1` FOREIGN KEY (
	`cm_po_num`
)
REFERENCES `post` (
	`po_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_member_TO_comment_1` FOREIGN KEY (
	`cm_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `recommend` ADD CONSTRAINT `FK_post_TO_recommend_1` FOREIGN KEY (
	`re_po_num`
)
REFERENCES `post` (
	`po_num`
);

ALTER TABLE `recommend` ADD CONSTRAINT `FK_member_TO_recommend_1` FOREIGN KEY (
	`re_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_member_TO_report_1` FOREIGN KEY (
	`rp_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_reprot_type_TO_report_1` FOREIGN KEY (
	`rp_rt_name`
)
REFERENCES `reprot_type` (
	`rt_name`
);

ALTER TABLE `member_profil` ADD CONSTRAINT `FK_member_TO_member_profil_1` FOREIGN KEY (
	`mp_me_id`
)
REFERENCES `member` (
	`me_id`
);

ALTER TABLE `post` DROP FOREIGN KEY `FK_community_TO_post_1`;
ALTER TABLE `post` 
ADD CONSTRAINT `FK_community_TO_post_1`
  FOREIGN KEY (`po_co_num`)
  REFERENCES `community` (`co_num`)
  ON DELETE CASCADE
  ON UPDATE RESTRICT;

ALTER TABLE `recommend` DROP FOREIGN KEY `FK_post_TO_recommend_1`;
ALTER TABLE `recommend` 
ADD CONSTRAINT `FK_post_TO_recommend_1`
  FOREIGN KEY (`re_po_num`)
  REFERENCES `post` (`po_num`)
  ON DELETE CASCADE;

ALTER TABLE `file` DROP FOREIGN KEY `FK_post_TO_file_1`;
ALTER TABLE `file` 
ADD CONSTRAINT `FK_post_TO_file_1`
  FOREIGN KEY (`fi_po_num`)
  REFERENCES `post` (`po_num`)
  ON DELETE CASCADE;
  
ALTER TABLE `comment` DROP FOREIGN KEY `FK_post_TO_comment_1`;
ALTER TABLE `comment` 
ADD CONSTRAINT `FK_post_TO_comment_1`
  FOREIGN KEY (`cm_po_num`)
  REFERENCES `post` (`po_num`)
  ON DELETE CASCADE;


