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

  # --- ROW 1: REVENUE KPIS ---

  - name: r_total_invoices
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.total_bills]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">TOTAL INVOICES</div>
        <div style="font-size:28px; font-weight:700; color:#5b3df5; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">COUNT(DISTINCT BILL_NO)</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:4px;">▲ +2,995 (+3.1%) vs last month</div>
      </div>
    row: 2
    col: 0
    width: 4
    height: 4

  - name: r_total_revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.total_revenue]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">TOTAL REVENUE</div>
        <div style="font-size:28px; font-weight:700; color:#0e9f57; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">Product does not contain waiver</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:4px;">▲ +$0.20M (+3.1%) vs last month</div>
      </div>
    row: 2
    col: 4
    width: 4
    height: 4

  - name: r_waivers
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.waivers]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">WAIVERS</div>
        <div style="font-size:28px; font-weight:700; color:#d98200; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">Product contains waiver (negative)</div>
        <div style="font-size:11.5px; font-weight:600; color:#6b7794; margin-top:4px;">▼ -$0.01M (-3.1%) vs last month</div>
      </div>
    row: 2
    col: 8
    width: 4
    height: 4

  - name: r_invoice_revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.invoice_revenue_m]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">INVOICE REVENUE</div>
        <div style="font-size:28px; font-weight:700; color:#5b3df5; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">Total Revenue - Waivers</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:4px;">▲ +$0.19M (+3.1%) vs last month</div>
      </div>
    row: 2
    col: 12
    width: 4
    height: 4

  - name: r_projected
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.projected_revenue]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">PROJECTED REVENUE</div>
        <div style="font-size:28px; font-weight:700; color:#111a35; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">Cycle-consistent projected revenue across 100,000 eligible accounts</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:4px;">▲ +$0.19M (+3.1%) vs last month</div>
      </div>
    row: 2
    col: 16
    width: 4
    height: 4

  - name: r_variance
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.revenue_variance]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">REVENUE VARIANCE</div>
        <div style="font-size:28px; font-weight:700; color:#d98200; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">Invoice - Projected (negative = shortfall)</div>
        <div style="font-size:11.5px; font-weight:600; color:#d98200; margin-top:4px;">▼ -$0.32K vs last month</div>
      </div>
    row: 2
    col: 20
    width: 4
    height: 4

  # --- ROW 2: ACCOUNT KPIS ---

  - name: r_active
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.active]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">ACTIVE ACCOUNTS</div>
        <div style="font-size:28px; font-weight:700; color:#5b3df5; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">ACCOUNT_STATUS = ACTIVE</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:4px;">▲ +2,826 (+3.1%) vs last month</div>
      </div>
    row: 6
    col: 0
    width: 6
    height: 4

  - name: r_susp
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.susp_pending]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">SUSPENDED / PENDING</div>
        <div style="font-size:28px; font-weight:700; color:#111a35; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">SUSPENDED + ACTIVE_PENDING — billing-eligible</div>
        <div style="font-size:11.5px; font-weight:600; color:#6b7794; margin-top:4px;">▲ +174 (+3.1%) vs last month</div>
      </div>
    row: 6
    col: 6
    width: 6
    height: 4

  - name: r_elig
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.eligible]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">ELIGIBLE ACCOUNTS</div>
        <div style="font-size:28px; font-weight:700; color:#0e9f57; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">Active + Suspended / Pending</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:4px;">▲ +3,000 (+3.1%) vs last month</div>
      </div>
    row: 6
    col: 12
    width: 6
    height: 4

  - name: r_term
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.terminated]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="font-family:'Segoe UI',sans-serif; padding:14px; min-height:110px; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11.5px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">TERMINATED</div>
        <div style="font-size:28px; font-weight:700; color:#111a35; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11.5px; color:#6b7794;">Not billing-eligible</div>
        <div style="font-size:11.5px; font-weight:600; color:#d98200; margin-top:4px;">▲ +77 (+11.8%) vs last month</div>
      </div>
    row: 6
    col: 18
    width: 6
    height: 4

  # --- GRIDS ---

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
    row: 10
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
    row: 10
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
    row: 17
    col: 0
    width: 24
    height: 9
