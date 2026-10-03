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
  }
}
