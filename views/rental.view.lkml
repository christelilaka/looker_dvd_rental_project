view: rental {
  sql_table_name: public.rental ;;
  drill_fields: [rental_id]

  dimension: rental_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."rental_id" ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."customer_id" ;;
  }

  dimension: inventory_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."inventory_id" ;;
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

  dimension_group: rental {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}."rental_date" ;;
  }

  dimension_group: return {
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
    sql: ${TABLE}."return_date" ;;
  }

  dimension: staff_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."staff_id" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      rental_id,
      inventory.inventory_id,
      staff.first_name,
      staff.staff_id,
      staff.username,
      staff.last_name,
      customer.last_name,
      customer.first_name,
      customer.customer_id,
      payment.count
    ]
  }
}
