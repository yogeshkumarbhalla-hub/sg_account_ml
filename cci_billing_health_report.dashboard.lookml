# link_tiles_marker
- dashboard: cci_billing_health_report
  title: Billing Cycle Health Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  filters:
  - name: Billing Month
    title: Billing Month
    type: field_filter
    default_value: '202609'
    allow_multiple_values: false
    required: false
    ui_config: {type: button_toggles, display: inline}
    model: cci_billing_health
    explore: cci_billing_cycle
    field: cci_billing_cycle.billing_month
  - name: Billing Cycle
    title: Billing Cycle (blank = All Cycles)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config: {type: checkboxes, display: inline}
    model: cci_billing_health
    explore: cci_billing_cycle
    field: cci_billing_cycle.cycle
  elements:
  - name: open_html_version
    type: text
    title_text: ''
    body_text: '**[Open the full interactive Billing Cycle Health dashboard (exact layout)](https://report.traceana.com/Billing_Dashboard.html)**  |  [Revenue dashboard](https://report.traceana.com/Revenue_Dashboard.html)'
    row: 0
    col: 0
    width: 24
    height: 2
  - name: total_bills
    title: Total Bills
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.total_bills]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 2
    col: 0
    width: 4
    height: 3
  - name: total_bill_
    title: Total Bill $
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.total_bill_amt]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 2
    col: 4
    width: 4
    height: 3
  - name: average_bill_
    title: Average Bill $
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.avg_bill]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 2
    col: 8
    width: 4
    height: 3
  - name: zero_dollar_bills
    title: Zero-Dollar Bills
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.zero_bills]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 2
    col: 12
    width: 4
    height: 3
  - name: negative_bills
    title: Negative Bills
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.negative_bills]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 2
    col: 16
    width: 4
    height: 3
  - name: ungenerated_accounts_table
    title: Ungenerated Accounts
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.ungenerated]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 2
    col: 20
    width: 4
    height: 3
  - name: invoice_generation_rate
    title: Invoice Generation Rate
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.gen_rate]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 5
    col: 0
    width: 8
    height: 3
  - name: acceptance_ac_2_4_01_
    title: Acceptance (AC 2.4-01)
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.acceptance]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 5
    col: 8
    width: 8
    height: 3
  - name: bill_run_duration
    title: Bill Run Duration
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.run_minutes]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 5
    col: 16
    width: 8
    height: 3
  - name: active_accounts
    title: Active Accounts
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.active]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 8
    col: 0
    width: 6
    height: 3
  - name: suspended_pending
    title: Suspended / Pending
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.susp_pending]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 8
    col: 6
    width: 6
    height: 3
  - name: eligible_accounts
    title: Eligible Accounts
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.eligible]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 8
    col: 12
    width: 6
    height: 3
  - name: monthly_terminations
    title: Monthly Terminations
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.terminated]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    row: 8
    col: 18
    width: 6
    height: 3
  - name: revenue_by_state
    title: Jurisdictional Breakdown (US)
    type: looker_grid
    model: cci_billing_health
    explore: cci_state_revenue
    fields: [cci_state_revenue.state, cci_state_revenue.revenue, cci_state_revenue.tax_amt]
    sorts: [cci_state_revenue.revenue desc]
    listen:
      Billing Month: cci_state_revenue.billing_month
      Billing Cycle: cci_state_revenue.cycle
    show_row_numbers: false
    row: 11
    col: 0
    width: 12
    height: 7
  - name: product_revenue
    title: Product Revenue Summary
    type: looker_grid
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.product, cci_product_revenue.revenue_type, cci_product_revenue.line_items, cci_product_revenue.qty, cci_product_revenue.non_tax, cci_product_revenue.tax_amt, cci_product_revenue.total_invoiced]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_row_numbers: false
    row: 11
    col: 12
    width: 12
    height: 7
  - name: ungenerated_accounts
    title: Ungenerated Accounts (BILL_NO IS NULL)
    type: looker_grid
    model: cci_billing_health
    explore: cci_ungenerated
    fields: [cci_ungenerated.account_id, cci_ungenerated.si_number, cci_ungenerated.rate_plan, cci_ungenerated.account_status, cci_ungenerated.port_type, cci_ungenerated.porting_donor]
    listen:
      Billing Month: cci_ungenerated.billing_month
      Billing Cycle: cci_ungenerated.cycle
    show_row_numbers: false
    row: 18
    col: 0
    width: 24
    height: 8
