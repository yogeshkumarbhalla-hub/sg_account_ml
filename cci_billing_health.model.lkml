connection: "snowflake_sg"   # <- set your connection name
# include: "/**/*.view.lkml"
# include: "/**/*.dashboard.lookml"

# Static-data views: no database tables are read (SQL literals only).
view: cci_billing_cycle {
  derived_table: { sql:
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 28033.92 AS active_accounts, 1130.88 AS suspended_accounts, 595.2 AS pending_accounts, 230.4 AS terminated_accounts, 29752 AS generated_bills, 8 AS ungenerated_accounts, 10 AS zero_bills, 7 AS negative_bills, 1920935.13 AS total_bill_amt, 32 AS run_minutes
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 30662.1 AS active_accounts, 1236.9 AS suspended_accounts, 651 AS pending_accounts, 252 AS terminated_accounts, 32544 AS generated_bills, 6 AS ungenerated_accounts, 11 AS zero_bills, 6 AS negative_bills, 2101022.79 AS total_bill_amt, 86 AS run_minutes
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 28909.98 AS active_accounts, 1166.22 AS suspended_accounts, 613.8 AS pending_accounts, 237.6 AS terminated_accounts, 30683 AS generated_bills, 7 AS ungenerated_accounts, 10 AS zero_bills, 6 AS negative_bills, 1980964.34 AS total_bill_amt, 50 AS run_minutes
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 29239.68 AS active_accounts, 1179.52 AS suspended_accounts, 620.8 AS pending_accounts, 217.6 AS terminated_accounts, 31036 AS generated_bills, 4 AS ungenerated_accounts, 12 AS zero_bills, 6 AS negative_bills, 2003555.99 AS total_bill_amt, 55 AS run_minutes
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 31980.9 AS active_accounts, 1290.1 AS suspended_accounts, 679 AS pending_accounts, 238 AS terminated_accounts, 33945 AS generated_bills, 5 AS ungenerated_accounts, 14 AS zero_bills, 5 AS negative_bills, 2191389.36 AS total_bill_amt, 110 AS run_minutes
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 30153.42 AS active_accounts, 1216.38 AS suspended_accounts, 640.2 AS pending_accounts, 224.4 AS terminated_accounts, 32005 AS generated_bills, 5 AS ungenerated_accounts, 12 AS zero_bills, 5 AS negative_bills, 2066167.12 AS total_bill_amt, 74 AS run_minutes
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 30144 AS active_accounts, 1216 AS suspended_accounts, 640 AS pending_accounts, 243.2 AS terminated_accounts, 31994 AS generated_bills, 6 AS ungenerated_accounts, 13 AS zero_bills, 5 AS negative_bills, 2065521.64 AS total_bill_amt, 79 AS run_minutes
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 32970 AS active_accounts, 1330 AS suspended_accounts, 700 AS pending_accounts, 266 AS terminated_accounts, 34993 AS generated_bills, 7 AS ungenerated_accounts, 15 AS zero_bills, 6 AS negative_bills, 2259164.29 AS total_bill_amt, 44 AS run_minutes
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 31086 AS active_accounts, 1254 AS suspended_accounts, 660 AS pending_accounts, 250.8 AS terminated_accounts, 32994 AS generated_bills, 6 AS ungenerated_accounts, 12 AS zero_bills, 4 AS negative_bills, 2130069.19 AS total_bill_amt, 98 AS run_minutes ;; }
  dimension: billing_month { type: string sql: ${TABLE}.billing_month ;; }
  dimension: cycle { type: string sql: ${TABLE}.cycle ;; }
  measure: total_bills { type: sum sql: ${TABLE}.generated_bills ;; value_format: "#,##0" }
  measure: total_bill_amt { type: sum sql: ${TABLE}.total_bill_amt ;; value_format: "$#,##0.00" }
  measure: avg_bill { type: number sql: ${total_bill_amt}/NULLIF(${total_bills},0) ;; value_format: "$#,##0.00" }
  measure: zero_bills { type: sum sql: ${TABLE}.zero_bills ;; }
  measure: negative_bills { type: sum sql: ${TABLE}.negative_bills ;; }
  measure: ungenerated { type: sum sql: ${TABLE}.ungenerated_accounts ;; }
  measure: active { type: sum sql: ${TABLE}.active_accounts ;; value_format: "#,##0" }
  measure: susp_pending { type: sum sql: ${TABLE}.suspended_accounts+${TABLE}.pending_accounts ;; value_format: "#,##0" }
  measure: eligible { type: sum sql: ${TABLE}.active_accounts+${TABLE}.suspended_accounts+${TABLE}.pending_accounts ;; value_format: "#,##0" }
  measure: terminated { type: sum sql: ${TABLE}.terminated_accounts ;; value_format: "#,##0" }
  measure: gen_rate { type: number sql: 100.0*${total_bills}/NULLIF(${eligible},0) ;; value_format: "0.000\"%\"" }
  measure: acceptance { type: string sql: CASE WHEN ${gen_rate}>=99.95 THEN 'PASS' ELSE 'FAIL' END ;; }
  measure: run_minutes { type: sum sql: ${TABLE}.run_minutes ;; value_format: "0\" min\"" }
}
view: cci_ungenerated {
  derived_table: { sql:
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700126' AS account_id, 'SI9100234' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700163' AS account_id, 'SI9100347' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700200' AS account_id, 'SI9100460' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700237' AS account_id, 'SI9100573' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700274' AS account_id, 'SI9100686' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700311' AS account_id, 'SI9100799' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700348' AS account_id, 'SI9100912' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'AC700385' AS account_id, 'SI9101025' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'AC701126' AS account_id, 'SI9101234' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'AC701163' AS account_id, 'SI9101347' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'AC701200' AS account_id, 'SI9101460' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'AC701237' AS account_id, 'SI9101573' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'AC701274' AS account_id, 'SI9101686' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'AC701311' AS account_id, 'SI9101799' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'AC702126' AS account_id, 'SI9102234' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'AC702163' AS account_id, 'SI9102347' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'AC702200' AS account_id, 'SI9102460' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'AC702237' AS account_id, 'SI9102573' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'AC702274' AS account_id, 'SI9102686' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'AC702311' AS account_id, 'SI9102799' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'AC702348' AS account_id, 'SI9102912' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'AC700113' AS account_id, 'SI9100217' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'AC700150' AS account_id, 'SI9100330' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'AC700187' AS account_id, 'SI9100443' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'AC700224' AS account_id, 'SI9100556' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'AC701113' AS account_id, 'SI9101217' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'AC701150' AS account_id, 'SI9101330' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'AC701187' AS account_id, 'SI9101443' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'AC701224' AS account_id, 'SI9101556' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'AC701261' AS account_id, 'SI9101669' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'AC702113' AS account_id, 'SI9102217' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'AC702150' AS account_id, 'SI9102330' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'AC702187' AS account_id, 'SI9102443' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'AC702224' AS account_id, 'SI9102556' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'AC702261' AS account_id, 'SI9102669' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'AC700100' AS account_id, 'SI9100200' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'AC700137' AS account_id, 'SI9100313' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'AC700174' AS account_id, 'SI9100426' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'AC700211' AS account_id, 'SI9100539' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'AC700248' AS account_id, 'SI9100652' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'AC700285' AS account_id, 'SI9100765' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'AC701100' AS account_id, 'SI9101200' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'AC701137' AS account_id, 'SI9101313' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'AC701174' AS account_id, 'SI9101426' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'AC701211' AS account_id, 'SI9101539' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'AC701248' AS account_id, 'SI9101652' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'AC701285' AS account_id, 'SI9101765' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'AC701322' AS account_id, 'SI9101878' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'AC702100' AS account_id, 'SI9102200' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'AC702137' AS account_id, 'SI9102313' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'AC702174' AS account_id, 'SI9102426' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'AC702211' AS account_id, 'SI9102539' AS si_number, 'Family Share 5G' AS rate_plan, 'ACTIVE_PENDING' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'AC702248' AS account_id, 'SI9102652' AS si_number, 'Unlimited Plus 5G' AS rate_plan, 'ACTIVE' AS account_status, 'NONE' AS port_type, '—' AS porting_donor
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'AC702285' AS account_id, 'SI9102765' AS si_number, 'Value 4G Plan' AS rate_plan, 'SUSPENDED' AS account_status, 'PORT_IN' AS port_type, 'Telco A' AS porting_donor ;; }
  dimension: billing_month { type: string sql: ${TABLE}.billing_month ;; }
  dimension: cycle { type: string sql: ${TABLE}.cycle ;; }
  dimension: account_id { type: string sql: ${TABLE}.account_id ;; }
  dimension: si_number { type: string sql: ${TABLE}.si_number ;; }
  dimension: rate_plan { type: string sql: ${TABLE}.rate_plan ;; }
  dimension: account_status { type: string sql: ${TABLE}.account_status ;; }
  dimension: port_type { type: string sql: ${TABLE}.port_type ;; }
  dimension: porting_donor { type: string sql: ${TABLE}.porting_donor ;; }
}
view: cci_product_revenue {
  derived_table: { sql:
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 18451.2 AS line_items, 18451.2 AS qty, 896514.17 AS non_tax, 187488.1 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 11303.15 AS line_items, 11303.15 AS qty, 543596.16 AS non_tax, 113088 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 12261.12 AS line_items, 92404.8 AS qty, 44677.02 AS non_tax, 44640 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 8451.84 AS line_items, 27379.2 AS qty, 26813.76 AS non_tax, 18451.2 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4166.4 AS line_items, 4166.4 AS qty, 41759.23 AS non_tax, 23808 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 2946.24 AS line_items, 2946.24 AS qty, 29462.4 AS non_tax, 13848.82 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 8957.76 AS line_items, 8957.76 AS qty, -44760.53 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 1845.12 AS line_items, 1845.12 AS qty, -18451.2 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 20181 AS line_items, 20181 AS qty, 980562.37 AS non_tax, 205065.11 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 12362.82 AS line_items, 12362.82 AS qty, 594558.3 AS non_tax, 123690 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 13410.6 AS line_items, 101067.75 AS qty, 48865.49 AS non_tax, 48825 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 9244.2 AS line_items, 29946 AS qty, 29327.55 AS non_tax, 20181 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4557 AS line_items, 4557 AS qty, 45674.16 AS non_tax, 26040 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3222.45 AS line_items, 3222.45 AS qty, 32224.5 AS non_tax, 15147.14 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 9797.55 AS line_items, 9797.55 AS qty, -48956.83 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 2018.1 AS line_items, 2018.1 AS qty, -20181 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 19027.8 AS line_items, 19027.8 AS qty, 924530.23 AS non_tax, 193347.09 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 11656.36 AS line_items, 11656.36 AS qty, 560583.54 AS non_tax, 116622 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 12644.28 AS line_items, 95292.45 AS qty, 46073.18 AS non_tax, 46035 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 8715.96 AS line_items, 28234.8 AS qty, 27651.69 AS non_tax, 19027.8 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4296.6 AS line_items, 4296.6 AS qty, 43064.21 AS non_tax, 24552 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3038.31 AS line_items, 3038.31 AS qty, 30383.1 AS non_tax, 14281.59 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 9237.69 AS line_items, 9237.69 AS qty, -46159.29 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 1902.78 AS line_items, 1902.78 AS qty, -19027.8 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 19244.8 AS line_items, 19244.8 AS qty, 935073.92 AS non_tax, 195552.1 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 11789.3 AS line_items, 11789.3 AS qty, 566976.64 AS non_tax, 117952 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 12788.48 AS line_items, 96379.2 AS qty, 46598.61 AS non_tax, 46560 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 8815.36 AS line_items, 28556.8 AS qty, 27967.04 AS non_tax, 19244.8 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4345.6 AS line_items, 4345.6 AS qty, 43555.33 AS non_tax, 24832 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3072.96 AS line_items, 3072.96 AS qty, 30729.6 AS non_tax, 14444.46 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 9343.04 AS line_items, 9343.04 AS qty, -46685.71 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 1924.48 AS line_items, 1924.48 AS qty, -19244.8 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 21049 AS line_items, 21049 AS qty, 1022737.1 AS non_tax, 213885.11 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 12894.55 AS line_items, 12894.55 AS qty, 620130.7 AS non_tax, 129010 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 13987.4 AS line_items, 105414.75 AS qty, 50967.23 AS non_tax, 50925 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 9641.8 AS line_items, 31234 AS qty, 30588.95 AS non_tax, 21049 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4753 AS line_items, 4753 AS qty, 47638.64 AS non_tax, 27160 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3361.05 AS line_items, 3361.05 AS qty, 33610.5 AS non_tax, 15798.63 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 10218.95 AS line_items, 10218.95 AS qty, -51062.5 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 2104.9 AS line_items, 2104.9 AS qty, -21049 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 19846.2 AS line_items, 19846.2 AS qty, 964294.97 AS non_tax, 201663.1 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 12157.72 AS line_items, 12157.72 AS qty, 584694.66 AS non_tax, 121638 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 13188.12 AS line_items, 99391.05 AS qty, 48054.83 AS non_tax, 48015 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 9090.84 AS line_items, 29449.2 AS qty, 28841.01 AS non_tax, 19846.2 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4481.4 AS line_items, 4481.4 AS qty, 44916.43 AS non_tax, 25608 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3168.99 AS line_items, 3168.99 AS qty, 31689.9 AS non_tax, 14895.86 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 9635.01 AS line_items, 9635.01 AS qty, -48144.64 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 1984.62 AS line_items, 1984.62 AS qty, -19846.2 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 19840 AS line_items, 19840 AS qty, 963993.73 AS non_tax, 201600.1 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 12153.92 AS line_items, 12153.92 AS qty, 584512 AS non_tax, 121600 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 13184 AS line_items, 99360 AS qty, 48039.81 AS non_tax, 48000 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 9088 AS line_items, 29440 AS qty, 28832 AS non_tax, 19840 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4480 AS line_items, 4480 AS qty, 44902.4 AS non_tax, 25600 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3168 AS line_items, 3168 AS qty, 31680 AS non_tax, 14891.2 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 9632 AS line_items, 9632 AS qty, -48129.6 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 1984 AS line_items, 1984 AS qty, -19840 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 21700 AS line_items, 21700 AS qty, 1054368.14 AS non_tax, 220500.11 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 13293.35 AS line_items, 13293.35 AS qty, 639310 AS non_tax, 133000 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 14420 AS line_items, 108675 AS qty, 52543.54 AS non_tax, 52500 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 9940 AS line_items, 32200 AS qty, 31535 AS non_tax, 21700 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4900 AS line_items, 4900 AS qty, 49112 AS non_tax, 28000 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3465 AS line_items, 3465 AS qty, 34650 AS non_tax, 16287.25 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 10535 AS line_items, 10535 AS qty, -52641.75 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 2170 AS line_items, 2170 AS qty, -21700 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Unlimited Plus 5G' AS product, 'RECURRING' AS revenue_type, 20460 AS line_items, 20460 AS qty, 994118.53 AS non_tax, 207900.11 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Value 4G Plan' AS product, 'RECURRING' AS revenue_type, 12533.73 AS line_items, 12533.73 AS qty, 602778 AS non_tax, 125400 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Roaming Data' AS product, 'USAGE' AS revenue_type, 13596 AS line_items, 102465 AS qty, 49541.05 AS non_tax, 49500 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Voice Overage' AS product, 'USAGE' AS revenue_type, 9372 AS line_items, 30360 AS qty, 29733 AS non_tax, 20460 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Data Booster 5GB' AS product, 'ADDON' AS revenue_type, 4620 AS line_items, 4620 AS qty, 46305.6 AS non_tax, 26400 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Intl Calling Pack' AS product, 'ADDON' AS revenue_type, 3267 AS line_items, 3267 AS qty, 32670 AS non_tax, 15356.55 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Loyalty Waiver' AS product, 'DISCOUNT' AS revenue_type, 9933 AS line_items, 9933 AS qty, -49633.65 AS non_tax, 0 AS tax_amt
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Promo Waiver' AS product, 'DISCOUNT' AS revenue_type, 2046 AS line_items, 2046 AS qty, -20460 AS non_tax, 0 AS tax_amt ;; }
  dimension: billing_month { type: string sql: ${TABLE}.billing_month ;; }
  dimension: cycle { type: string sql: ${TABLE}.cycle ;; }
  dimension: product { type: string sql: ${TABLE}.product ;; }
  dimension: revenue_type { type: string sql: ${TABLE}.revenue_type ;; }
  measure: line_items { type: sum sql: ${TABLE}.line_items ;; value_format: "#,##0" }
  measure: qty { type: sum sql: ${TABLE}.qty ;; value_format: "#,##0" }
  measure: non_tax { type: sum sql: ${TABLE}.non_tax ;; value_format: "$#,##0.00" }
  measure: tax_amt { type: sum sql: ${TABLE}.tax_amt ;; value_format: "$#,##0.00" }
  measure: total_invoiced { type: number sql: ${non_tax}+${tax_amt} ;; value_format: "$#,##0.00" }
  measure: invoice_revenue { type: number sql: ${non_tax}+${tax_amt} ;; value_format: "$#,##0.00" }
}
view: cci_state_revenue {
  derived_table: { sql:
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'CA' AS state, 112370.75 AS tax_amt, 557071.19 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'NY' AS state, 84278.07 AS tax_amt, 384187.03 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'TX' AS state, 68225.1 AS tax_amt, 307349.62 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'IL' AS state, 44145.65 AS tax_amt, 211302.86 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'FL' AS state, 36119.17 AS tax_amt, 172884.16 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 1' AS cycle, 'Other / National' AS state, 56185.38 AS tax_amt, 288140.27 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'CA' AS state, 122905.51 AS tax_amt, 609296.61 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'NY' AS state, 92179.13 AS tax_amt, 420204.56 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'TX' AS state, 74621.2 AS tax_amt, 336163.65 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'IL' AS state, 48284.31 AS tax_amt, 231112.51 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'FL' AS state, 39505.34 AS tax_amt, 189092.05 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 2' AS cycle, 'Other / National' AS state, 61452.76 AS tax_amt, 315153.41 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'CA' AS state, 115882.33 AS tax_amt, 574479.66 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'NY' AS state, 86911.75 AS tax_amt, 396192.87 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'TX' AS state, 70357.13 AS tax_amt, 316954.29 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'IL' AS state, 45525.2 AS tax_amt, 217906.08 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'FL' AS state, 37247.89 AS tax_amt, 178286.79 AS revenue
        UNION ALL
        SELECT '202607' AS billing_month, 'Cycle 3' AS cycle, 'Other / National' AS state, 57941.18 AS tax_amt, 297144.65 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'CA' AS state, 117203.9 AS tax_amt, 581031.24 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'NY' AS state, 87902.93 AS tax_amt, 400711.2 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'TX' AS state, 71159.51 AS tax_amt, 320568.96 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'IL' AS state, 46044.39 AS tax_amt, 220391.16 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'FL' AS state, 37672.68 AS tax_amt, 180320.04 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 1' AS cycle, 'Other / National' AS state, 58601.95 AS tax_amt, 300533.39 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'CA' AS state, 128191.77 AS tax_amt, 635502.91 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'NY' AS state, 96143.83 AS tax_amt, 438277.87 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'TX' AS state, 77830.72 AS tax_amt, 350622.3 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'IL' AS state, 50361.05 AS tax_amt, 241052.83 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'FL' AS state, 41204.5 AS tax_amt, 197225.04 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 2' AS cycle, 'Other / National' AS state, 64095.87 AS tax_amt, 328708.41 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'CA' AS state, 120866.52 AS tax_amt, 599188.46 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'NY' AS state, 90649.89 AS tax_amt, 413233.42 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'TX' AS state, 73383.25 AS tax_amt, 330586.74 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'IL' AS state, 47483.28 AS tax_amt, 227278.38 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'FL' AS state, 38849.95 AS tax_amt, 185955.04 AS revenue
        UNION ALL
        SELECT '202608' AS billing_month, 'Cycle 3' AS cycle, 'Other / National' AS state, 60433.27 AS tax_amt, 309925.08 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'CA' AS state, 120828.76 AS tax_amt, 599001.28 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'NY' AS state, 90621.57 AS tax_amt, 413104.33 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'TX' AS state, 73360.32 AS tax_amt, 330483.46 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'IL' AS state, 47468.44 AS tax_amt, 227207.38 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'FL' AS state, 38837.82 AS tax_amt, 185896.95 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 1' AS cycle, 'Other / National' AS state, 60414.39 AS tax_amt, 309828.24 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'CA' AS state, 132156.46 AS tax_amt, 655157.64 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'NY' AS state, 99117.35 AS tax_amt, 451832.86 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'TX' AS state, 80237.85 AS tax_amt, 361466.29 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'IL' AS state, 51918.61 AS tax_amt, 248508.07 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'FL' AS state, 42478.86 AS tax_amt, 203324.79 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 2' AS cycle, 'Other / National' AS state, 66078.23 AS tax_amt, 338874.64 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'CA' AS state, 124604.66 AS tax_amt, 617720.07 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'NY' AS state, 93453.5 AS tax_amt, 426013.84 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'TX' AS state, 75652.83 AS tax_amt, 340811.07 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'IL' AS state, 48951.83 AS tax_amt, 234307.61 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'FL' AS state, 40051.5 AS tax_amt, 191706.23 AS revenue
        UNION ALL
        SELECT '202609' AS billing_month, 'Cycle 3' AS cycle, 'Other / National' AS state, 62302.34 AS tax_amt, 319510.37 AS revenue ;; }
  dimension: billing_month { type: string sql: ${TABLE}.billing_month ;; }
  dimension: cycle { type: string sql: ${TABLE}.cycle ;; }
  dimension: state { type: string sql: ${TABLE}.state ;; }
  measure: revenue { type: sum sql: ${TABLE}.revenue ;; value_format: "$#,##0.00" }
  measure: tax_amt { type: sum sql: ${TABLE}.tax_amt ;; value_format: "$#,##0.00" }
}
explore: cci_billing_cycle {}
explore: cci_ungenerated {}
explore: cci_product_revenue {}
explore: cci_state_revenue {}
