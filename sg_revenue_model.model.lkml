connection: "snowflake_sg"

# Include all view files regardless of subfolder location
include: "/**/*.view.lkml"

datagroup: sg_revenue_model_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: sg_revenue_model_default_datagroup

explore: bills_v3 {
  label: "Revenue & Billing Analysis"

  join: account {
    type: left_outer
    relationship: many_to_one
    sql_on: \({bills_v3.accountid} =\){account.accountid}
      AND \({bills_v3.si_number} =\){account.si_number}
      AND \({bills_v3.ba_number} =\){account.ba_number} ;;
  }
}
