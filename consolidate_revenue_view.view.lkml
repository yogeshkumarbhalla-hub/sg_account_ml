
view: consolidate_revenue_view {
  derived_table: {
    sql: {% raw %} SELECT
        -- Account Attributes
        A.ACCOUNTID,
        A.CA_NUMBER,
        A.BA_NUMBER,
        A.SI_NUMBER,
        A.CURRENTPLAN,
        A.ID_TYPE,
        A.NUMBER_PORT_TYPE,
        A.CURRENTPLAN_NAME,
        A.ACCOUNT_STATUS,
        A.PORTING_DONOR,
        A.MSISDN,
        A.PORTOUT_TELCO,
        A.OWN_REFERRAL_CODE,
        A.TERMINATION_DATE,
        A.LAST_REACTIVATION_DATE,
      
        -- Billing Attributes
        B.BILL_NO,
        B.BILL_CREATE_MONTH,
        B.USAGEMONTH,
        B.IS_PAYG,
        B.REVENUE_TYPE,
        B.PRODUCT,
      
        -- Aggregated Metrics
        SUM(B.NONTAX_AMOUNT) AS NONTAX_AMOUNT,
        SUM(B.TAX_AMOUNT) AS TAX_AMOUNT,
        SUM(B.NONTAX_AMOUNT + B.TAX_AMOUNT) AS REVENUE,
        SUM(B.COUNT) AS COUNTS,
        SUM(B.QUANTITY) AS QUANTITY
      FROM LEGACY.ACCOUNT A
      INNER JOIN LEGACY.BILLS_V3 B
        ON A.SI_NUMBER = B.SI_NUMBER
      WHERE B.BILL_CREATE_MONTH = '202609'
      GROUP BY
        A.ACCOUNTID,
        A.CA_NUMBER,
        A.BA_NUMBER,
        A.SI_NUMBER,
        A.CURRENTPLAN,
        A.ID_TYPE,
        A.NUMBER_PORT_TYPE,
        A.CURRENTPLAN_NAME,
        A.ACCOUNT_STATUS,
        A.PORTING_DONOR,
        A.MSISDN,
        A.PORTOUT_TELCO,
        A.OWN_REFERRAL_CODE,
        A.TERMINATION_DATE,
        A.LAST_REACTIVATION_DATE,
        B.BILL_NO,
        B.BILL_CREATE_MONTH,
        B.USAGEMONTH,
        B.IS_PAYG,
        B.REVENUE_TYPE,
        B.PRODUCT {% endraw %} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: accountid {
    type: number
    sql: ${TABLE}."ACCOUNTID" ;;
  }

  dimension: ca_number {
    type: string
    sql: ${TABLE}."CA_NUMBER" ;;
  }

  dimension: ba_number {
    type: string
    sql: ${TABLE}."BA_NUMBER" ;;
  }

  dimension: si_number {
    type: string
    sql: ${TABLE}."SI_NUMBER" ;;
  }

  dimension: currentplan {
    type: string
    sql: ${TABLE}."CURRENTPLAN" ;;
  }

  dimension: id_type {
    type: string
    sql: ${TABLE}."ID_TYPE" ;;
  }

  dimension: number_port_type {
    type: string
    sql: ${TABLE}."NUMBER_PORT_TYPE" ;;
  }

  dimension: currentplan_name {
    type: string
    sql: ${TABLE}."CURRENTPLAN_NAME" ;;
  }

  dimension: account_status {
    type: string
    sql: ${TABLE}."ACCOUNT_STATUS" ;;
  }

  dimension: porting_donor {
    type: string
    sql: ${TABLE}."PORTING_DONOR" ;;
  }

  dimension: msisdn {
    type: number
    sql: ${TABLE}."MSISDN" ;;
  }

  dimension: portout_telco {
    type: string
    sql: ${TABLE}."PORTOUT_TELCO" ;;
  }

  dimension: own_referral_code {
    type: string
    sql: ${TABLE}."OWN_REFERRAL_CODE" ;;
  }

  dimension_group: termination_date {
    type: time
    sql: ${TABLE}."TERMINATION_DATE" ;;
  }

  dimension_group: last_reactivation_date {
    type: time
    sql: ${TABLE}."LAST_REACTIVATION_DATE" ;;
  }

  dimension: bill_no {
    type: string
    sql: ${TABLE}."BILL_NO" ;;
  }

  dimension: bill_create_month {
    type: number
    sql: ${TABLE}."BILL_CREATE_MONTH" ;;
  }

  dimension: usagemonth {
    type: number
    sql: ${TABLE}."USAGEMONTH" ;;
  }

  dimension: is_payg {
    type: number
    sql: ${TABLE}."IS_PAYG" ;;
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}."REVENUE_TYPE" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."PRODUCT" ;;
  }

  dimension: nontax_amount {
    type: number
    sql: ${TABLE}."NONTAX_AMOUNT" ;;
  }

  dimension: tax_amount {
    type: number
    sql: ${TABLE}."TAX_AMOUNT" ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}."REVENUE" ;;
  }

  dimension: counts {
    type: number
    sql: ${TABLE}."COUNTS" ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}."QUANTITY" ;;
  }

  set: detail {
    fields: [
        accountid,
	ca_number,
	ba_number,
	si_number,
	currentplan,
	id_type,
	number_port_type,
	currentplan_name,
	account_status,
	porting_donor,
	msisdn,
	portout_telco,
	own_referral_code,
	termination_date_time,
	last_reactivation_date_time,
	bill_no,
	bill_create_month,
	usagemonth,
	is_payg,
	revenue_type,
	product,
	nontax_amount,
	tax_amount,
	revenue,
	counts,
	quantity
    ]
  }
}
