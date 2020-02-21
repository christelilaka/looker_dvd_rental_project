view: rental {
  sql_table_name: public.rental ;;
  drill_fields: [rental_id]

  filter: date_try {
    type: date_time
  }
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

  #==== Danielle's Chat review=======
  dimension: test_customer {
    type: yesno
    sql:
        (WITH table1 AS (SELECT ${customer_id} AS cust_id, COUNT(${customer_id}) AS count_dim
          FROM ${TABLE}
          GROUP BY ${customer_id}) SELECT count_dim FROM table1 WHERE ${customer_id} = table1.cust_id)=12 ;;
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
    #allow_fill: no
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
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


  dimension_group: duration_rental {
    type: duration
    intervals: [day, week]
    sql_start:  ${rental_date};;
    sql_end: ${return_date} ;;
  }

  measure: average_duration {
    type: average
    sql: ${days_duration_rental} ;;
  }

  measure: sum_duration {
    type: sum
    sql: ${days_duration_rental} ;;
  }

  dimension: staff_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."staff_id" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    #link: {label: "link url" url:"{{link}}&f[staff.staff_id]=not+1&sorts=customer.last_name+asc"}
  }

  #"{{ count_id._link}}&sorts=order_items.sale_price+desc" }


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
