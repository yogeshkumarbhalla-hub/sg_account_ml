# link_tiles_marker
- dashboard: cci_revenue_report
  title: Revenue Dashboard
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
    body_text: '<div style="border-bottom:1px solid #dfe4ee;padding:0"><a href="/dashboards/cci_billing_health::cci_revenue_report" style="display:inline-block;padding:9px 18px;margin-right:6px;font:600 14px Segoe UI,Arial,sans-serif;text-decoration:none;border-bottom:3px solid #5b3df5;color:#5b3df5">Revenue Dashboard</a><a href="/dashboards/cci_billing_health::cci_billing_health_report" style="display:inline-block;padding:9px 18px;margin-right:6px;font:600 14px Segoe UI,Arial,sans-serif;text-decoration:none;border-bottom:3px solid transparent;color:#6b7794">Billing Cycle Health</a></div>'
    row: 0
    col: 0
    width: 24
    height: 2
  - name: r_total_invoices
    title: Total Invoices
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.total_bills]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    single_value_title: TOTAL INVOICES
    custom_color_enabled: true
    custom_color: "#5b3df5"
    enable_conditional_formatting: false
    row: 2
    col: 0
    width: 4
    height: 3
  - name: r_total_revenue
    title: Total Revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.total_revenue]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: true
    show_comparison: false
    single_value_title: TOTAL REVENUE
    custom_color_enabled: true
    custom_color: "#0e9f57"
    enable_conditional_formatting: false
    row: 2
    col: 4
    width: 4
    height: 3
  - name: r_waivers
    title: Waivers
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.waivers]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: true
    show_comparison: false
    single_value_title: WAIVERS
    custom_color_enabled: true
    custom_color: "#d98200"
    enable_conditional_formatting: false
    row: 2
    col: 8
    width: 4
    height: 3
  - name: r_invoice_revenue
    title: Invoice Revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.invoice_revenue_m]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: true
    show_comparison: false
    single_value_title: INVOICE REVENUE
    custom_color_enabled: true
    custom_color: "#5b3df5"
    enable_conditional_formatting: false
    row: 2
    col: 12
    width: 4
    height: 3
  - name: r_projected
    title: Projected Revenue
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.projected_revenue]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    single_value_title: PROJECTED REVENUE
    custom_color_enabled: true
    custom_color: "#111a35"
    enable_conditional_formatting: false
    row: 2
    col: 16
    width: 4
    height: 3
  - name: r_variance
    title: Revenue Variance
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.revenue_variance]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    single_value_title: REVENUE VARIANCE
    custom_color_enabled: true
    custom_color: "#d98200"
    enable_conditional_formatting: false
    row: 2
    col: 20
    width: 4
    height: 3
  - name: r_active
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
    single_value_title: ACTIVE ACCOUNTS
    custom_color_enabled: true
    custom_color: "#5b3df5"
    enable_conditional_formatting: false
    row: 5
    col: 0
    width: 6
    height: 3
  - name: r_susp
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
    single_value_title: SUSPENDED / PENDING
    custom_color_enabled: true
    custom_color: "#111a35"
    enable_conditional_formatting: false
    row: 5
    col: 6
    width: 6
    height: 3
  - name: r_elig
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
    single_value_title: ELIGIBLE ACCOUNTS
    custom_color_enabled: true
    custom_color: "#0e9f57"
    enable_conditional_formatting: false
    row: 5
    col: 12
    width: 6
    height: 3
  - name: r_term
    title: Terminated
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.terminated]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: true
    show_comparison: false
    single_value_title: TERMINATED
    custom_color_enabled: true
    custom_color: "#111a35"
    enable_conditional_formatting: false
    row: 5
    col: 18
    width: 6
    height: 3
  - name: r_mix
    title: Invoiced Revenue Mix (by revenue type)
    type: looker_grid
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.revenue_type, cci_product_revenue.non_tax, cci_product_revenue.tax_amt, cci_product_revenue.total_invoiced]
    sorts: [cci_product_revenue.total_invoiced desc]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_row_numbers: false
    row: 8
    col: 0
    width: 12
    height: 7
  - name: r_state
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
    row: 8
    col: 12
    width: 12
    height: 7
  - name: r_product
    title: Product Revenue Summary
    type: looker_grid
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.product, cci_product_revenue.revenue_type, cci_product_revenue.line_items, cci_product_revenue.qty, cci_product_revenue.non_tax, cci_product_revenue.tax_amt, cci_product_revenue.total_invoiced]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_row_numbers: false
    row: 15
    col: 0
    width: 24
    height: 9
