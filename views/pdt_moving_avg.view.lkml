view: pdt_moving_avg {
  derived_table: {
    persist_for: "2 hours"
    indexes: ["customer_id"]
    sql:
        SELECT
              customer_id,
              amount,
              payment_date,
              round(avg(amount) over(order by payment_date ROWS BETWEEN CURRENT ROW AND 30 FOLLOWING),2) as overall_moving_avg,
              round(avg(amount) over(PARTITION BY customer_id ORDER BY payment_date ROWS BETWEEN CURRENT ROW AND 5 FOLLOWING),2) as moving_avg_by_customer
        FROM payment ;;
  }

  dimension_group: payment {
    type: time
    timeframes: [raw, date, month, month_name, year]
    sql: ${TABLE}.payment_date ;;
  }

  dimension: customer_id {
    type: number
    primary_key: yes
  }

  dimension: amount {
    type: number
  }

  dimension: overall_moving_avg {
    type: number
    sql: ${TABLE}.overall_moving_avg ;;
  }

  dimension: moving_avg_by_customer {
    type: number
    sql: ${TABLE}.moving_avg_by_customer ;;
  }

  measure: moving_avg_all {
    type: sum
    sql: ${overall_moving_avg} ;;
  }

  measure: customer_moving_avg {
    type: sum
    sql: ${moving_avg_by_customer} ;;
  }
}
