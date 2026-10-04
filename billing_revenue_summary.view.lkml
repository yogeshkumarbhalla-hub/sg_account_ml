view: billing_revenue_summary {
  derived_table: {
    sql:
      SELECT
        A.ACCOUNTID,
        A.CA_NUMBER,
        A.BA_NUMBER,
        A.SI_NUMBER,
        A.CURRENTPLAN,
        A.CURRENTPLAN_NAME,
        A.ACCOUNT_STATUS,
        A.ID_TYPE,
        A.NUMBER_PORT_TYPE,
        A.PORTING_DONOR,
        A.PORTOUT_TELCO,

        -- Derived Eligibility Flag
        CASE
          WHEN A.ACCOUNT_STATUS IN ('ACTIVE', 'SUSPENDED', 'ACTIVE_PENDING') THEN 'Y'
          ELSE 'N'
        END AS IS_ELIGIBLE_FOR_BILLING,

      -- Derived State Area Code
      CASE
      WHEN A.MSISDN LIKE '1213%' OR A.MSISDN LIKE '1310%' THEN 'CA'
      WHEN A.MSISDN LIKE '1212%' OR A.MSISDN LIKE '1718%' THEN 'NY'
      WHEN A.MSISDN LIKE '1214%' OR A.MSISDN LIKE '1713%' THEN 'TX'
      WHEN A.MSISDN LIKE '1312%' OR A.MSISDN LIKE '1773%' THEN 'IL'
      WHEN A.MSISDN LIKE '1305%' OR A.MSISDN LIKE '1407%' THEN 'FL'
      ELSE 'NATIONAL'
      END AS STATE,

      -- Billing Attributes
      B.BILL_NO,
      B.BILL_CREATE_MONTH,
      B.USAGEMONTH,

      -- Aggregated Measures per Invoice Line Item
      SUM(B.NONTAX_AMOUNT) AS TOTAL_NONTAX_AMOUNT,
      SUM(B.TAX_AMOUNT) AS TOTAL_TAX_AMOUNT,
      SUM(B.NONTAX_AMOUNT + B.TAX_AMOUNT) AS TOTAL_INVOICE_AMOUNT,

      -- Product Category Breakdown
      SUM(CASE WHEN B.REVENUE_TYPE = 'RECURRING' THEN B.NONTAX_AMOUNT ELSE 0 END) AS PLAN_REVENUE,
      SUM(CASE WHEN B.REVENUE_TYPE = 'USAGE' THEN B.NONTAX_AMOUNT ELSE 0 END) AS USAGE_REVENUE,
      SUM(CASE WHEN B.REVENUE_TYPE = 'ADDON' THEN B.NONTAX_AMOUNT ELSE 0 END) AS ADDON_REVENUE,
      SUM(CASE WHEN B.REVENUE_TYPE = 'DISCOUNT' THEN B.NONTAX_AMOUNT ELSE 0 END) AS DISCOUNT_REVENUE,

      SUM(B.COUNT) AS TOTAL_LINE_ITEMS,
      SUM(B.QUANTITY) AS TOTAL_QUANTITY

      FROM LEGACY.ACCOUNT A
      LEFT JOIN LEGACY.BILLS_V3 B
      ON A.SI_NUMBER = B.SI_NUMBER
      WHERE (B.BILL_CREATE_MONTH = '202609' OR B.BILL_CREATE_MONTH IS NULL)
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 ;;
  }

  # --- DIMENSIONS ---
  dimension: account_id { type: string sql: ${TABLE}.ACCOUNTID ;; }
  dimension: si_number { type: string sql: ${TABLE}.SI_NUMBER ;; }
  dimension: current_plan_name { type: string sql: ${TABLE}.CURRENTPLAN_NAME ;; }
  dimension: account_status { type: string sql: ${TABLE}.ACCOUNT_STATUS ;; }
  dimension: number_port_type { type: string sql: ${TABLE}.NUMBER_PORT_TYPE ;; }
  dimension: porting_donor { type: string sql: ${TABLE}.PORTING_DONOR ;; }
  dimension: bill_no { type: string sql: ${TABLE}.BILL_NO ;; }
  dimension: bill_create_month { type: string sql: ${TABLE}.BILL_CREATE_MONTH ;; }
  dimension: is_eligible { type: yesno sql: ${TABLE}.IS_ELIGIBLE_FOR_BILLING = 'Y' ;; }

  # --- MEASURES ---
  measure: total_eligible_accounts {
    type: count_distinct
    sql: ${account_id} ;;
    filters: [is_eligible: "yes"]
  }

  measure: invoices_generated {
    type: count_distinct
    sql: ${bill_no} ;;
  }

  measure: generation_pass_rate {
    type: number
    value_format_name: percent_3
    sql: 100.0 * \({invoices_generated} / NULLIF(\){total_eligible_accounts}, 0) ;;
  }

  measure: ungenerated_accounts_count {
    type: count_distinct
    sql: ${account_id} ;;
    filters: [bill_no: "NULL", is_eligible: "yes"]
  }

  measure: total_invoiced_revenue {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.TOTAL_INVOICE_AMOUNT ;;
  }

  measure: average_invoice_value {
    type: number
    value_format_name: usd
    sql: \({total_invoiced_revenue} / NULLIF(\){invoices_generated}, 0) ;;
  }

  measure: plan_revenue { type: sum value_format_name: usd sql: ${TABLE}.PLAN_REVENUE ;; }
  measure: usage_revenue { type: sum value_format_name: usd sql: ${TABLE}.USAGE_REVENUE ;; }
  measure: addon_revenue { type: sum value_format_name: usd sql: ${TABLE}.ADDON_REVENUE ;; }
  measure: tax_revenue { type: sum value_format_name: usd sql: ${TABLE}.TOTAL_TAX_AMOUNT ;; }
  measure: discount_revenue { type: sum value_format_name: usd sql: ${TABLE}.DISCOUNT_REVENUE ;; }
}
