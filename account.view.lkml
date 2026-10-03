view: account {
  derived_table: {
    sql: SELECT
            A.ACCOUNTID,
            A.CA_NUMBER,
            A.BA_NUMBER,
            A.SI_NUMBER,
            A.CURRENTPLAN,
            A.ID_TYPE,
            A.NUMBER_PORT_TYPE,
            A.CURRENTPLAN_NAME,
            A.ACCOUNT_STATUS,
            A.PORTING_DONOR,
            A.MSISDN,
            A.PORTOUT_TELCO,
            A.OWN_REFERRAL_CODE,
            A.TERMINATION_DATE,
            A.LAST_REACTIVATION_DATE
          FROM LEGACY.ACCOUNT A ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: accountid {
    type: string
    sql: ${TABLE}.ACCOUNTID ;;
  }

  dimension: ca_number {
    type: string
    sql: ${TABLE}.CA_NUMBER ;;
  }

  dimension: ba_number {
    type: string
    sql: ${TABLE}.BA_NUMBER ;;
  }

  dimension: si_number {
    type: string
    sql: ${TABLE}.SI_NUMBER ;;
  }

  dimension: currentplan {
    type: string
    sql: ${TABLE}.CURRENTPLAN ;;
  }

  dimension: id_type {
    type: string
    sql: ${TABLE}.ID_TYPE ;;
  }

  dimension: number_port_type {
    type: string
    sql: ${TABLE}.NUMBER_PORT_TYPE ;;
  }

  dimension: currentplan_name {
    type: string
    sql: ${TABLE}.CURRENTPLAN_NAME ;;
  }

  dimension: account_status {
    type: string
    sql: ${TABLE}.ACCOUNT_STATUS ;;
  }

  dimension: porting_donor {
    type: string
    sql: ${TABLE}.PORTING_DONOR ;;
  }

  dimension: msisdn {
    type: string
    sql: ${TABLE}.MSISDN ;;
  }

  dimension: portout_telco {
    type: string
    sql: ${TABLE}.PORTOUT_TELCO ;;
  }

  dimension: own_referral_code {
    type: string
    sql: ${TABLE}.OWN_REFERRAL_CODE ;;
  }

  dimension_group: termination_date {
    type: time
    sql: ${TABLE}.TERMINATION_DATE ;;
  }

  dimension_group: last_reactivation_date {
    type: time
    sql: ${TABLE}.LAST_REACTIVATION_DATE ;;
  }

  set: detail {
    fields: [
      accountid,
      ca_number,
      ba_number,
      si_number,
      currentplan,
      id_type,
      number_port_type,
      currentplan_name,
      account_status,
      porting_donor,
      msisdn,
      portout_telco,
      own_referral_code,
      termination_date_time,
      last_reactivation_date_time
    ]
  }
}
