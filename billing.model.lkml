connection: "snowflake_sg"   # <- set your connection name
include: "/**/*.view.lkml"
include: "/**/*.dashboard.lookml"

explore: revenue_billing {
  from: account
  view_name: account
  join: bills_v3 {
    type: left_outer
    relationship: one_to_many
    # Month filter lives in the join so accounts with no bill still appear (BILL_NO IS NULL). Change cycle here.
    sql_on: ${account.si_number} = ${bills_v3.si_number} AND ${bills_v3.bill_create_month} = '202609' ;;
  }
}
