# link_tiles_marker
- dashboard: cci_revenue_report
  title: Revenue Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: false
  filters_location_top: true
  embed_style:
    background_color: "#f5f7fb"
    show_title: true
    title_color: "#111a35"
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
    field: cci_billing_cycle.billing_month
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
    title_hidden: true
    show_single_value_title: true
    single_value_title: TOTAL INVOICES
    value_format: '#,##0'
    custom_color_enabled: true
    custom_color: "#5b3df5"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "COUNT(DISTINCT BILL_NO)"
    row: 2
    col: 0
    width: 4
    height: 4

  - name: r_total_revenue
    title: Total Revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.total_revenue]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    title_hidden: true
    show_single_value_title: true
    single_value_title: TOTAL REVENUE
    value_format: '$0.00,,"M"'
    custom_color_enabled: true
    custom_color: "#0e9f57"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "Product does not contain waiver"
    row: 2
    col: 4
    width: 4
    height: 4

  - name: r_waivers
    title: Waivers
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.waivers]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    title_hidden: true
    show_single_value_title: true
    single_value_title: WAIVERS
    value_format: '$0.00,,"M"'
    custom_color_enabled: true
    custom_color: "#d98200"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "Product contains waiver (negative)"
    row: 2
    col: 8
    width: 4
    height: 4

  - name: r_invoice_revenue
    title: Invoice Revenue
    type: single_value
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.invoice_revenue_m]
    listen:
      Billing Month: cci_product_revenue.billing_month
      Billing Cycle: cci_product_revenue.cycle
    title_hidden: true
    show_single_value_title: true
    single_value_title: INVOICE REVENUE
    value_format: '$0.00,,"M"'
    custom_color_enabled: true
    custom_color: "#5b3df5"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "Total Revenue - Waivers"
    row: 2
    col: 12
    width: 4
    height: 4

  - name: r_projected
    title: Projected Revenue
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.projected_revenue]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    title_hidden: true
    show_single_value_title: true
    single_value_title: PROJECTED REVENUE
    value_format: '$0.00,,"M"'
    custom_color_enabled: true
    custom_color: "#111a35"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "Cycle-consistent projected revenue across eligible accounts"
    row: 2
    col: 16
    width: 4
    height: 4

  - name: r_variance
    title: Revenue Variance
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.revenue_variance]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    title_hidden: true
    show_single_value_title: true
    single_value_title: REVENUE VARIANCE
    value_format: '$0.00,"K"'
    custom_color_enabled: true
    custom_color: "#d98200"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "Invoice - Projected (negative = shortfall)"
    row: 2
    col: 20
    width: 4
    height: 4

  - name: r_active
    title: Active Accounts
    type: single_value
    model: cci_billing_health
    explore: cci_billing_cycle
    fields: [cci_billing_cycle.active]
    listen:
      Billing Month: cci_billing_cycle.billing_month
      Billing Cycle: cci_billing_cycle.cycle
    title_hidden: true
    show_single_value_title: true
    single_value_title: ACTIVE ACCOUNTS
    value_format: '#,##0'
    custom_color_enabled: true
    custom_color: "#5b3df5"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "ACCOUNT_STATUS = ACTIVE"
    row: 6
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
    title_hidden: true
    show_single_value_title: true
    single_value_title: SUSPENDED / PENDING
    value_format: '#,##0'
    custom_color_enabled: true
    custom_color: "#111a35"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "SUSPENDED + ACTIVE_PENDING — billing-eligible"
    row: 6
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
    title_hidden: true
    show_single_value_title: true
    single_value_title: ELIGIBLE ACCOUNTS
    value_format: '#,##0'
    custom_color_enabled: true
    custom_color: "#0e9f57"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "Active + Suspended / Pending"
    row: 6
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
    title_hidden: true
    show_single_value_title: true
    single_value_title: TERMINATED
    value_format: '#,##0'
    custom_color_enabled: true
    custom_color: "#111a35"
    enable_conditional_formatting: false
    show_view_names: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: vs last month
    comparison_starts_with_normal: true
    note_state: expanded
    note_display: below
    note_text: "Not billing-eligible"
    row: 6
    col: 18
    width: 6
    height: 3

  - name: r_mix
    title: Invoiced Revenue Mix
    type: looker_grid
    model: cci_billing_health
    explore: cci_product_revenue
    fields: [cci_product_revenue.revenue_type, cci_product_revenue.non_tax, cci_product_revenue.tax_amt, cci_product_revenue.total_invoiced]
    sorts: [cci_product_revenue.total_invoiced desc]
    listen:
      Billing Month: cci_product_revenue.billing_month
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
    sorts: [cci_product_revenue.total_invoiced desc]
    listen:
      Billing Month: cci_product_revenue.billing_month
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
    row: 15
    col: 0
    width: 24
    height: 9

  - name: r_footnote
    type: text
    title_text: ''
    body_text: '<div style="font:12px Segoe UI,Arial,sans-serif;color:#6b7794">Calculation source: same billing engine as Billing Dashboard. Suspended and ACTIVE_PENDING are included in eligible accounts. "All Cycles" is the sum of Cycle 1 + Cycle 2 + Cycle 3.</div>'
    row: 24
    col: 0
    width: 24
    height: 2
