view: payment {
  sql_table_name: public.payment ;;
  drill_fields: [payment_id]

  dimension: payment_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."payment_id" ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}."amount" ;;
  }

  dimension: average {
    type: number
    sql: round(avg(${amount}) over(PARTITION BY ${customer_id} ORDER BY ${payment_date} ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING), 2)
    ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."customer_id" ;;
  }

  filter: select_date {
    type: date_time
  }

  dimension: rental_date {
    type: date
    sql: rental.last_update_date ;;
  }

  dimension: is_okayDate {
    type: yesno
    sql: {% condition select_date %} ${payment_date} {% endcondition %};;}


  dimension_group: try {
    type: duration
    sql_start: ${rental.last_update_date} ;;
  sql_end: ${payment_date} ;;
  intervals: [day, hour, minute]
  }

  measure: total_durat {
    type: sum
    sql: ${days_try} ;;
  }

  measure: average_dur {
    type: number
    sql: ${total_durat}/NULLIF(${count},0) ;;
  }


  dimension_group: payment {
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
    sql: ${TABLE}."payment_date" ;;
  }

  dimension: date_sting {
    type: string
    sql: TO_CHAR(${payment_date}, 'YYYY-MM-DD') ;;
  }

  dimension: rental_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."rental_id" ;;
  }

  dimension: staff_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."staff_id" ;;
  }

  measure: count {
    type: count
    drill_fields: [payment_date, count]
    link: {
      label: "Drill into an Area Chart"
      url: "{% assign vis_config = '{\"type\": \"looker_area\", \"interpolation\": \"monotone\",
      \"series_colors\": { \"payment.count\": \"#576574\"} }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  # ---- Test March 15 (ticker: #288379) -----

#   parameter: select_aggregation {
#     type: string
#     allowed_value: {value: "count" label: "count" }
#     allowed_value: {value: "count_plus_ten" label: "Count plus 10"}
#   }
#
#   measure: count_plus_ten {
#     type: number
#     sql: ${count}+10 ;;
#   }
#
#   measure: final_aggregation {
#     type: number
#     sql:
#         CASE
#         WHEN {% parameter rental.select_aggregation %} = 'count' THEN
#           ${count}*1
#           WHEN {% parameter rental.select_aggregation %} = 'count_plus_ten' THEN
#           ${count_plus_ten}*1
#         ELSE
#           ${count}*0
#         END
#     ;;
#   }
#
#   dimension: help_select {
#     type: string
#     sql: {% parameter select_aggregation %};;
#   }



  # ---- Test Jan 11 ===


  measure: is_total_less {
    type: yesno
    sql: ${total_amount} < 4 ;;
    html: {% if value == "Yes" %}
            <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
          {% else %}
            <p style="color: black; background-color: #d63031; font-size:100%; text-align:center">{{ rendered_value }}</p>
          {% endif %}
    ;;
  }


  # ---- End Test ------

  measure: total_amount {
    value_format_name: "eur"
    type: sum
    sql: ${amount} ;;
    drill_fields: [payment_date, amount]
    link: {
      label: "Drill into an Area Chart"
      url: "{% assign vis_config = '{\"type\": \"looker_area\", \"interpolation\": \"monotone\",
      \"series_colors\": { \"payment.payment_date\": \"#576574\"} }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
      icon_url: "https://looker.com/favicon.ico"
    }
    link: {
      label: "New explore"
      url: "https://self-signed.looker.com:9999/looks/24?f[payment.payment_month_name] = { _filters['payment.payment_month_name'] | url_encode }}"
    }
  }


  measure: regular_sum {
    drill_fields: [rental_id, regular_sum]
    type: sum
    sql: ${amount} ;;
    link: {label: "Drill" url:"{{link}}&f[payment.regular_sum]=%3E6"}
  }

  measure: type_number_sum {
    type: number
    sql: SUM(${amount}) ;;
  }

  measure: coalese_sum {
    type: number
    sql: SUM(Coalesce(${amount},0)) ;;
  }

  #----- BOX PLOT VIZ ---------
  measure: min {
    group_label: "Box Plot Viz"
    type: min
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: 25th_percentile {
    group_label: "Box Plot Viz"
    type: percentile
    percentile: 25
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: median {
    group_label: "Box Plot Viz"
    type: median
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: 75th_percentile {
    group_label: "Box Plot Viz"
    type: percentile
    percentile: 75
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: max {
    group_label: "Box Plot Viz"
    type: max
    sql: ${amount} ;;
    value_format_name: usd
  }

  # --- Feb 18 ----------
  measure: running_payment_total_row {
    type: running_total
    sql: ${amount} ;;
    direction: "row"
  }

  measure: running_payment_total_column {
    type: running_total
    sql: ${amount} ;;
    direction: "column"
  }

  # --------- Apr 1, 2020 -----------
  dimension: is_amount_less_4 {
    type: yesno
    sql: ${amount} < 4 ;;
  }

  dimension: is_amount_great_8 {
    type: yesno
    sql: ${amount}>8 ;;
  }

  dimension: amount_combined {
    type: string
    sql:
        CASE WHEN ${is_amount_less_4} THEN 'Less Than 4'
        WHEN ${is_amount_great_8} THEN 'Greater than 8'
        ELSE 'Between 4 and 8 included' END
    ;;
  }



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      payment_id,
      rental.rental_id,
      customer.last_name,
      customer.first_name,
      customer.customer_id,
      staff.first_name,
      staff.staff_id,
      staff.username,
      staff.last_name
    ]
  }
}
