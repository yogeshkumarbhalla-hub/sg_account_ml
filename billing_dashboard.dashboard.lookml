- dashboard: billing_dashboard
  title: Billing Dashboard
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
  - name: generation_rate
    title: Invoice Generation Rate
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [bills_v3.generation_rate]
    row: 2
    col: 0
    width: 6
    height: 4
  - name: accuracy
    type: text
    title_text: Invoice Accuracy Rate
    body_text: "N/A – MISSING: EXPECTED_AMOUNT"
    row: 2
    col: 6
    width: 6
    height: 4
  - name: ungenerated_count
    title: Ungenerated Accounts
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [account.ungenerated_accounts]
    row: 2
    col: 12
    width: 6
    height: 4
  - name: duration
    type: text
    title_text: Bill Run Duration
    body_text: "N/A – MISSING: RUN_TIMESTAMPS"
    row: 2
    col: 18
    width: 6
    height: 4
  - name: user_base
    title: User Base
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [account.user_base]
    row: 6
    col: 0
    width: 6
    height: 3
  - name: active
    title: Active Accounts
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [account.active_accounts]
    row: 6
    col: 6
    width: 6
    height: 3
  - name: susp_pend
    title: Suspended / Pending
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [account.suspended_pending_accounts]
    row: 6
    col: 12
    width: 6
    height: 3
  - name: terminated
    title: Terminated (Total)
    model: billing
    explore: revenue_billing
    type: single_value
    fields: [account.terminated_accounts]
    row: 6
    col: 18
    width: 6
    height: 3
  - name: acceptance
    title: Acceptance Metrics (AC 2.4-01 Generation)
    model: billing
    explore: revenue_billing
    type: looker_grid
    fields: [bills_v3.generated_eligible, account.eligible_accounts, bills_v3.generation_rate]
    row: 9
    col: 0
    width: 14
    height: 4
  - name: materiality
    type: text
    title_text: Failure Materiality
    body_text: "N/A – Sub-cent delta bands require baseline EXPECTED_AMOUNT (missing column). Accuracy (AC 2.4-02): DISABLED."
    row: 9
    col: 14
    width: 10
    height: 4
  - name: ungenerated_table
    title: Ungenerated Accounts (BILL_NO IS NULL)
    model: billing
    explore: revenue_billing
    type: looker_grid
    fields: [account.accountid, account.si_number, account.currentplan_name, account.account_status, account.number_port_type, account.porting_donor]
    filters:
      bills_v3.bill_no: "NULL"
      account.is_eligible: "Yes"
    limit: 500
    row: 13
    col: 0
    width: 24
    height: 9
