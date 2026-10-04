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
  measure: total_invoice_generated { type: count_distinct  sql: ${TABLE}.BILL_NO ;; }
  measure: generated_eligible {
    type: count_distinct  sql: ${TABLE}.BILL_NO ;;  filters: [account.is_eligible: "Yes"]
  }
  measure: generation_rate {
    type: number  sql: 1.0 * ${generated_eligible} / NULLIF(${account.eligible_accounts},0) ;;
    value_format: "0.000%"
  }
  measure: nontax_amount { type: sum  sql: ${TABLE}.NONTAX_AMOUNT ;;  value_format_name: usd }
  measure: tax_amount { type: sum  sql: ${TABLE}.TAX_AMOUNT ;;  value_format_name: usd }
  measure: invoiced_revenue { type: number  sql: ${nontax_amount} + ${tax_amount} ;;  value_format_name: usd }
  measure: avg_invoice_value {
    type: number  sql: ${invoiced_revenue} / NULLIF(${total_invoice_generated},0) ;;  value_format_name: usd
  }
  measure: projected_revenue {
    type: number  sql: ${avg_invoice_value} * ${account.eligible_accounts} ;;  value_format_name: usd
  }
  measure: revenue_variance { type: number  sql: ${invoiced_revenue} - ${projected_revenue} ;;  value_format_name: usd }
  measure: total_line_items { type: sum  sql: ${TABLE}."COUNT" ;; }
  measure: total_quantity { type: sum  sql: ${TABLE}.QUANTITY ;; }
}
