view: a_orders_w_dates {
  sql_table_name: public.a_orders_w_dates ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }

  dimension: amount {
    type: string
    sql: ${TABLE}."amount" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }

  dimension_group: order {
    type: time
    timeframes: [raw,date, day_of_week,month_name, week,month,quarter,year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."order_date" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name]
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
  }
}
