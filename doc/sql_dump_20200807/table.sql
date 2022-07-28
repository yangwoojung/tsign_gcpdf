SELECT	FM.FORM_SEQ,  
				FM.FORM_NM, 
			-- FM.DATE_FORMAT(FM.REG_DATE,'%Y-%m-%d') FM.REG_DATE,
				FM.REG_ID, 
				FM.MOD_DATE, 
				FM.MOD_ID,
				AT.AF10_ONAME, -- 원본파일명
				at.AF10_SNAME
		FROM form_mgmt FM 
		LEFT JOIN af10 AT on AT.AF10_TNAME = 'form_mgmt' and FM.FORM_SEQ = at.AF10_TSEQ ;
	select * from af10  where AF10_TNAME  = 'form_mgmt'
	;

SELECT	FM.FORM_SEQ,  
				FM.FORM_NM, 
			--	FM.DATE_FORMAT(FM.REG_DATE,'%Y-%m-%d') REG_DATE,
				FM.REG_ID, 
				FM.MOD_DATE, 
				FM.MOD_ID,
				AT.AF10_ONAME,
				AT.AF10_SNAME
		FROM form_mgmt FM 
		LEFT JOIN af10 AT 
		  ON AT.AF10_TNAME = NULL
		 AND FM.FORM_SEQ = AT.AF10_TSEQ  
	 
		 
		ORDER BY FM.FORM_SEQ DESC
	LIMIT 0, 10
		;
	SELECT	FM.FORM_SEQ,  
				FM.FORM_NM, 
				FM.FILE_NO,
			--	FM.DATE_FORMAT(FM.REG_DATE,'%Y-%m-%d') REG_DATE,
				FM.REG_ID, 
				FM.MOD_DATE, 
				FM.MOD_ID,
				AT.AF10_ONAME, -- 원본파일명
				AT.AF10_SNAME
		FROM form_mgmt FM 
		LEFT JOIN af10 AT 
		       ON AT.af10_seq = FM.FILE_NO
	 
		 
		  
	 
		 
		ORDER BY FM.FORM_SEQ DESC
	LIMIT 0, 10
	;
;select * from form_mgmt;	
commit;
insert into form_mgmt 
(FILE_NO ,FORM_NM , FORM_SEQ )
values(16,'123양우정 서식 추가 1', 1);

select * from af10;

delete from form_mgmt where FORM_SEQ  = 16;



CREATE TABLE `FORM_MGMT` (
  `FORM_SEQ` int(11) NOT NULL AUTO_INCREMENT COMMENT '서식항번',
  `FORM_NM` varchar(100) DEFAULT NULL COMMENT '서식명',
  `FILE_NO` int(11) DEFAULT NULL COMMENT '첨부파일  항번(조인)',
  `REG_DATE` datetime DEFAULT NULL COMMENT '등록일시',
  `REG_ID` varchar(100) DEFAULT NULL COMMENT '등록자',
  `MOD_DATE` datetime DEFAULT NULL COMMENT '수정일시',
  `MOD_ID` varchar(100) DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`FORM_SEQ`)
  ) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='서식 관리';
  select * from contract_mgmt cm ;
 drop table CONTRACT_MGMT;
 ;
 -- 계약관리
CREATE TABLE CONTRACT_MGMT (
	CONTRC_NO       CHAR(14)     NOT NULL COMMENT '계약번호', -- 계약번호
	FORM_SEQ        VARCHAR(11)  NOT NULL COMMENT '서식항번', -- 서식항번
	USER_NM         VARCHAR(50)  NOT NULL COMMENT '사용자명', -- 사용자명
	CELL_NO         VARCHAR(20)  NOT NULL COMMENT '핸드폰번호', -- 핸드폰번호
	EMAIL           VARCHAR(50)  NULL     COMMENT '이메일', -- 이메일
	SIGN_DUE_SDATE  CHAR(8)      NOT NULL COMMENT '서명기한시작일자', -- 서명기한시작일자
	SIGN_DUE_EDATE  CHAR(8)      NOT NULL COMMENT '서명기한종료일자', -- 서명기한종료일자
	IN_CELL_NO      VARCHAR(20)  NULL     COMMENT '입력핸드폰번호', -- 입력핸드폰번호
	IN_RESIDENT_NO  VARCHAR(100) NULL     COMMENT '입력주민번호', -- 입력주민번호
	IN_USER_NM      VARCHAR(50)  NULL     COMMENT '입력사용자명', -- 입력사용자명
	IN_SIGN_DT      CHAR(8)      NULL     COMMENT '입력서명일자', -- 입력서명일자
	IN_ACNUT_NO     VARCHAR(50)  NULL     COMMENT '입력계좌번호', -- 입력계좌번호
	IN_BANK_CD      CHAR(10)     NULL     COMMENT '입력은행코드', -- 입력은행코드
	IN_BANK_NM      VARCHAR(20)  NULL     COMMENT '입력은행명', -- 입력은행명
	IN_CONTRC_EMAIL VARCHAR(50)  NULL     COMMENT '입력계약이메일', -- 입력계약이메일
	REG_DATE        DATETIME     NOT NULL COMMENT '등록일시', -- 등록일시
	REG_ID          VARCHAR(20)  NOT NULL COMMENT '등록ID', -- 등록ID
	MOD_DATE        DATETIME     NOT NULL COMMENT '수정일시', -- 수정일시
	MOD_ID          VARCHAR(20)  NOT NULL COMMENT '수정ID', -- 수정ID
    PRIMARY KEY (`CONTRC_NO`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='계약관리';

alter table contract_mgmt drop CMI_EMAIL;

alter table contract_mgmt add EMAIL VARCHAR(100) not null;

alter table contract_mgmt modify CONTRC_NO varchar(17);

