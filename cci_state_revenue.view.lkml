view: cci_state_revenue {
  # ... existing dimensions and parameters ...

  # measure: revenue_share_bar {
  #   type: number
  #   sql: ${revenue} ;;
  #   html: |
  #     <div style="display: flex; align-items: center; justify-content: space-between; gap: 8px;">
  #       <span style="min-width: 45px; text-align: right;">{{ rendered_value }}</span>
  #       <div style="width: 100%; background: #eef1f7; border-radius: 5px; height: 10px;">
  #         <div style="height: 10px; border-radius: 5px; background: linear-gradient(90deg, #5b3df5, #8b5cf6); width: {{ value | times: 100 | round }}%;"></div>
  #       </div>
  #     </div> ;;
  # }
}
