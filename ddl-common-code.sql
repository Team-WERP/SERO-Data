SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS common_code;
DROP TABLE IF EXISTS common_code_type;

-- =====================================================
-- 1. 공통코드 타입
-- =====================================================
CREATE TABLE common_code_type (
    id INTEGER NOT NULL AUTO_INCREMENT,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NULL,
    PRIMARY KEY (id)
);

-- =====================================================
-- 2. 공통코드
-- =====================================================
CREATE TABLE common_code (
    id INTEGER NOT NULL AUTO_INCREMENT,
    type_code VARCHAR(50) NOT NULL,
    code VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    parent_code VARCHAR(50) NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    description VARCHAR(255) NULL,
    is_used TINYINT NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    UNIQUE KEY UK_type_code_code (type_code, code),
    CONSTRAINT FK_common_code_type_TO_common_code FOREIGN KEY (type_code) REFERENCES common_code_type(code)
);

-- =====================================================
-- 3. 공통코드 타입 데이터
-- =====================================================
INSERT INTO common_code_type (code, name, description) VALUES
('JOB_RANK','직책','Job Rank'),
('JOB_POS','직급','Job Position'),
('EMP_STATUS','재직 상태','Employment Status'),

('MAT_TYPE','자재 구분','Material Type'),
('UNIT_TYPE','단위','Unit Type'),
('MAT_STATUS','자재 상태','Material Status'),

('APPR_TYPE','결재 구분','Approval Type'),
('APPR_STATUS','결재 상태','Approval Status'),
('APPR_LINE_STATUS','결재선 상태','Approval Line Status'),
('NOTICE_TYPE','공지사항 구분','Notice Type'),
('WHS_TYPE','창고 구분','Warehouse Type'),
('WHS_TXN_TYPE','창고 자재 변동 유형','Warehouse Transaction'),

('SHIP_STATUS','배송 상태','Shipping Status'),
('TRADE_STATUS','품목 거래 상태','Trade Status'),
('GI_STATUS','출고지시 상태','Goods Issue Status'),
('SO_STATUS','주문 상태','Sales Order Status'),
('LINE_STATUS','생산라인 상태','Production Line Status'),
('PR_STATUS','생산요청 상태','Production Request Status'),
('PR_ITEM_STATUS', '생산요청 품목 상태', 'Production Request Item Status');
('DEPT_CODE','부서','Department'),
('MENU_CODE','메뉴','Menu'),
('AUTH_CODE','권한','Authority'),
('DOC_TYPE', '문서 구분', 'Document Type');

-- =====================================================
-- 4. 직책 / 직급 / 재직 상태
-- =====================================================
INSERT INTO common_code VALUES
(NULL,'JOB_RANK','JR_CEO','CEO',NULL,1,'Job Rank – Chief Executive Officer',1),
(NULL,'JOB_RANK','JR_TL','팀장',NULL,2,'Job Rank – Team Leader',1),
(NULL,'JOB_RANK','JR_TM','팀원',NULL,3,'Job Rank – Team Member',1),

(NULL,'JOB_POS','JP_CEO','사장',NULL,1,'Job Position – Chief Executive Officer',1),
(NULL,'JOB_POS','JP_DIR','이사',NULL,2,'Job Position – Director',1),
(NULL,'JOB_POS','JP_MGR','부장',NULL,3,'Job Position – Manager',1),
(NULL,'JOB_POS','JP_SM','과장',NULL,4,'Job Position – Section Manager',1),
(NULL,'JOB_POS','JP_AM','대리',NULL,5,'Job Position – Assistant Manager',1),
(NULL,'JOB_POS','JP_STF','사원',NULL,6,'Job Position – Staff',1),

(NULL,'EMP_STATUS','ES_ACT','재직',NULL,1,'Employment Status – Active',1),
(NULL,'EMP_STATUS','ES_LV','퇴사',NULL,2,'Employment Status – Leave',1),
(NULL,'EMP_STATUS','ES_RET','휴직',NULL,3,'Employment Status – Rest',1);

-- =====================================================
-- 5. 자재 구분 / 단위 / 자재 상태
-- =====================================================
INSERT INTO common_code VALUES
(NULL,'MAT_TYPE','MAT_FG','완제품',NULL,1,'Material – Finished Goods',1),
(NULL,'MAT_TYPE','MAT_RM','원부자재',NULL,2,'Material – Raw Material',1),

(NULL,'UNIT_TYPE','UNIT_EA','개',NULL,1,'Unit – Each',1),
(NULL,'UNIT_TYPE','UNIT_KG','킬로그램',NULL,2,'Unit – Kilogram',1),
(NULL,'UNIT_TYPE','UNIT_BOX','박스',NULL,3,'Unit – Box',1),
(NULL,'UNIT_TYPE','UNIT_SET','세트',NULL,4,'Unit – Set',1),

(NULL,'MAT_STATUS','MAT_NORMAL','정상',NULL,1,'Material – Normal',1),
(NULL,'MAT_STATUS','MAT_STOP_PREP','판매 중단 예정',NULL,2,'Material – Stop Preparation',1),
(NULL,'MAT_STATUS','MAT_STOP','판매 중단',NULL,3,'Material – Stop',1),
(NULL,'MAT_STATUS','MAT_DISCONTINUED','단종',NULL,4,'Material – Discontinued',1);

-- =====================================================
-- 6. 결재 구분 / 결재 상태 / 결재선 상태
-- =====================================================
INSERT INTO common_code VALUES
(NULL,'APPR_TYPE','AT_APPR','결재',NULL,1,'Approval Type – Approval',1),
(NULL,'APPR_TYPE','AT_RVW','협조',NULL,2,'Approval Type – Reviewer',1),
(NULL,'APPR_TYPE','AT_REF','참조',NULL,3,'Approval Type – Reference',1),
(NULL,'APPR_TYPE','AT_RCPT','수신',NULL,4,'Approval Type – Recipient',1),

(NULL,'APPR_STATUS','AS_ING','결재중',NULL,1,'Approval Status – In Progress',1),
(NULL,'APPR_STATUS','AS_APPR','승인',NULL,2,'Approval Status – Approved',1),
(NULL,'APPR_STATUS','AS_RJCT','반려',NULL,3,'Approval Status – Rejected',1),

(NULL,'APPR_LINE_STATUS','ALS_PEND','대기',NULL,1,'Approval Line Status – Pending',1),
(NULL,'APPR_LINE_STATUS','ALS_RVW','검토',NULL,2,'Approval Line Status – Review',1),
(NULL,'APPR_LINE_STATUS','ALS_APPR','승인',NULL,3,'Approval Line Status – Approved',1),
(NULL,'APPR_LINE_STATUS','ALS_RJCT','반려',NULL,4,'Approval Line Status – Rejected',1);

-- =====================================================
-- 7. 공지사항 구분 / 창고 구분 / 창고 자재 변동이력 유형
-- =====================================================
INSERT INTO common_code VALUES
(NULL,'NOTICE_TYPE','NOTICE_INTERNAL','사내',NULL,1,'Notice Type – Internal',1),
(NULL,'NOTICE_TYPE','NOTICE_CUSTOMER','고객',NULL,2,'Notice Type – Customer',1),
(NULL,'NOTICE_TYPE','NOTICE_SYSTEM','시스템',NULL,3,'Notice Type – System',1),

(NULL,'WHS_TYPE','WHS_WH','창고',NULL,1,'Warehouse Type – Warehouse',1),
(NULL,'WHS_TYPE','WHS_PLT','공장',NULL,2,'Warehouse Type – Plant/Factory',1),

(NULL,'WHS_TXN_TYPE','TXN_IN','입고',NULL,1,'Warehouse Transaction – Inbound',1),
(NULL,'WHS_TXN_TYPE','TXN_OUT','출고',NULL,2,'Warehouse Transaction – Outbound',1);

-- =====================================================
-- 8. 배송 상태 / 품목 거래 상태 / 출고지시 상태
-- =====================================================
INSERT INTO common_code VALUES
(NULL,'SHIP_STATUS','SHIP_ISSUED','출고 완료',NULL,1,'Shipping Status – Issued',1),
(NULL,'SHIP_STATUS','SHIP_ING','배송 중',NULL,2,'Shipping Status – In Transit',1),
(NULL,'SHIP_STATUS','SHIP_DONE','배송 완료',NULL,3,'Shipping Status – Delivered',1),

(NULL,'TRADE_STATUS','TRADE_NORMAL','정상',NULL,1,'Trade Status – Normal',1),
(NULL,'TRADE_STATUS','TRADE_STOP_PREP','거래 중단 예정',NULL,2,'Trade Status – Stop Preparation',1),
(NULL,'TRADE_STATUS','TRADE_STOP','거래 중단',NULL,3,'Trade Status – Stopped',1),

(NULL,'GI_STATUS','GI_RVW','지시검토',NULL,1,'Goods Issue Status – Review',1),
(NULL,'GI_STATUS','GI_APV_PEND','결재중',NULL,2,'Goods Issue Status – Approval Pending',1),
(NULL,'GI_STATUS','GI_APV_APPR','결재승인',NULL,3,'Goods Issue Status – Approval Approved',1),
(NULL,'GI_STATUS','GI_APV_RJCT','결재반려',NULL,4,'Goods Issue Status – Approval Rejected',1),
(NULL,'GI_STATUS','GI_ISSUED','출고완료',NULL,5,'Goods Issue Status – Issued',1),
(NULL,'GI_STATUS','GI_SHIP_ING','배송중',NULL,6,'Goods Issue Status – Shipping',1),
(NULL,'GI_STATUS','GI_SHIP_DONE','배송완료',NULL,7,'Goods Issue Status – Delivered',1),
(NULL,'GI_STATUS','GI_CANCEL','취소',NULL,8,'Goods Issue Status – Canceled',1);

-- =====================================================
-- 9. 주문 상태 (부모 / 자식)
-- =====================================================
INSERT INTO common_code VALUES
(NULL,'SO_STATUS','ORD_PEND','주문 처리',NULL,1,'Order – Pending',1),
(NULL,'SO_STATUS','ORD_APPR','결재 처리',NULL,2,'Order – Approval',1),
(NULL,'SO_STATUS','ORD_ING','진행중',NULL,3,'Order – In Progress',1),
(NULL,'SO_STATUS','ORD_DONE','완료',NULL,4,'Order – Done',1),

(NULL,'SO_STATUS','ORD_RED','접수대기','ORD_PEND',5,'Order – Received',1),
(NULL,'SO_STATUS','ORD_RVW','주문검토','ORD_PEND',6,'Order – Review',1),

(NULL,'SO_STATUS','ORD_APPR_PEND','주문결재중','ORD_APPR',7,'Order – Approval Pending',1),
(NULL,'SO_STATUS','ORD_APPR_DONE','결재승인','ORD_APPR',8,'Order – Approval Done',1),
(NULL,'SO_STATUS','ORD_APPR_RJCT','결재반려','ORD_APPR',9,'Order – Approval Rejected',1),

(NULL,'SO_STATUS','ORD_WORK_REQ','작업요청','ORD_ING',10,'Order – Work Request',1),
(NULL,'SO_STATUS','ORD_PRO','생산중','ORD_ING',11,'Order – Production',1),
(NULL,'SO_STATUS','ORD_SHIP_READY','출고중','ORD_ING',12,'Order – Shipping Ready',1),
(NULL,'SO_STATUS','ORD_SHIPPING','배송중','ORD_ING',13,'Order – Shipping',1),

(NULL,'SO_STATUS','ORD_DONE_SHIP','배송완료','ORD_DONE',14,'Order – Done Shipping',1),
(NULL,'SO_STATUS','ORD_CANCEL','주문취소','ORD_DONE',15,'Order – Cancel',1);

-- =====================================================
-- 10. 생산요청 상태 / 생산라인 상태
-- =====================================================
INSERT INTO common_code VALUES
(NULL,'PR_STATUS','PR_TMP','임시 저장',NULL,0,'Production Request – Temporary',1),
(NULL,'PR_STATUS','PR_RVW','요청 검토',NULL,1,'Production Request – Review',1),
(NULL,'PR_STATUS','PR_APPR','결재중',NULL,2,'Production Request – Approval In Progress',1),
(NULL,'PR_STATUS','PR_APPR_DONE','결재 승인',NULL,3,'Production Request – Approval Done',1),
(NULL,'PR_STATUS','PR_RJCT','결재 반려',NULL,4,'Production Request – Rejected',1),
(NULL,'PR_STATUS','PR_PLANNED','계획 수립',NULL,5,'Production Request – Planned',1),
(NULL,'PR_STATUS','PR_PRODUCING','생산 중',NULL,6,'Production Request – Producing',1),
(NULL,'PR_STATUS','PR_DONE','생산 완료',NULL,7,'Production Request – Done',1),
(NULL,'PR_STATUS','PR_CANCEL','취소',NULL,8,'Production Request – Canceled',1);

INSERT INTO common_code VALUES
(NULL,'LINE_STATUS','PL_ACTIVE','사용',NULL,1,'Production Line Status – Active',1),
(NULL,'LINE_STATUS','PL_INACTIVE','미사용',NULL,2,'Production Line Status – Inactive',1),
(NULL,'LINE_STATUS','PL_DOWN','고장',NULL,3,'Production Line Status – Down',1);

INSERT INTO common_code (type_code, code, name, sort_order, description) VALUES
('PR_ITEM_STATUS','PIS_WAIT','대기',1,'결재 승인 후 생산 대기'),
('PR_ITEM_STATUS','PIS_PLANNED','계획수립',2,'생산계획 수립 완료'),
('PR_ITEM_STATUS','PIS_PRODUCING','생산중',3,'작업지시 진행 중'),
('PR_ITEM_STATUS','PIS_DONE','생산완료',4,'해당 품목 생산 완료');

-- =====================================================
-- 11. 부서
-- =====================================================

INSERT INTO common_code VALUES
(NULL,'DEPT_CODE','DEPT_SAL','영업부',NULL,1,'Department – Sales',1),
(NULL,'DEPT_CODE','DEPT_PRO','생산부',NULL,2,'Department – Production',1),
(NULL,'DEPT_CODE','DEPT_WHS','물류부',NULL,3,'Department – Warehouse',1),

(NULL,'DEPT_CODE','DEPT_SAL_1','영업1팀','DEPT_SAL',4,'Department – Sales Team 1',1),
(NULL,'DEPT_CODE','DEPT_SAL_2','영업2팀','DEPT_SAL',5,'Department – Sales Team 2',1),
(NULL,'DEPT_CODE','DEPT_PRO_1','생산1팀','DEPT_PRO',6,'Department – Production Team 1',1),
(NULL,'DEPT_CODE','DEPT_PRO_2','생산2팀','DEPT_PRO',7,'Department – Production Team 2',1),
(NULL,'DEPT_CODE','DEPT_WHS_1','물류1팀','DEPT_WHS',8,'Department – Warehouse Team 1',1),
(NULL,'DEPT_CODE','DEPT_WHS_2','물류2팀','DEPT_WHS',9,'Department – Warehouse Team 2',1);

-- =====================================================
-- 12. 메뉴
-- =====================================================

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MENU_CLI','고객포털',NULL,1,'Menu – Client Portal',1),
(NULL,'MENU_CODE','MENU_ORD','주문',NULL,2,'Menu – Order',1),
(NULL,'MENU_CODE','MENU_PRO','생산',NULL,3,'Menu – Production',1),
(NULL,'MENU_CODE','MENU_WHS','재고·물류',NULL,4,'Menu – Warehouse / Logistics',1),
(NULL,'MENU_CODE','MENU_MAS','기준정보',NULL,5,'Menu – Master Data',1),
(NULL,'MENU_CODE','MENU_APPR','전자결재',NULL,6,'Menu – Approval',1),
(NULL,'MENU_CODE','MENU_NOTI','공지사항',NULL,7,'Menu – Notice',1),
(NULL,'MENU_CODE','MENU_ADMIN','관리자',NULL,8,'Menu – Admin',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MC_DASH','대시보드','MENU_CLI',10,'Menu(Client) – Dashboard',1),
(NULL,'MENU_CODE','MC_ORD_REG','주문등록','MENU_CLI',11,'Menu(Client) – Order Registration',1),
(NULL,'MENU_CODE','MC_ORD','주문조회','MENU_CLI',12,'Menu(Client) – Order Inquiry',1),
(NULL,'MENU_CODE','MC_ORD_DELIV','주문·배송조회','MENU_CLI',13,'Menu(Client) – Order & Delivery',1),
(NULL,'MENU_CODE','MC_ITEM','거래품목조회','MENU_CLI',14,'Menu(Client) – Items',1),
(NULL,'MENU_CODE','MC_ADDR','배송지관리','MENU_CLI',15,'Menu(Client) – Address',1),
(NULL,'MENU_CODE','MC_CORP','기업정보관리','MENU_CLI',16,'Menu(Client) – Corporation',1),
(NULL,'MENU_CODE','MC_NOTI','공지사항','MENU_CLI',17,'Menu(Client) – Notice',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MO_DASH','대시보드','MENU_ORD',20,'Menu(Order) – Dashboard',1),
(NULL,'MENU_CODE','MO_ORD','주문관리','MENU_ORD',21,'Menu(Order) – Order Management',1),
(NULL,'MENU_CODE','MO_CLI','고객사관리','MENU_ORD',22,'Menu(Order) – Client Management',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MP_DASH','대시보드','MENU_PRO',30,'Menu(Production) – Dashboard',1),
(NULL,'MENU_CODE','MP_REQ','생산요청 관리','MENU_PRO',31,'Menu(Production) – Production Request',1),
(NULL,'MENU_CODE','MP_PLAN','생산계획 관리','MENU_PRO',32,'Menu(Production) – Production Plan',1),
(NULL,'MENU_CODE','MP_WO','작업지시 관리','MENU_PRO',33,'Menu(Production) – Work Order',1),
(NULL,'MENU_CODE','MP_RSLT_REG','작업지시 실적 등록','MENU_PRO',34,'Menu(Production) – Result Registration',1),
(NULL,'MENU_CODE','MP_RSLT','작업지시 실적 관리','MENU_PRO',35,'Menu(Production) – Result Management',1),
(NULL,'MENU_CODE','MP_FLOW','공정 흐름 관리','MENU_PRO',36,'Menu(Production) – Process Flow',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MW_STOCK','재고관리(창고별)','MENU_WHS',40,'Menu(Warehouse) – Stock',1),
(NULL,'MENU_CODE','MW_OUT','출고지시 관리','MENU_WHS',41,'Menu(Warehouse) – Goods Issue',1),
(NULL,'MENU_CODE','MW_DELIV','배송상태 추적','MENU_WHS',42,'Menu(Warehouse) – Delivery Tracking',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MM_MAT','자재·BOM 관리','MENU_MAS',50,'Menu(Master) – Material & BOM',1),
(NULL,'MENU_CODE','MM_CORP','기업정보 관리','MENU_MAS',51,'Menu(Master) – Corporation',1),
(NULL,'MENU_CODE','MM_EMP','사원정보 조회','MENU_MAS',52,'Menu(Master) – Employee',1),
(NULL,'MENU_CODE','MM_CODE','공통코드 관리','MENU_MAS',53,'Menu(Master) – Common Code',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MA_DASH','대시보드','MENU_APPR',60,'Menu(Approval) – Dashboard',1),
(NULL,'MENU_CODE','MA_OUTBOX','결재상신함','MENU_APPR',61,'Menu(Approval) – Outbox',1),
(NULL,'MENU_CODE','MA_INBOX','결재수신함','MENU_APPR',62,'Menu(Approval) – Inbox',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MN_NOTI','공지사항','MENU_NOTI',70,'Menu(Notice) – Notice',1);

INSERT INTO common_code VALUES
(NULL,'MENU_CODE','MS_COM','공통코드 관리','MENU_ADMIN',80,'Menu(Admin) – Common Code',1),
(NULL,'MENU_CODE','MS_EMP','사원 정보 관리','MENU_ADMIN',81,'Menu(Admin) – Employee',1),
(NULL,'MENU_CODE','MS_PER','사용자 권한 관리','MENU_ADMIN',82,'Menu(Admin) – Permission',1);

-- =====================================================
-- 13. 권한
-- =====================================================

INSERT INTO common_code VALUES
(NULL,'AUTH_CODE','AC_SYS','시스템 관리자',NULL,1,'Authority – System Administrator',1),
(NULL,'AUTH_CODE','AC_SAL','영업',NULL,2,'Authority – Sales',1),
(NULL,'AUTH_CODE','AC_PRO','생산',NULL,3,'Authority – Production',1),
(NULL,'AUTH_CODE','AC_WHS','물류',NULL,4,'Authority – Warehouse / Logistics',1),
(NULL,'AUTH_CODE','AC_CLI','고객',NULL,5,'Authority – Client',1);

-- =====================================================
-- 14. 문서 구분
-- =====================================================

INSERT INTO common_code VALUES
(NULL, 'DOC_TYPE', 'DOC_SO', 'SO', NULL, 1, '주문서', 1),
(NULL, 'DOC_TYPE', 'DOC_PR', 'PR', NULL, 2, '생산요청서', 1),
(NULL, 'DOC_TYPE', 'DOC_PP', 'PP', NULL, 3, '생산계획', 1),
(NULL, 'DOC_TYPE', 'DOC_WO', 'WO', NULL, 4, '작업지시서', 1),
(NULL, 'DOC_TYPE', 'DOC_GI', 'GI', NULL, 5, '출고지시서', 1),
(NULL, 'DOC_TYPE', 'DOC_DO', 'DO', NULL, 6, '납품서', 1),
(NULL, 'DOC_TYPE', 'DOC_SERO', 'SERO', NULL, 7, '전자결재', 1);

SET FOREIGN_KEY_CHECKS = 1;
