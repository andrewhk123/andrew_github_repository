drop table e_so_ord_type;
drop table e_so_ord;
drop table e_so_ord_dtl;
drop table e_so_ord_prod;
drop table e_so_ord_mob_sim;
drop table e_so_ord_mob_srv;
drop table e_so_ord_lts;
drop table e_so_ord_ims;
drop table e_so_provisioning;
drop table e_pser_ind;
drop table e_pser;
drop table e_tpdat;
drop table e_dat_type;
drop table e_workgroup;
drop table e_workgroup_loc;
drop table e_so_process;
drop table e_basic_workgroup_rule;
drop table e_pser_rule;
drop table e_workgroup_user;



drop table e_so_ord_type;
drop table e_so_ord;
drop table e_so_ord_dtl;
drop table e_so_ord_prod;
drop table e_so_ord_mob_sim;
drop table e_so_ord_mob_srv;
drop table e_so_ord_lts;
drop table e_so_ord_ims;
drop table e_so_provisioning;
drop table e_pser_ind;
drop table e_pser;
drop table e_tpdat;
drop table e_dat_type;
drop table e_workgroup;
drop table e_workgroup_loc;
drop table e_so_process;
drop table e_basic_workgroup_rule;
drop table e_pser_rule;
drop table e_workgroup_user;
drop table e_workgroup_loc_func;



-- order domain
-- order type table
create table e_so_ord_type (
	e_so_ord_type_id int,
	e_so_ord_type_code varchar(30),  -- e.g LTS install, LTS disconnect, Broadband install, Broadband move, etc, TBD
	e_so_ord_type_desc varchar(100),
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_type_pk primary key (e_so_ord_type_id)
)
;

-- order table. Map to TMF service_order data model
create table e_so_ord (
	so_order_id int,
--	district_code varchar2(2),
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_pk primary key (so_order_id)
)
;

-- order table. Map to TMF service_item data model
drop table e_so_ord_dtl;
create table e_so_ord_dtl (
	so_order_id int,
    so_dtl_id int,
	e_so_ord_type_id int,   
	om_order_id int,  -- order id from om
	srd	date,
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_dtl_pk primary key (so_order_id, so_dtl_id),
--	constraint e_so_ord_dtl_pk primary key (so_dtl_id),
	CONSTRAINT e_so_ord_dtl_fk1 FOREIGN KEY (e_so_ord_type_id) references e_so_ord_type(e_so_ord_type_id)
)
;

-- product domain
-- product table. Map to TMF product data model
/*
create table e_product (	
	prod_id int,
	imei varchar(20), 
	prod_desc varchar(140),
	prod_sht_desc varchar(40),
	prod_chi_desc varchar(40),
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_product_pk primary key (prod_id)
)
;


-- table of product serial number
create table e_product_serialnum (
	serialnum	int,
	prod_id int,
	is_used		varchar(1),
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_product_serialnum_pk primary key (serialnum)	
)
;
--	CONSTRAINT e_so_ord_prod_fk1 FOREIGN KEY (so_order_id) references e_so_ord_dtl(so_order_id) ON DELETE CASCADE
--	CONSTRAINT e_so_ord_prod_fk2 FOREIGN KEY (so_dtl_id) references e_so_ord_dtl(so_dtl_id)	
--	constraint e_product_pk primary key (prod_id)

*/

-- purchase product detail
drop table e_so_ord_prod;
create table e_so_ord_prod (	
	so_order_id int,
	so_dtl_id int,
	item_id int,
	sub_item_id int,
	imei varchar(20),  
	prod_id int,
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_prod_pk primary key (so_order_id, so_dtl_id, item_id, sub_item_id),
	CONSTRAINT e_so_ord_prod_fk1 FOREIGN KEY (so_order_id,so_dtl_id) references e_so_ord_dtl(so_order_id,so_dtl_id)
)
;


create table e_so_ord_mob_sim (	
	so_order_id int,
	so_dtl_id int,
	iccid varchar(20),
	imsi varchar(20),
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_mob_sim_pk primary key (so_order_id, so_dtl_id, iccid),
    CONSTRAINT e_so_ord_mob_sim_fk1 FOREIGN KEY (so_order_id,so_dtl_id) references e_so_ord_dtl(so_order_id,so_dtl_id)
)
;

create table e_so_ord_mob_srv (	
	so_order_id int,
	so_dtl_id int,
	service_id int,
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_prod_pk primary key (so_order_id, so_dtl_id, iccid),
    CONSTRAINT e_so_ord_prod_fk1 FOREIGN KEY (so_order_id,so_dtl_id) references e_so_ord_dtl(so_order_id,so_dtl_id)
--	constraint e_product_pk primary key (prod_id)
)
;

create table e_so_ord_lts (	
	so_order_id int,
	so_dtl_id int,
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_lts_pk primary key (so_order_id, so_dtl_id),
	CONSTRAINT e_so_ord_lts_fk1 FOREIGN KEY (so_order_id, so_dtl_id) references e_so_ord_dtl(so_order_id, so_dtl_id)
--	constraint e_product_pk primary key (prod_id)
)
;

create table e_so_ord_ims (	
	so_order_id int,
	so_dtl_id int,
	-- other fields. TBD
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_so_ord_ims_pk primary key (so_order_id, so_dtl_id),
	CONSTRAINT e_so_ord_ims_fk1 FOREIGN KEY (so_order_id, so_dtl_id) references e_so_ord_dtl(so_order_id, so_dtl_id)
)
;




-- resource domain
-- Map to TMF Resource data model
/*
create table e_resource  (
	e_resource_id int,
	--other field 
	constraint e_resource_pk primary key (e_resource_id)	
	
)
;
*/
/*
create table e_data_dictionary (
	s_field_1 varchar2(100),
	s_field_1_desc varchar2(1000),
	n_field_1 it,
	n_field_1_desc varchar2(1000),
	d_field_1 varchar2(100),
	last_upd_date date,
	latt_upd_date date
)
;
*/

-- provisioning domain. (No TMF matched)
create table e_so_provisioning (
	ask_id int,
	service_id int,
	imsi varchar(20),
	e_so_ord_type_id int,
	send_status varchar(1),
	constraint e_so_provisioning_pk primary key (ask_id)		
)
;


-- workgroup related info	
-- pser table
--drop table e_pser_ind;
create table e_pser_ind (
	e_pser_ind_id int,
	e_pser_ind_code varchar(1),  -- P,S,E,F
	e_pser_ind_desc varchar(100),
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_pser_ind_pk primary key (e_pser_ind_id)
)
;

-- e.g. 7CS4, 7EF3
-- P,S,E,F
create table e_pser (
	e_pser_code varchar(30),  
	e_pser_ind_code varchar(1),  
	e_pser_desc varchar(100),
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_pser_pk primary key (e_pser_code)

)
;
-- 	CONSTRAINT e_pser_fk1 FOREIGN KEY (e_pser_ind_code) references e_pser_ind(e_pser_ind_code)

-- TPdat table
create table e_tpdat(
    e_tp_type_id int,
	dat_code varchar(4),
	tpdat_desc varchar(30),
	tp varchar(3),
	eff_start_date date,
	eff_end_date date,
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_tpdat_pk primary key (e_tp_type_id)
)
;



/*
-- status table
create table e_status_type (
	e_status varchar(1),  -- e.g. I, A
	e_status_desc varchar(100), -- e.g. I - Number investigate, A - address investigate
	last_upd_date date,
	last_upd_by   varchar(20),	
	constraint e_status_type_pk primary key (e_status)	
)
;
*/

-- work group table
create table e_workgroup (
	e_workgroup_code varchar(3),
	e_workgroup_func_unit varchar(1),
	notify_mode varchar(1),
	notify_level varchar(1),
	e_workgroup_desc varchar(25),
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_workgroup_pk primary key (e_workgroup_code)
)
;

-- work group order relation table
create table e_workgroup_loc (
	e_workgroup_loc_id int,
	e_workgroup_code varchar(3),
	e_workgroup_ctl varchar(1),
	e_workgroup_loc varchar(1),
	e_distribute_mode varchar(1),
	contact_srv_num varchar(12),
	constraint e_workgroup_loc_pk primary key (e_workgroup_loc_id)
)
;

create table e_workgroup_loc_func (
	e_workgroup_loc_id int,
	func_unit_code varchar(5),
	-- other fields TBD
	constraint e_workgroup_loc_func_pk primary key (e_workgroup_loc_id, func_unit_code)
)
;

-- process domain
drop table e_so_process;
create table e_so_process (
	e_so_process_id int,
	e_so_ord_type_id int,
	assigned_staff varchar(8),
	e_workgroup_loc_id int,
	e_tp_type_id int,
	created_date date,
	due_date date,
	completed_date date,
	e_so_status int,   
	e_workflow_id int, 
	notify_level int,
	distribute_status varchar(1),
	constraint e_so_process_pk primary key (e_so_process_id)
)
;
ALTER TABLE e_so_process ADD CONSTRAINT e_so_process_fk1  FOREIGN KEY (e_so_ord_type_id ) REFERENCES e_so_ord_type(e_so_ord_type_id);
ALTER TABLE e_so_process ADD CONSTRAINT e_so_process_fk2  FOREIGN KEY (e_tp_type_id ) REFERENCES e_tpdat (e_tp_type_id);
ALTER TABLE e_so_process ADD CONSTRAINT e_so_process_fk3  FOREIGN KEY (e_workgroup_loc_id ) REFERENCES e_workgroup_loc(e_workgroup_loc_id);


-- work group basic rule (for Maintain sotype, Relate workgroup to sotype)
-- Function: get basic workgroup list
-- output: workgroup
-- input: order type + tp + dat + order status
create table e_basic_workgroup_rule (
	e_basic_workgroup_rule_id int,
	e_basic_workgroup_rule_desc varchar(100),
	e_order_type_id int,
	e_tp_type_id int,
	e_status varchar(1),
	e_workgroup_code varchar(3), 
	notify_level varchar(1),
	distribute_mode varchar(1),
	unit_id varchar(10), -- temporary save in this table for demo, e.g. ADM, KWGA
	lead_time int, 
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_basic_workgroup_rule_pk primary key (e_basic_workgroup_rule_id)
)
;

ALTER TABLE e_basic_workgroup_rule add CONSTRAINT e_basic_workgroup_rule_fk1 FOREIGN KEY (e_order_type_id) REFERENCES e_so_ord_type(e_so_ord_type_id);
ALTER TABLE e_basic_workgroup_rule add CONSTRAINT e_basic_workgroup_rule_fk2 FOREIGN KEY (e_tp_type_id ) REFERENCES e_tpdat (e_tp_type_id);
ALTER TABLE e_basic_workgroup_rule add CONSTRAINT e_basic_workgroup_rule_fk4 FOREIGN KEY (e_workgroup_code) references e_workgroup(e_workgroup_code);

-- pser rule table (for Maintain PSEF dist type, Relate PSEF dist types)
-- Function: update workgroup list. dynamic rule
-- output: workgroup and pser_action (I, O)
-- input: order type + tp + dat + pser code
drop table e_pser_rule ;
create table e_pser_rule (
	e_pser_rule_id int,
	e_order_type_id int,
	e_tp_type_id int,
	e_pser_code varchar(30),
	pser_action varchar(1),
	addr_chng varchar(1),
	notify_level varchar(1),
	workgroup_action varchar(1),
    e_workgroup_code varchar(3),
	unit_id varchar(10), 
	functional_unit varchar(1), -- E, B, Z, G
	last_upd_date date,
	last_upd_by   varchar(20),
	constraint e_pser_rule_pk primary key (e_pser_rule_id)
)
;
ALTER TABLE e_pser_rule add CONSTRAINT e_pser_rule_fk1 FOREIGN KEY (e_order_type_id) REFERENCES e_so_ord_type(e_so_ord_type_id);
ALTER TABLE e_pser_rule add CONSTRAINT e_pser_rule_fk2 FOREIGN KEY (e_tp_type_id ) REFERENCES e_tpdat (e_tp_type_id);
ALTER TABLE e_pser_rule add CONSTRAINT e_pser_rule_fk3 FOREIGN KEY (e_workgroup_code) references e_workgroup(e_workgroup_code);
ALTER TABLE e_pser_rule add CONSTRAINT e_pser_rule_fk4 FOREIGN KEY (e_pser_code ) REFERENCES e_pser (e_pser_code);

-- user info
create table e_workgroup_user (
	e_workgroup_loc_id int,
	staff_name varchar(8),
	last_upd_date date,
	last_upd_by   varchar(20),	
	constraint e_pser_rule_pk primary key (e_workgroup_loc_id, staff_name)
)
;

-- PCCW workflow table and camunda workflow relation table list

