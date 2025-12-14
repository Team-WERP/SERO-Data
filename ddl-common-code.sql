SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS common_code;
DROP TABLE IF EXISTS common_code_type;

CREATE TABLE common_code_type (
    id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    desciption VARCHAR(255) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE common_code (
    id INTEGER NOT NULL AUTO_INCREMENT,
    type_id INTEGER NOT NULL,
    parent_id INTEGER NULL,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    sort_order INTEGER NOT NULL,
    description VARCHAR(255) NULL,
    is_used TINYINT NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    CONSTRAINT FK_common_code_type_TO_common_code FOREIGN KEY (type_id) REFERENCES common_code_type (id),
    CONSTRAINT FK_common_code_TO_common_code FOREIGN KEY (parent_id) REFERENCES common_code (id)
);

SET FOREIGN_KEY_CHECKS = 1;

----------------------------------------------------------
-- 1) common_code_type INSERT (id 1001~1021)
----------------------------------------------------------
INSERT INTO common_code_type (id, name, code, desciption) VALUES
(1001, '직책', 'JOB_RANK', 'Job Rank'),
(1002, '직급', 'JOB_POS', 'Job Position'),
(1003, '재직 상태', 'EMP_STATUS', 'Employment Status'),
(1004, '자재 구분', 'MAT_TYPE', 'Material Type'),
(1005, '단위', 'UNIT_TYPE', 'Unit Type'),
(1006, '결재 구분', 'APPR_TYPE', 'Approval Type'),
(1007, '결재 상태', 'APPR_STATUS', 'Approval Status'),
(1008, '결재선 상태', 'APPR_LINE_STATUS', 'Approval Line Status'),
(1009, '공지사항 구분', 'NOTICE_TYPE', 'Notice Type'),
(1010, '창고 구분', 'WHS_TYPE', 'Warehouse Type'),
(1011, '창고 자재 변동이력 유형', 'WHS_TXN_TYPE', 'Warehouse Transaction Type'),
(1012, '자재 상태', 'MAT_STATUS', 'Material Status'),
(1013, '배송 상태', 'SHIP_STATUS', 'Shipping Status'),
(1014, '품목 거래 상태', 'TRADE_STATUS', 'Trade Status'),
(1015, '출고지시 상태', 'GI_STATUS', 'Goods Issue Status'),
(1016, '주문 상태', 'SO_STATUS', 'Sales Order Status'),
(1017, '생산라인 상태', 'LINE_STATUS', 'Line Status'),
(1018, '생산요청 상태', 'PR_STATUS', 'Production Request Status'),
(1019, '부서', 'DEPT_CODE', 'Department Code'),
(1020, '메뉴', 'MENU_CODE', 'Menu Code'),
(1021, '권한', 'AUTH_CODE', 'Authority Code');

----------------------------------------------------------
-- 2) common_code INSERT (2001부터 순차)
----------------------------------------------------------

-- 직책 (1001)
INSERT INTO common_code VALUES
(2001,1001,NULL,'CEO','JR_CEO',1,NULL,1),
(2002,1001,NULL,'팀장','JR_TL',2,NULL,1),
(2003,1001,NULL,'팀원','JR_TM',3,NULL,1);

-- 직급 (1002)
INSERT INTO common_code VALUES
(2004,1002,NULL,'사장','JP_CEO',1,NULL,1),
(2005,1002,NULL,'이사','JP_DIR',2,NULL,1),
(2006,1002,NULL,'부장','JP_MGR',3,NULL,1),
(2007,1002,NULL,'과장','JP_SM',4,NULL,1),
(2008,1002,NULL,'대리','JP_AM',5,NULL,1),
(2009,1002,NULL,'사원','JP_STF',6,NULL,1);

-- 재직 상태 (1003)
INSERT INTO common_code VALUES
(2010,1003,NULL,'재직','ES_ACT',1,NULL,1),
(2011,1003,NULL,'퇴사','ES_LV',2,NULL,1),
(2012,1003,NULL,'휴직','ES_RET',3,NULL,1);

-- 자재 구분 (1004)
INSERT INTO common_code VALUES
(2013,1004,NULL,'완제품','MAT_FG',1,'Finished Goods',1),
(2014,1004,NULL,'원부자재','MAT_RM',2,'Raw Materials',1);

-- 단위 (1005)
INSERT INTO common_code VALUES
(2015,1005,NULL,'개 (낱개)','UNIT_EA',1,NULL,1),
(2016,1005,NULL,'킬로그램','UNIT_KG',2,NULL,1),
(2017,1005,NULL,'박스','UNIT_BOX',3,NULL,1),
(2018,1005,NULL,'세트','UNIT_SET',4,NULL,1);

-- 결재 구분 (1006)
INSERT INTO common_code VALUES
(2019,1006,NULL,'결재','AT_APPR',1,'Approval',1),
(2020,1006,NULL,'협조','AT_RVW',2,'Reviewer',1),
(2021,1006,NULL,'참조','AT_REF',3,'Reference',1),
(2022,1006,NULL,'수신','AT_RCPT',4,'Recipient',1);

-- 결재 상태 (1007)
INSERT INTO common_code VALUES
(2023,1007,NULL,'결재중','AS_ING',1,NULL,1),
(2024,1007,NULL,'승인','AS_APPR',2,NULL,1),
(2025,1007,NULL,'반려','AS_RJCT',3,NULL,1);

-- 결재선 상태 (1008)
INSERT INTO common_code VALUES
(2026,1008,NULL,'승인','ALS_APPR',1,NULL,1),
(2027,1008,NULL,'반려','ALS_RJCT',2,NULL,1),
(2028,1008,NULL,'대기','ALS_PEND',3,NULL,1),
(2029,1008,NULL,'검토','ALS_RVW',4,NULL,1);

-- 공지사항 구분 (1009)
INSERT INTO common_code VALUES
(2030,1009,NULL,'사내','NOTICE_INTERNAL',1,NULL,1),
(2031,1009,NULL,'고객','NOTICE_CUSTOMER',2,NULL,1),
(2032,1009,NULL,'시스템','NOTICE_SYSTEM',3,NULL,1);

-- 창고 구분 (1010)
INSERT INTO common_code VALUES
(2033,1010,NULL,'창고','WHS_WH',1,NULL,1),
(2034,1010,NULL,'공장','WHS_PLT',2,NULL,1);

-- 창고 변동이력 (1011)
INSERT INTO common_code VALUES
(2035,1011,NULL,'입고','TXN_IN',1,NULL,1),
(2036,1011,NULL,'출고','TXN_OUT',2,NULL,1);

-- 자재 상태 (1012)
INSERT INTO common_code VALUES
(2037,1012,NULL,'정상','MAT_NORMAL',1,NULL,1),
(2038,1012,NULL,'판매 중단 예정','MAT_STOP_PREP',2,NULL,1),
(2039,1012,NULL,'판매 중단','MAT_STOP',3,NULL,1),
(2040,1012,NULL,'단종','MAT_DISCONTINUED',4,NULL,1);

-- 배송 상태 (1013)
INSERT INTO common_code VALUES
(2041,1013,NULL,'출고 완료','SHIP_ISSUED',1,NULL,1),
(2042,1013,NULL,'배송 중','SHIP_ING',2,NULL,1),
(2043,1013,NULL,'배송 완료','SHIP_DONE',3,NULL,1);

-- 품목 거래 상태 (1014)
INSERT INTO common_code VALUES
(2044,1014,NULL,'정상','TRADE_NORMAL',1,NULL,1),
(2045,1014,NULL,'거래 중단 예정','TRADE_STOP_PREP',2,NULL,1),
(2046,1014,NULL,'거래 중단','TRADE_STOP',3,NULL,1);

-- 출고지시 상태 (1015)
INSERT INTO common_code VALUES
(2047,1015,NULL,'지시검토','GI_RVW',1,NULL,1),
(2048,1015,NULL,'결재중','GI_APV_PEND',2,NULL,1),
(2049,1015,NULL,'결재승인','GI_APV_APPR',3,NULL,1),
(2050,1015,NULL,'결재반려','GI_APV_RJCT',4,NULL,1),
(2051,1015,NULL,'출고완료','GI_ISSUED',5,NULL,1),
(2052,1015,NULL,'배송중','GI_SHIP_ING',6,NULL,1),
(2053,1015,NULL,'배송완료','GI_SHIP_DONE',7,NULL,1),
(2054,1015,NULL,'취소','GI_CANCEL',8,NULL,1);

----------------------------------------------------------
-- 주문 상태 (1016) - 부모
----------------------------------------------------------
INSERT INTO common_code VALUES
(2055,1016,NULL,'주문 처리','ORD_PEND',1,NULL,1),
(2056,1016,NULL,'결재 처리','ORD_APPR',2,NULL,1),
(2057,1016,NULL,'진행중','ORD_ING',3,NULL,1),
(2058,1016,NULL,'완료','ORD_DONE',4,NULL,1);

----------------------------------------------------------
-- 주문 상태 하위
----------------------------------------------------------
INSERT INTO common_code VALUES
(2059,1016,2055,'접수대기','ORD_RED',1,'received',1),
(2060,1016,2055,'주문검토','ORD_RVW',2,'review',1),

(2061,1016,2056,'주문결재중','ORD_APPR_DONE',3,NULL,1),
(2062,1016,2056,'결재승인','ORD_APPR_PEND',4,NULL,1),
(2063,1016,2056,'결재반려','ORD_APPR_RJCT',1,NULL,1),

(2064,1016,2057,'작업요청','ORD_WORK_REQ',2,NULL,1),
(2065,1016,2057,'생산중','ORD_PRO',3,NULL,1),
(2066,1016,2057,'출고중','ORD_SHIP_READY',4,NULL,1),
(2067,1016,2057,'배송중','ORD_SHIPPING',1,NULL,1),

(2068,1016,2058,'배송완료','ORD_DONE_SHIP',2,NULL,1),
(2069,1016,2058,'주문취소','ORD_CANCEL',3,NULL,1);

----------------------------------------------------------
-- 생산라인 상태 (1017)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2070,1017,NULL,'사용','PL_ACTIVE',1,NULL,1),
(2071,1017,NULL,'미사용','PL_INACTIVE',2,NULL,1),
(2072,1017,NULL,'고장','PL_DOWN',3,NULL,1);

----------------------------------------------------------
-- 생산요청 상태 (1018)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2073,1018,NULL,'요청 검토','PR_RVW',1,NULL,1),
(2074,1018,NULL,'결재중','PR_APPR',2,NULL,1),
(2075,1018,NULL,'결재 승인','PR_APPR_DONE',3,NULL,1),
(2076,1018,NULL,'결재 반려','PR_RJCT',4,'rejected',1),
(2077,1018,NULL,'계획 수립','PR_PLANNED',5,NULL,1),
(2078,1018,NULL,'생산 중','PR_PRODUCING',6,NULL,1),
(2079,1018,NULL,'생산 완료','PR_DONE',7,NULL,1),
(2080,1018,NULL,'취소','PR_CANCEL',8,NULL,1);

----------------------------------------------------------
-- 부서 (1019) 부모
----------------------------------------------------------
INSERT INTO common_code VALUES
(2081,1019,NULL,'영업부','DEPT_SAL',1,NULL,1),
(2082,1019,NULL,'생산부','DEPT_PRO',2,NULL,1),
(2083,1019,NULL,'물류부','DEPT_WHS',3,NULL,1);

----------------------------------------------------------
-- 부서 하위 팀
----------------------------------------------------------
INSERT INTO common_code VALUES
(2084,1019,2081,'영업1팀','SAL1',4,NULL,1),
(2085,1019,2081,'영업2팀','SAL2',5,NULL,1),

(2086,1019,2082,'생산1팀','PRO1',6,NULL,1),
(2087,1019,2082,'생산2팀','PRO2',7,NULL,1),

(2088,1019,2083,'물류1팀','WHS1',8,NULL,1),
(2089,1019,2083,'물류2팀','WHS2',9,NULL,1);

----------------------------------------------------------
-- 메뉴 부모 (1020)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2090,1020,NULL,'고객포털','MENU_CLI',1,NULL,1),
(2091,1020,NULL,'주문','MENU_ORD',2,NULL,1),
(2092,1020,NULL,'생산','MENU_PRO',3,NULL,1),
(2093,1020,NULL,'재고•물류','MENU_WHS',4,NULL,1),
(2094,1020,NULL,'기준정보','MENU_MAS',5,NULL,1),
(2095,1020,NULL,'전자결재','MENU_APPR',6,NULL,1),
(2096,1020,NULL,'공지사항','MENU_NOTI',7,NULL,1),
(2097,1020,NULL,'관리자','MENU_ADMIN',8,NULL,1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_CLI)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2098,1020,2090,'대시보드','MC_DASH',9,'Dashboard',1),
(2099,1020,2090,'주문등록','MC_ORD_REG',10,'Register',1),
(2100,1020,2090,'주문조회','MC_ORD',11,'Order',1),
(2101,1020,2090,'주문배송조회','MC_ORD_DELIV',12,'Delivery',1),
(2102,1020,2090,'거래품목조회','MC_ITEM',13,'Item',1),
(2103,1020,2090,'배송지관리','MC_ADDR',14,'Address',1),
(2104,1020,2090,'기업정보관리','MC_CORP',15,'Corporation',1),
(2105,1020,2090,'공지사항','MC_NOTI',16,'Notice',1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_ORD)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2106,1020,2091,'대시보드','MO_DASH',17,'Dashboard',1),
(2107,1020,2091,'주문관리','MO_ORD',18,'Order',1),
(2108,1020,2091,'고객사관리','MO_CLI',19,'Client',1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_PRO)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2109,1020,2092,'대시보드','MP_DASH',20,'Dashboard',1),
(2110,1020,2092,'생산요청 관리','MP_REQ',21,'Request',1),
(2111,1020,2092,'생산계획 관리','MP_PLAN',22,'Plan',1),
(2112,1020,2092,'작업지시 관리','MP_WO',23,'Work Order',1),
(2113,1020,2092,'작업지시 실적 등록','MP_RSLT_REG',24,'Result Registration',1),
(2114,1020,2092,'작업지시 실적 관리','MP_RSLT',25,'Result',1),
(2115,1020,2092,'공정 흐름 관리','MP_FLOW',26,'Flow',1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_WHS)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2116,1020,2093,'재고관리(창고별)','MW_STOCK',27,'Stock',1),
(2117,1020,2093,'출고지시 관리','MW_OUT',28,'Outbound',1),
(2118,1020,2093,'배송상태 추적','MW_DELIV',29,'Delivery',1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_MAS)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2119,1020,2094,'자재·BOM 관리','MM_MAT',30,'Material',1),
(2120,1020,2094,'기업정보 관리','MM_CORP',31,'Corporation',1),
(2121,1020,2094,'사원정보 조회','MM_EMP',32,'Employee',1),
(2122,1020,2094,'공통코드 관리','MM_CODE',33,'Code',1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_APPR)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2123,1020,2095,'대시보드','MA_DASH',34,'Dashboard',1),
(2124,1020,2095,'결재상신함','MA_OUTBOX',35,'Outbox',1),
(2125,1020,2095,'결재수신함','MA_INBOX',36,'Inbox',1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_NOTI)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2126,1020,2096,'공지사항','MN_NOTI',37,'Notice',1);

----------------------------------------------------------
-- 메뉴 하위 (MENU_ADMIN)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2127,1020,2097,'공통코드 관리','MS_COM',39,'Common Code',1),
(2128,1020,2097,'사원 정보 관리','MS_EMP',40,'Employee',1),
(2129,1020,2097,'사용자 권한 관리','MS_PER',41,'Permission',1);

----------------------------------------------------------
-- 권한 (1021)
----------------------------------------------------------
INSERT INTO common_code VALUES
(2130,1021,NULL,'시스템 관리자','AC_SYS',1,NULL,1),
(2131,1021,NULL,'영업','AC_SAL',2,NULL,1),
(2132,1021,NULL,'생산','AC_PRO',3,NULL,1),
(2133,1021,NULL,'물류','AC_WHS',4,NULL,1),
(2134,1021,NULL,'고객','AC_CLI',5,NULL,1);