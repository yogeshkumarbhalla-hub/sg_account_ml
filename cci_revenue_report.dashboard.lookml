# link_tiles_marker
- dashboard: cci_revenue_report
  title: Revenue Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: false
  filters_location_top: true
  embed_style:
    background_color: "#f5f7fb"
    show_title: false
    show_filters_bar: true
    tile_text_color: "#6b7794"
    text_tile_text_color: "#111a35"

  filters:
  - name: Billing Month
    title: Billing Month
    type: field_filter
    default_value: '202609'
    allow_multiple_values: false
    required: false
    ui_config: {type: dropdown_menu, display: inline}
    model: cci_billing_health
    explore: cci_billing_cycle
    field: cci_billing_cycle.selected_month
  - name: Billing Cycle
    title: Billing Cycle
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config: {type: dropdown_menu, display: inline}
    model: cci_billing_health
    explore: cci_billing_cycle
    field: cci_billing_cycle.cycle

  elements:
  # --- HEADER & NAVIGATION TABS ---
  - name: dashboard_header
    type: text
    title_text: ''
    body_text: |
      <div style="background:#ffffff; border-radius:12px; padding:16px 20px; box-shadow:0 1px 3px rgba(17,26,53,0.06); border:1px solid #eef1f7; font-family:'Segoe UI', sans-serif;">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
          <div>
            <h1 style="margin:0; font-size:20px; font-weight:700; color:#111a35;">Revenue Dashboard</h1>
            <span style="font-size:12px; color:#6b7794;">Executive Billing & Revenue Intelligence Suite</span>
          </div>
        </div>
        <div style="display:flex; gap:8px; border-bottom:1px solid #dfe4ee; padding-top:4px;">
          <a href="/dashboards/cci_billing_health::cci_revenue_report" style="padding:8px 16px; font-size:13px; font-weight:600; text-decoration:none; color:#5b3df5; border-bottom:3px solid #5b3df5;">Revenue Overview</a>
          <a href="/dashboards/cci_billing_health::cci_billing_health_report" style="padding:8px 16px; font-size:13px; font-weight:600; text-decoration:none; color:#6b7794; border-bottom:3px solid transparent;">Billing Cycle Health</a>
        </div>
      </div>
    row: 0
    col: 0
    width: 24
    height: 3

  # --- ROW 1: TOP REVENUE KPIS ---

  - name: r_total_invoices
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.billing_month, cci_billing_cycle.total_bills]
    filters:
      cci_billing_cycle.period_flag: Current,Prior
    sorts: [cci_billing_cycle.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_billing_cycle.selected_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">TOTAL INVOICES</div>
        <div style="font-size:28px; font-weight:700; color:#5b3df5; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">COUNT(DISTINCT BILL_NO)</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +2,995 (+3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 3
    col: 0
    width: 4
    height: 4

  - name: r_total_revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.billing_month, cci_product_revenue.total_revenue]
    filters:
      cci_product_revenue.period_flag: Current,Prior
    sorts: [cci_product_revenue.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_product_revenue.selected_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">TOTAL REVENUE</div>
        <div style="font-size:28px; font-weight:700; color:#0e9f57; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">Product does not contain waiver</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +$0.20M (+3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 3
    col: 4
    width: 4
    height: 4

  - name: r_waivers
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.billing_month, cci_product_revenue.waivers]
    filters:
      cci_product_revenue.period_flag: Current,Prior
    sorts: [cci_product_revenue.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_product_revenue.selected_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">WAIVERS</div>
        <div style="font-size:28px; font-weight:700; color:#d98200; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">Product contains waiver (negative)</div>
        <div style="font-size:11.5px; font-weight:600; color:#6b7794; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▼</span> -$0.01M (-3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 3
    col: 8
    width: 4
    height: 4

  - name: r_invoice_revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.billing_month, cci_product_revenue.invoice_revenue_m]
    filters:
      cci_product_revenue.period_flag: Current,Prior
    sorts: [cci_product_revenue.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_product_revenue.selected_month
      Billing Cycle: cci_product_revenue.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">INVOICE REVENUE</div>
        <div style="font-size:28px; font-weight:700; color:#5b3df5; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">Total Revenue - Waivers</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +$0.19M (+3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 3
    col: 12
    width: 4
    height: 4

  - name: r_projected
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.billing_month, cci_billing_cycle.projected_revenue]
    filters:
      cci_billing_cycle.period_flag: Current,Prior
    sorts: [cci_billing_cycle.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_billing_cycle.selected_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">PROJECTED REVENUE</div>
        <div style="font-size:28px; font-weight:700; color:#111a35; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">Cycle-consistent projected revenue</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +$0.19M (+3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 3
    col: 16
    width: 4
    height: 4

  - name: r_variance
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.billing_month, cci_billing_cycle.revenue_variance]
    filters:
      cci_billing_cycle.period_flag: Current,Prior
    sorts: [cci_billing_cycle.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_billing_cycle.selected_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">REVENUE VARIANCE</div>
        <div style="font-size:28px; font-weight:700; color:#d98200; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">Invoice - Projected shortfall</div>
        <div style="font-size:11.5px; font-weight:600; color:#d98200; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▼</span> -$0.32K <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 3
    col: 20
    width: 4
    height: 4

  # --- ROW 2: ACCOUNT BREAKDOWN KPIS ---

  - name: r_active
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.billing_month, cci_billing_cycle.active]
    filters:
      cci_billing_cycle.period_flag: Current,Prior
    sorts: [cci_billing_cycle.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_billing_cycle.selected_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">ACTIVE ACCOUNTS</div>
        <div style="font-size:28px; font-weight:700; color:#5b3df5; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">ACCOUNT_STATUS = ACTIVE</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +2,826 (+3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 7
    col: 0
    width: 6
    height: 4

  - name: r_susp
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.billing_month, cci_billing_cycle.susp_pending]
    filters:
      cci_billing_cycle.period_flag: Current,Prior
    sorts: [cci_billing_cycle.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_billing_cycle.selected_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">SUSPENDED / PENDING</div>
        <div style="font-size:28px; font-weight:700; color:#111a35; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">SUSPENDED + ACTIVE_PENDING</div>
        <div style="font-size:11.5px; font-weight:600; color:#6b7794; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +174 (+3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 7
    col: 6
    width: 6
    height: 4

  - name: r_elig
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.billing_month, cci_billing_cycle.eligible]
    filters:
      cci_billing_cycle.period_flag: Current,Prior
    sorts: [cci_billing_cycle.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_billing_cycle.selected_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">ELIGIBLE ACCOUNTS</div>
        <div style="font-size:28px; font-weight:700; color:#0e9f57; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">Active + Suspended / Pending</div>
        <div style="font-size:11.5px; font-weight:600; color:#0e9f57; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +3,000 (+3.1%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 7
    col: 12
    width: 6
    height: 4

  - name: r_term
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.billing_month, cci_billing_cycle.terminated]
    filters:
      cci_billing_cycle.period_flag: Current,Prior
    sorts: [cci_billing_cycle.billing_month desc]
    limit: 2
    listen:
      Billing Month: cci_billing_cycle.selected_month
      Billing Cycle: cci_billing_cycle.cycle
    show_single_value_title: false
    html: |
      <div style="background:#ffffff; border-radius:12px; padding:16px; border:1px solid #eef1f7; box-shadow:0 1px 3px rgba(17,26,53,0.06); font-family:'Segoe UI',sans-serif; height:100%; box-sizing:border-box; display:flex; flex-direction:column; justify-content:space-between;">
        <div style="font-size:11px; font-weight:700; color:#6b7794; letter-spacing:0.5px; text-transform:uppercase;">TERMINATED</div>
        <div style="font-size:28px; font-weight:700; color:#111a35; margin:4px 0;">{{ rendered_value }}</div>
        <div style="font-size:11px; color:#9aa6bd;">Not billing-eligible</div>
        <div style="font-size:11.5px; font-weight:600; color:#d98200; margin-top:6px; display:flex; align-items:center; gap:4px;">
          <span>▲</span> +77 (+11.8%) <span style="color:#6b7794; font-weight:400;">vs last month</span>
        </div>
      </div>
    row: 7
    col: 18
    width: 6
    height: 4

  # --- ROW 3 & 4: TABLES & GRIDS ---

  - name: r_mix
    title: Invoiced Revenue Mix
    type: looker_grid
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.revenue_type, cci_product_revenue.non_tax, cci_product_revenue.tax_amt, cci_product_revenue.total_invoiced]
    sorts: [cci_product_revenue.total_invoiced desc]
    filters:
      cci_product_revenue.period_flag: Current
    listen:
      Billing Month: cci_product_revenue.selected_month
      Billing Cycle: cci_product_revenue.cycle
    show_row_numbers: false
    show_view_names: false
    show_totals: true
    show_row_totals: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '11'
    rows_font_size: '13'
    size_to_fit: true
    truncate_text: false
    enable_conditional_formatting: false
    limit_displayed_rows: false
    series_labels:
      cci_product_revenue.revenue_type: Component
      cci_product_revenue.non_tax: Non-Tax Amount
      cci_product_revenue.tax_amt: Tax Amount
      cci_product_revenue.total_invoiced: Total Invoiced
    series_text_format:
      cci_product_revenue.non_tax:
        align: right
      cci_product_revenue.tax_amt:
        align: right
      cci_product_revenue.total_invoiced:
        align: right
    row: 11
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
    filters:
      cci_state_revenue.period_flag: Current
    listen:
      Billing Month: cci_state_revenue.selected_month
      Billing Cycle: cci_state_revenue.cycle
    show_row_numbers: false
    show_view_names: false
    show_totals: true
    show_row_totals: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '11'
    rows_font_size: '13'
    size_to_fit: true
    truncate_text: false
    enable_conditional_formatting: false
    limit_displayed_rows: false
    series_labels:
      cci_state_revenue.state: State
      cci_state_revenue.revenue: Revenue
      cci_state_revenue.tax_amt: Tax Amount
    series_text_format:
      cci_state_revenue.revenue:
        align: right
      cci_state_revenue.tax_amt:
        align: right
    series_cell_visualizations:
      cci_state_revenue.revenue:
        is_active: true
        palette:
          palette_id: custom
          collection_id: legacy
          custom_colors: ["#5b3df5", "#8b5cf6"]
    row: 11
    col: 12
    width: 12
    height: 7

  - name: r_product
    title: Product Revenue Summary
    type: looker_grid
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.product, cci_product_revenue.revenue_type, cci_product_revenue.line_items, cci_product_revenue.qty, cci_product_revenue.non_tax, cci_product_revenue.tax_amt, cci_product_revenue.total_invoiced]
    sorts: [cci_product_revenue.total_invoiced desc]
    filters:
      cci_product_revenue.period_flag: Current
    listen:
      Billing Month: cci_product_revenue.selected_month
      Billing Cycle: cci_product_revenue.cycle
    show_row_numbers: false
    show_view_names: false
    show_totals: true
    show_row_totals: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '11'
    rows_font_size: '13'
    size_to_fit: true
    truncate_text: false
    enable_conditional_formatting: false
    limit_displayed_rows: false
    series_labels:
      cci_product_revenue.product: Product Name
      cci_product_revenue.revenue_type: Revenue Type
      cci_product_revenue.line_items: Line Item Count
      cci_product_revenue.qty: Total Quantity
      cci_product_revenue.non_tax: Non-Tax Amount
      cci_product_revenue.tax_amt: Tax Amount
      cci_product_revenue.total_invoiced: Total Invoiced
    series_text_format:
      cci_product_revenue.line_items:
        align: right
      cci_product_revenue.qty:
        align: right
      cci_product_revenue.non_tax:
        align: right
      cci_product_revenue.tax_amt:
        align: right
      cci_product_revenue.total_invoiced:
        align: right
    row: 18
    col: 0
    width: 24
    height: 9

  - name: r_footnote
    type: text
    title_text: ''
    body_text: |
      <div style="background:#ffffff; border-radius:8px; padding:12px 16px; border:1px solid #eef1f7; font-family:'Segoe UI',sans-serif; font-size:12px; color:#6b7794;">
        <b>Calculation Note:</b> Source data derived from billing engine. Suspended and ACTIVE_PENDING are included in eligible accounts. "All Cycles" reflects total aggregate across Cycle 1, Cycle 2, and Cycle 3.
      </div>
    row: 27
    col: 0
    width: 24
    height: 2
