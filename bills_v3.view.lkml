view: bills_v3 {
  derived_table: {
    sql: SELECT
            ACCOUNTID,
            SI_NUMBER,
            BILL_NO,
            BA_NUMBER,
            BILL_CREATE_MONTH,
            USAGEMONTH,
            IS_PAYG,
            REVENUE_TYPE,
            PRODUCT,
            SUM(NONTAX_AMOUNT) AS NONTAX_AMOUNT,
            SUM(TAX_AMOUNT) AS TAX_AMOUNT,
            SUM(NONTAX_AMOUNT) + SUM(TAX_AMOUNT) AS REVENUE,
            SUM(COUNT) AS COUNTS,
            SUM(QUANTITY) AS QUANTITY
          FROM LEGACY.BILLS_V3
          WHERE BILL_CREATE_MONTH = '202609'
          GROUP BY
            ACCOUNTID,
            SI_NUMBER,
            BILL_NO,
            BA_NUMBER,
            BILL_CREATE_MONTH,
            USAGEMONTH,
            IS_PAYG,
            REVENUE_TYPE,
            PRODUCT ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # --- Key Dimensions ---
  dimension: accountid {
    type: string
    sql: ${TABLE}.ACCOUNTID ;;
  }

  dimension: si_number {
    type: string
    sql: ${TABLE}.SI_NUMBER ;;
  }

  dimension: bill_no {
    type: string
    sql: ${TABLE}.BILL_NO ;;
  }

  dimension: ba_number {
    type: string
    sql: ${TABLE}.BA_NUMBER ;;
  }

  dimension: bill_create_month {
    type: string
    sql: ${TABLE}.BILL_CREATE_MONTH ;;
  }

  dimension: usagemonth {
    type: string
    sql: ${TABLE}.USAGEMONTH ;;
  }

  dimension: is_payg {
    type: string
    sql: ${TABLE}.IS_PAYG ;;
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}.REVENUE_TYPE ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.PRODUCT ;;
  }

  # --- Measures ---
  measure: total_nontax_amount {
    type: sum
    label: "Non-Tax Amount"
    sql: ${TABLE}.NONTAX_AMOUNT ;;
    value_format_name: usd
  }

  measure: total_tax_amount {
    type: sum
    label: "Tax Amount"
    sql: ${TABLE}.TAX_AMOUNT ;;
    value_format_name: usd
  }

  measure: total_revenue {
    type: sum
    label: "Total Revenue"
    sql: ${TABLE}.REVENUE ;;
    value_format_name: usd
  }

  measure: total_counts {
    type: sum
    label: "Total Bill Counts"
    sql: ${TABLE}.COUNTS ;;
  }

  measure: total_quantity {
    type: sum
    label: "Total Quantity"
    sql: ${TABLE}.QUANTITY ;;
  }

  # --- Drill Set ---
  set: detail {
    fields: [
      accountid,
      si_number,
      bill_no,
      ba_number,
      bill_create_month,
      usagemonth,
      is_payg,
      revenue_type,
      product
    ]
  }
}


view: +bills_v3 {
  dimension: revenue_category {
    label: "Revenue Category"  type: string
    description: "Groups REVENUE_TYPE. Adjust the lists below to your catalog."
    sql: CASE
      WHEN UPPER(TRIM(${TABLE}.REVENUE_TYPE)) IN ('BASE PLAN SUBSCRIPTION','PLUS OPTIONS') THEN 'Recurring Plan Charges'
      WHEN UPPER(TRIM(${TABLE}.REVENUE_TYPE)) = 'USAGE' THEN 'Usage / PAYG'
      WHEN UPPER(TRIM(${TABLE}.REVENUE_TYPE)) IN ('BOOST OPTIONS','AUTO-BOOSTS') THEN 'Add-on Charges'
      WHEN UPPER(TRIM(${TABLE}.REVENUE_TYPE)) = 'ONE-TIME CHARGES' THEN 'One-time Charges'
      ELSE 'Other' END ;;
  }
  measure: total_invoice_generated { label: "Total Invoices"  description: "Unique invoices: COUNT(DISTINCT BILL_NO)."  type: count_distinct  sql: ${TABLE}.BILL_NO ;; }
  measure: generated_eligible {
    label: "Generated (Eligible)"  type: count_distinct  sql: ${TABLE}.BILL_NO ;;  filters: [account.is_eligible: "Yes"]
  }
  measure: generation_rate {
    label: "Generation Rate"
    type: number  sql: 1.0 * ${generated_eligible} / NULLIF(${account.eligible_accounts},0) ;;  value_format: "0.000%"
  }
  measure: generation_result {
    label: "Result (AC 2.4-01)"
    type: string  sql: CASE WHEN ${generation_rate} >= 0.9995 THEN 'PASS' ELSE 'FAIL' END ;;
  }
  measure: revenue_at_risk {
    label: "Revenue at Risk"  type: number  value_format: "$#,##0"
    description: "Ungenerated accounts x average invoice value."
    sql: ${account.ungenerated_accounts} * ${avg_invoice_value} ;;
  }
  measure: nontax_amount { label: "Non-Tax Amount"  type: sum  sql: ${TABLE}.NONTAX_AMOUNT ;;  value_format: "$#,##0.00" }
  measure: tax_amount { label: "Tax Amount"  type: sum  sql: ${TABLE}.TAX_AMOUNT ;;  value_format: "$#,##0.00" }
  measure: invoiced_revenue { label: "Total Invoiced"  type: number  sql: ${nontax_amount} + ${tax_amount} ;;  value_format: "$#,##0.00" }
  measure: avg_invoice_value {
    label: "Average Invoice Value"
    type: number  sql: ${invoiced_revenue} / NULLIF(${total_invoice_generated},0) ;;  value_format: "$#,##0.00"
  }
  measure: projected_revenue {
    label: "Projected Revenue"
    type: number  sql: ${avg_invoice_value} * ${account.eligible_accounts} ;;  value_format: "$#,##0.00"
  }
  measure: revenue_variance { label: "Revenue Variance"  type: number  sql: ${invoiced_revenue} - ${projected_revenue} ;;  value_format: "$#,##0.00" }
  measure: total_line_items { label: "Line Items"  type: sum  sql: ${TABLE}.COUNTS ;;  value_format: "#,##0" }
  measure: total_quantity { label: "Total Quantity"  type: sum  sql: ${TABLE}.QUANTITY ;;  value_format: "#,##0" }
}
