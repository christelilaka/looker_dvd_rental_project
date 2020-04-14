view: rental {
  sql_table_name: public.rental ;;
  drill_fields: [rental_id]

  parameter: namesearch {
    type: string
    suggest_explore: customer
    suggest_dimension: customer.full_name_and_id
    suggest_persist_for: "24 hours"
  }

  dimension: filtered_name {
    type: yesno
    sql:
        {% assign my_array = namesearch._parameter_value | remove: "'" | split: "-"  %}
        {% assign the_id = my_array[0] %}
        ${customer_id} = {{the_id}}
    ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."customer_id" ;;
  }

  filter: date_try {
    type: date_time
  }

  dimension: rental_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."rental_id" ;;
  }



  #==== Danielle's Chat review=======

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
      week_of_year,
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

  dimension: min_date_test {
    type:  string
    sql:  MIN(rental_date);;
  }

  measure: min_rental_date {
    type: string
    sql: MIN(${TABLE}."rental_date") ;;
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




  measure: count_without_drill {
    type: count
  }

  measure: count {
    type: count
    drill_fields: [short*]
  link: {label: "Drill with HTML" url:"{{link}}&f[staff.staff_id]=not+1&sorts=category.name+asc"}
    html:
    {% if value >= 6000 %}
        <div style="background-color: #0b9353;color: white;font-size:100%; text-align:center"><a href="#drillmenu" target="_self">{{ rendered_value }}</a> </div>
    {% elsif 1500 <= value < 6000 %}
        <div style="background-color: #ede979;color: black;font-size:100%; text-align:center"><a href="#drillmenu" target="_self">{{ rendered_value }}</a> </div>
    {% elsif value < 1500 %}
        <div style="background-color: #ff9f80;color: black;font-size:100%; text-align:center"><a href="#drillmenu" target="_self">{{ rendered_value }}</a> </div>
    {% endif %} ;;

  }

  # --- Set test ----
  set: short {
    fields: [rental_date, category.name, payment.regular_sum, count_without_drill]
  }




# ---- Test March 15 (ticker: #288379) -----

  parameter: select_aggregation {
    type: string
    allowed_value: {value: "count" label: "count" }
    allowed_value: {value: "count_plus_ten" label: "Count plus 10"}
  }

  measure: count_plus_ten {
    type: number
    sql: ${count}+10 ;;
  }


  measure: final_aggregation {
    type: number
    sql:
        {% if select_aggregation._parameter_value == "'count'" %}
          ${count}*1
        {% elsif select_aggregation._parameter_value == "'count_plus_ten'" %}
          ${count_plus_ten}*1
        {% else %}
          ${count}*0
        {% endif %}
    ;;
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
