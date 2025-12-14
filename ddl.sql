DROP DATABASE IF EXISTS sero;
CREATE DATABASE sero CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE sero;

SET FOREIGN_KEY_CHECKS = 0;

/* -----------------------------------------------------
 * 1. DROP EXISTING TABLES
 * ----------------------------------------------------- */
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS notice;
DROP TABLE IF EXISTS work_order_result;
DROP TABLE IF EXISTS production_request;
DROP TABLE IF EXISTS delivery_order;
DROP TABLE IF EXISTS production_request_item_quantity;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS approval_template_line;
DROP TABLE IF EXISTS sales_order_status_history;
DROP TABLE IF EXISTS client_item;
DROP TABLE IF EXISTS approval_attachment;
DROP TABLE IF EXISTS permission;
DROP TABLE IF EXISTS approval;
DROP TABLE IF EXISTS client_item_price_history;
DROP TABLE IF EXISTS goods_issue;
DROP TABLE IF EXISTS client_employee;
DROP TABLE IF EXISTS production_plan;
DROP TABLE IF EXISTS approval_template;
DROP TABLE IF EXISTS warehouse_stock;
DROP TABLE IF EXISTS work_order;
DROP TABLE IF EXISTS client_address;
DROP TABLE IF EXISTS line_material;
DROP TABLE IF EXISTS approval_line;
DROP TABLE IF EXISTS work_order_history;
DROP TABLE IF EXISTS employee_permission;
DROP TABLE IF EXISTS bom;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS sales_order_item;
DROP TABLE IF EXISTS sales_order;
DROP TABLE IF EXISTS production_process;
DROP TABLE IF EXISTS production_line;
DROP TABLE IF EXISTS sales_order_item_history;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS goods_issue_item_quantity;
DROP TABLE IF EXISTS warehouse_stock_history;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS delivery_order_item_quantity;
DROP TABLE IF EXISTS material;
DROP TABLE IF EXISTS menu_permission;

/* -----------------------------------------------------
 * 2. CREATE TABLES
 * ----------------------------------------------------- */

CREATE TABLE department (
    id INTEGER NOT NULL AUTO_INCREMENT,
    dept_code VARCHAR(20) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE employee (
    id INTEGER NOT NULL AUTO_INCREMENT,
    dept_id INTEGER NULL,
    emp_code VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ES_ACT',
    signature_url TEXT NULL,
    position_code VARCHAR(20) NOT NULL,
    rank_code VARCHAR(20) NOT NULL,
    start_date VARCHAR(30) NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_department_TO_employee FOREIGN KEY (dept_id) REFERENCES department (id)
);

CREATE TABLE warehouse (
    id INTEGER NOT NULL AUTO_INCREMENT,
    manager_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    latitude DECIMAL(10,7) NULL,
    longitude DECIMAL(10,7) NULL,
    type VARCHAR(50) NOT NULL DEFAULT 'WHS_WH',
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_employee_TO_warehouse FOREIGN KEY (manager_id) REFERENCES employee (id)
);

CREATE TABLE notice (
    id INTEGER NOT NULL AUTO_INCREMENT,
    creator_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    attachment_url TEXT NULL,
    category VARCHAR(50) NOT NULL,
    pinned_start_at VARCHAR(30) NULL,
    pinned_end_at VARCHAR(30) NULL,
    is_emergency TINYINT NOT NULL DEFAULT 0,
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_employee_TO_notice FOREIGN KEY (creator_id) REFERENCES employee (id)
);

CREATE TABLE client (
    id INTEGER NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    ceo_name VARCHAR(50) NOT NULL,
    company_contact VARCHAR(20) NOT NULL,
    business_no VARCHAR(50) NOT NULL UNIQUE,
    business_type VARCHAR(50) NOT NULL,
    business_item VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    manager_name VARCHAR(50) NOT NULL,
    manager_contact VARCHAR(20) NOT NULL,
    manager_email VARCHAR(100) NOT NULL UNIQUE,
    credit_limit BIGINT NOT NULL,
    receivables BIGINT NOT NULL DEFAULT 0,
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE client_employee (
    id INTEGER NOT NULL AUTO_INCREMENT,
    client_id INTEGER NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    position VARCHAR(20) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_client_TO_client_employee FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE sales_order (
    id INTEGER NOT NULL AUTO_INCREMENT,
    client_id INTEGER NOT NULL,
    client_manager_id INTEGER NOT NULL,
    manager_id INTEGER NULL,
    so_code VARCHAR(50) NOT NULL UNIQUE,
    client_name VARCHAR(100) NOT NULL,
    ordered_at VARCHAR(30) NOT NULL,
    shipped_at VARCHAR(30) NOT NULL,
    po_code VARCHAR(50) NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'ORD_RED',
    total_quantity INTEGER NOT NULL DEFAULT 0,
    total_item_count INTEGER NOT NULL DEFAULT 0,
    total_price BIGINT NOT NULL DEFAULT 0,
    so_url TEXT NULL,
    rejection_reason VARCHAR(255) NULL,
    main_item_name VARCHAR(100) NOT NULL,
    note VARCHAR(255) NULL,
    approval_code VARCHAR(50) NULL UNIQUE,
    shipping_name VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    latitude DECIMAL(10,7) NULL,
    longitude DECIMAL(10,7) NULL,
    recipient_name VARCHAR(50) NOT NULL,
    recipient_contact VARCHAR(20) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_client_TO_sales_order FOREIGN KEY (client_id) REFERENCES client (id),
    CONSTRAINT FK_client_employee_TO_sales_order FOREIGN KEY (client_manager_id) REFERENCES client_employee (id),
    CONSTRAINT FK_employee_TO_sales_order FOREIGN KEY (manager_id) REFERENCES employee (id)
);

CREATE TABLE sales_order_item (
    id INTEGER NOT NULL AUTO_INCREMENT,
    so_id INTEGER NOT NULL,
    item_code VARCHAR(50) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    spec VARCHAR(100) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0, 
    unit VARCHAR(20) NOT NULL,
    unit_price INTEGER NOT NULL,
    total_price BIGINT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT FK_sales_order_TO_sales_order_item FOREIGN KEY (so_id) REFERENCES sales_order (id)
);

CREATE TABLE production_request (
    id INTEGER NOT NULL AUTO_INCREMENT,
    so_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    pr_code VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(50) NOT NULL DEFAULT 'PR_RVW',
    requested_at VARCHAR(30) NOT NULL,
    due_at VARCHAR(30) NOT NULL,
    reason VARCHAR(255) NULL,
    pr_url TEXT NULL,
    total_quantity INTEGER NOT NULL DEFAULT 0,
    approval_code VARCHAR(50) NULL UNIQUE,
    PRIMARY KEY (id),
    CONSTRAINT FK_sales_order_TO_production_request FOREIGN KEY (so_id) REFERENCES sales_order (id),
    CONSTRAINT FK_employee_TO_production_request FOREIGN KEY (manager_id) REFERENCES employee (id)
);

CREATE TABLE production_request_item_quantity (
    id INTEGER NOT NULL AUTO_INCREMENT,
    pr_id INTEGER NOT NULL,
    so_item_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT FK_production_request_TO_production_request_item_quantity FOREIGN KEY (pr_id) REFERENCES production_request (id),
    CONSTRAINT FK_sales_order_item_TO_production_request_item_quantity FOREIGN KEY (so_item_id) REFERENCES sales_order_item (id),
    CONSTRAINT FK_employee_TO_production_request_item_quantity FOREIGN KEY (manager_id) REFERENCES employee (id)
);

CREATE TABLE production_line (
    id INTEGER NOT NULL AUTO_INCREMENT,
    factory_id INTEGER NOT NULL,
    line_name VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'PL_ACTIVE',
    PRIMARY KEY (id),
    CONSTRAINT FK_warehouse_TO_production_line FOREIGN KEY (factory_id) REFERENCES warehouse (id)
);

CREATE TABLE production_plan (
    id INTEGER NOT NULL AUTO_INCREMENT,
    pr_item_quantity_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    production_line_id INTEGER NOT NULL,
    pp_code VARCHAR(50) NOT NULL UNIQUE,
    start_date VARCHAR(30) NOT NULL,
    end_date VARCHAR(30) NOT NULL,
    production_quantity INTEGER NOT NULL DEFAULT 0,
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_production_request_item_quantity_TO_production_plan FOREIGN KEY (pr_item_quantity_id) REFERENCES production_request_item_quantity (id),
    CONSTRAINT FK_employee_TO_production_plan FOREIGN KEY (manager_id) REFERENCES employee (id),
    CONSTRAINT FK_production_line_TO_production_plan FOREIGN KEY (production_line_id) REFERENCES production_line (id)
);

CREATE TABLE work_order (
    id INTEGER NOT NULL AUTO_INCREMENT,
    pr_id INTEGER NOT NULL,
    pp_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    creator_id INTEGER NOT NULL,
    wo_code VARCHAR(50) NOT NULL UNIQUE,
    work_date VARCHAR(30) NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    wo_url TEXT NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT FK_production_request_TO_work_order FOREIGN KEY (pr_id) REFERENCES production_request (id),
    CONSTRAINT FK_production_plan_TO_work_order FOREIGN KEY (pp_id) REFERENCES production_plan (id),
    CONSTRAINT FK_employee_TO_work_order FOREIGN KEY (manager_id) REFERENCES employee (id),
    CONSTRAINT FK_employee_TO_work_order_2 FOREIGN KEY (creator_id) REFERENCES employee (id)
);

CREATE TABLE work_order_result (
    id INTEGER NOT NULL AUTO_INCREMENT,
    wo_id INTEGER NOT NULL,
    good_quantity INTEGER NOT NULL DEFAULT 0,
    defective_quantity INTEGER NOT NULL DEFAULT 0,
    start_time VARCHAR(30) NULL,
    end_time VARCHAR(30) NULL,
    work_time INTEGER NULL DEFAULT 0,
    note VARCHAR(255) NULL,
    headcount INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    CONSTRAINT FK_work_order_TO_work_order_result FOREIGN KEY (wo_id) REFERENCES work_order (id)
);

CREATE TABLE delivery_order (
    id INTEGER NOT NULL AUTO_INCREMENT,
    so_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    do_code VARCHAR(50) NOT NULL UNIQUE,
    do_url TEXT NOT NULL,
    note VARCHAR(255) NULL,
    created_at VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_sales_order_TO_delivery_order FOREIGN KEY (so_id) REFERENCES sales_order (id),
    CONSTRAINT FK_employee_TO_delivery_order FOREIGN KEY (manager_id) REFERENCES employee (id)
);

CREATE TABLE approval_template (
    id INTEGER NOT NULL AUTO_INCREMENT,
    creator_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NULL,
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_employee_TO_approval_template FOREIGN KEY (creator_id) REFERENCES employee (id)
);

CREATE TABLE approval_template_line (
    id INTEGER NOT NULL AUTO_INCREMENT,
    template_id INTEGER NOT NULL,
    approver_id INTEGER NOT NULL,
    sequence INTEGER NOT NULL,
    line_type VARCHAR(20) NOT NULL,
    note VARCHAR(255) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_approval_template_TO_approval_template_line FOREIGN KEY (template_id) REFERENCES approval_template (id),
    CONSTRAINT FK_employee_TO_approval_template_line FOREIGN KEY (approver_id) REFERENCES employee (id)
);

CREATE TABLE sales_order_status_history (
    id INTEGER NOT NULL AUTO_INCREMENT,
    status VARCHAR(50) NOT NULL,
    so_id INTEGER NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    creator_id INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE material (
    id INTEGER NOT NULL AUTO_INCREMENT,
    manager_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    material_code VARCHAR(50) NOT NULL UNIQUE,
    spec VARCHAR(100) NOT NULL,
    operation_unit VARCHAR(20) NULL,
    base_unit VARCHAR(20) NOT NULL,
    moq INTEGER NULL,
    cycle_time INTEGER NULL,
    unit_price BIGINT NULL,
    image_url TEXT NULL,
    conversion_rate INTEGER NULL,
    safety_stock INTEGER NOT NULL DEFAULT 1,
    raw_material_count INTEGER NULL,
    type VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'MAT_NORMAL',
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_employee_TO_material FOREIGN KEY (manager_id) REFERENCES employee (id)
);

CREATE TABLE client_item (
    id INTEGER NOT NULL AUTO_INCREMENT,
    client_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    contract_price INTEGER NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'TRADE_NORMAL',
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_client_TO_client_item FOREIGN KEY (client_id) REFERENCES client (id),
    CONSTRAINT FK_material_TO_client_item FOREIGN KEY (item_id) REFERENCES material (id)
);

CREATE TABLE approval (
    id INTEGER NOT NULL AUTO_INCREMENT,
    drafter_id INTEGER NOT NULL,
    approval_code VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    content VARCHAR(500) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'AS_ING',
    completed_at VARCHAR(30) NULL,
    total_line INTEGER NOT NULL DEFAULT 0,
    ref_code VARCHAR(50) NOT NULL,
    drafted_at VARCHAR(30) NOT NULL,
    document_prefix_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_employee_TO_approval FOREIGN KEY (drafter_id) REFERENCES employee (id),
    CONSTRAINT FK_document_prefix_TO_approval FOREIGN KEY (document_prefix_id) REFERENCES document_prefix(id)
);

CREATE TABLE approval_attachment (
    id INTEGER NOT NULL AUTO_INCREMENT,
    approval_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_approval_TO_approval_attachment FOREIGN KEY (approval_id) REFERENCES approval (id)
);

CREATE TABLE document_prefix (
    id INTEGER NOT NULL AUTO_INCREMENT,
    prefix VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE permission (
    id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    code VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE client_item_price_history (
    id INTEGER NOT NULL AUTO_INCREMENT,
    unit_price INTEGER NOT NULL,
    contract_price INTEGER NOT NULL,
    reason VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    creator_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    client_item_id INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE goods_issue (
    id INTEGER NOT NULL AUTO_INCREMENT,
    so_id INTEGER NOT NULL,
    manager_id INTEGER NOT NULL,
    warehouse_id INTEGER NOT NULL,
    gi_code VARCHAR(50) NOT NULL UNIQUE,
    approval_code VARCHAR(50) NULL,
    gi_url TEXT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'GI_RVW',
    note VARCHAR(255) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_sales_order_TO_goods_issue FOREIGN KEY (so_id) REFERENCES sales_order (id),
    CONSTRAINT FK_employee_TO_goods_issue FOREIGN KEY (manager_id) REFERENCES employee (id),
    CONSTRAINT FK_warehouse_TO_goods_issue FOREIGN KEY (warehouse_id) REFERENCES warehouse (id)
);

CREATE TABLE warehouse_stock (
    id INTEGER NOT NULL AUTO_INCREMENT,
    warehouse_id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    safety_stock INTEGER NOT NULL DEFAULT 1,
    current_stock INTEGER NOT NULL,
    available_stock INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_warehouse_TO_warehouse_stock FOREIGN KEY (warehouse_id) REFERENCES warehouse (id),
    CONSTRAINT FK_material_TO_warehouse_stock FOREIGN KEY (material_id) REFERENCES material (id)
);

CREATE TABLE client_address (
    id INTEGER NOT NULL AUTO_INCREMENT,
    client_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    latitude DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,
    recipient_name VARCHAR(50) NOT NULL,
    recipient_contact VARCHAR(20) NOT NULL,
    is_default TINYINT NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_client_TO_client_address FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE line_material (
    id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    line_id INTEGER NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    cycle_time INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT FK_material_TO_line_material FOREIGN KEY (material_id) REFERENCES material (id),
    CONSTRAINT FK_production_line_TO_line_material FOREIGN KEY (line_id) REFERENCES production_line (id)
);

CREATE TABLE approval_line (
    id INTEGER NOT NULL AUTO_INCREMENT,
    approval_id INTEGER NOT NULL,
    approver_id INTEGER NOT NULL,
    line_type VARCHAR(20) NOT NULL,
    sequence INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ALS_PEND',
    viewed_at VARCHAR(30) NULL,
    processed_at VARCHAR(30) NULL,
    note VARCHAR(255) NULL,
    signature_url TEXT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_approval_TO_approval_line FOREIGN KEY (approval_id) REFERENCES approval (id),
    CONSTRAINT FK_employee_TO_approval_line FOREIGN KEY (approver_id) REFERENCES employee (id)
);

CREATE TABLE work_order_history (
    id INTEGER NOT NULL AUTO_INCREMENT,
    wo_code VARCHAR(50) NOT NULL,
    action ENUM('START', 'PAUSE', 'RESUME', 'END') NOT NULL,
    acted_at VARCHAR(30) NOT NULL,
    note VARCHAR(255) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE employee_permission (
    employee_id INTEGER NOT NULL,
    permission_id INTEGER NOT NULL,
    PRIMARY KEY (employee_id, permission_id),
    CONSTRAINT FK_employee_TO_employee_permission FOREIGN KEY (employee_id) REFERENCES employee (id),
    CONSTRAINT FK_permission_TO_employee_permission FOREIGN KEY (permission_id) REFERENCES permission (id)
);

CREATE TABLE bom (
    id INTEGER NOT NULL AUTO_INCREMENT,
    material_id INTEGER NOT NULL,
    raw_material_id INTEGER NOT NULL,
    requirement INTEGER NOT NULL DEFAULT 0,
    note VARCHAR(255) NULL,
    created_at VARCHAR(30) NOT NULL,
    updated_at VARCHAR(30) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_material_TO_bom FOREIGN KEY (material_id) REFERENCES material (id),
    CONSTRAINT FK_raw_material_TO_bom FOREIGN KEY (raw_material_id) REFERENCES material (id)
);

CREATE TABLE menu (
    id INTEGER NOT NULL AUTO_INCREMENT,
    parent_id INTEGER NULL,
    code VARCHAR(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    url VARCHAR(50) NOT NULL,
    sort_order INTEGER NOT NULL,
    is_activated TINYINT NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    CONSTRAINT FK_menu_TO_menu FOREIGN KEY (parent_id) REFERENCES menu (id)
);

CREATE TABLE production_process (
    id INTEGER NOT NULL AUTO_INCREMENT,
    line_material_id INTEGER NOT NULL,
    process_name VARCHAR(100) NOT NULL,
    process_order INTEGER NOT NULL,
    headcount INTEGER NOT NULL DEFAULT 1,
    standard_time INTEGER NOT NULL DEFAULT 0,
    note VARCHAR(255) NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_line_material_TO_production_process FOREIGN KEY (line_material_id) REFERENCES line_material (id)
);

CREATE TABLE sales_order_item_history (
    id INTEGER NOT NULL AUTO_INCREMENT,
    pr_quantity INTEGER NOT NULL DEFAULT 0,
    pi_quantity INTEGER NOT NULL DEFAULT 0,
    gi_quantity INTEGER NOT NULL DEFAULT 0,
    shipped_quantity INTEGER NOT NULL DEFAULT 0,
    do_quantity INTEGER NOT NULL DEFAULT 0,
    completed_quantity INTEGER NOT NULL DEFAULT 0,
    so_item_id INTEGER NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    creator_id INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE delivery (
    id INTEGER NOT NULL AUTO_INCREMENT,
    gi_id INTEGER NOT NULL,
    tracking_number VARCHAR(50) NOT NULL UNIQUE,
    driver_name VARCHAR(50) NOT NULL,
    driver_contact VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'SHIP_ISSUED',
    departed_at VARCHAR(30) NULL,
    arrived_at VARCHAR(30) NULL,
    so_code VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_goods_issue_TO_delivery FOREIGN KEY (gi_id) REFERENCES goods_issue (id)
);

CREATE TABLE goods_issue_item_quantity (
    id INTEGER NOT NULL AUTO_INCREMENT,
    gi_id INTEGER NOT NULL,
    so_item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT FK_goods_issue_TO_goods_issue_item_quantity FOREIGN KEY (gi_id) REFERENCES goods_issue (id),
    CONSTRAINT FK_sales_order_item_TO_goods_issue_item_quantity FOREIGN KEY (so_item_id) REFERENCES sales_order_item (id)
);

CREATE TABLE warehouse_stock_history (
    id INTEGER NOT NULL AUTO_INCREMENT,
    warehouse_stock_id INTEGER NOT NULL,
    type VARCHAR(20) NOT NULL,
    reason VARCHAR(255) NULL,
    changed_quantity INTEGER NOT NULL DEFAULT 0,
    current_stock INTEGER NOT NULL,
    created_at VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE delivery_order_item_quantity (
    id INTEGER NOT NULL AUTO_INCREMENT,
    do_id INTEGER NOT NULL,
    so_item_id INTEGER NOT NULL,
    do_quantity INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT FK_delivery_order_TO_delivery_order_item_quantity FOREIGN KEY (do_id) REFERENCES delivery_order (id),
    CONSTRAINT FK_sales_order_item_TO_delivery_order_item_quantity FOREIGN KEY (so_item_id) REFERENCES sales_order_item (id)
);

CREATE TABLE menu_permission (
    id INTEGER NOT NULL AUTO_INCREMENT,
    permission_id INTEGER NOT NULL,
    menu_id INTEGER NOT NULL,
    read_permission TINYINT NOT NULL,
    write_permission TINYINT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_permission_TO_menu_permission FOREIGN KEY (permission_id) REFERENCES permission (id),
    CONSTRAINT FK_menu_TO_menu_permission FOREIGN KEY (menu_id) REFERENCES menu (id)
);

SET FOREIGN_KEY_CHECKS = 1;