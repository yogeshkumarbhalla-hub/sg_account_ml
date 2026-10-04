- dashboard: revenue_dashboard
  title: Revenue Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "September 2026 (202609)"
  elements:
  - name: nav
    type: text
    title_text: ""
    body_text: '<a href="/dashboards/billing::revenue_dashboard">Revenue</a> | <a href="/dashboards/billing::billing_dashboard">Billing</a>'
    row: 0
    col: 0
    width: 24
    height: 2
  - name: projected_revenue
    title: Projected Revenue (Avg Invoice × Eligible Accounts)
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [bills_v3.projected_revenue]
    row: 2
    col: 0
    width: 6
    height: 4
  - name: invoiced_revenue
    title: Invoiced Revenue
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [bills_v3.invoiced_revenue]
    row: 2
    col: 6
    width: 6
    height: 4
  - name: revenue_variance
    title: Revenue Variance (Invoiced − Projected)
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [bills_v3.revenue_variance]
    row: 2
    col: 12
    width: 6
    height: 4
  - name: avg_invoice_value
    title: Average Invoice Value
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [bills_v3.avg_invoice_value]
    row: 2
    col: 18
    width: 6
    height: 4
  - name: revenue_mix
    title: Invoiced Revenue Mix (Non-Tax by Type, % Share)
    model: billing
    explore: revenue_billing
    type: looker_grid
    fields: [bills_v3.revenue_type, bills_v3.nontax_amount]
    filters:
      bills_v3.revenue_type: "-NULL"
    sorts: [bills_v3.nontax_amount desc]
    table_calculations:
    - table_calculation: share
      label: Share
      expression: "${bills_v3.nontax_amount} / sum(${bills_v3.nontax_amount})"
      value_format_name: percent_1
      _kind_hint: measure
      _type_hint: number
    show_totals: true
    row: 6
    col: 0
    width: 12
    height: 7
  - name: taxes
    title: Taxes & Fees
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [bills_v3.tax_amount]
    row: 6
    col: 12
    width: 6
    height: 3
  - name: jurisdictional
    type: text
    title_text: Jurisdictional Breakdown
    body_text: "N/A – MISSING: STATE / ADDRESS"
    row: 6
    col: 18
    width: 6
    height: 3
  - name: product_summary
    title: Product Revenue Summary
    model: billing
    explore: revenue_billing
    type: looker_grid
    fields: [bills_v3.product, bills_v3.revenue_type, bills_v3.total_line_items, bills_v3.total_quantity, bills_v3.nontax_amount, bills_v3.tax_amount, bills_v3.invoiced_revenue]
    filters:
      bills_v3.product: "-NULL"
    sorts: [bills_v3.invoiced_revenue desc]
    show_totals: true
    row: 13
    col: 0
    width: 24
    height: 9
