view: customer {
  sql_table_name: public.customer ;;
  drill_fields: [customer_id]

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."customer_id" ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}."active" ;;
  }

  dimension: activebool {
    type: yesno
    sql: ${TABLE}."activebool" ;;
  }

  dimension: address_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."address_id" ;;
  }

  dimension_group: create {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."create_date" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."email" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."last_update" ;;
  }

  dimension: store_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."store_id" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      customer_id,
      last_name,
      first_name,
      address.address_id,
      store.store_id,
      payment.count,
      rental.count
    ]
  }
}
