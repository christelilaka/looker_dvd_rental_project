
view: 5_pdt_top_customer {
  derived_table: {
    sql:
        SELECT * FROM

            (SELECT
                payment."customer_id"  AS "customer_id",
                SUM(payment."amount") AS "total_payment",
                COUNT(payment."payment_id") AS "count_payment",
              CASE WHEN {{top_customber_based_on._parameter_value}} = 10 THEN
                DENSE_RANK() OVER (ORDER BY SUM(payment.amount) DESC) ELSE
              DENSE_RANK() OVER (ORDER BY COUNT(payment.payment_id) DESC) END
            FROM public.payment  AS payment
            GROUP BY 1) myTable

        WHERE DENSE_RANK <= {{ top_customer._parameter_value }}
    ;;
  }

  parameter: top_customer {
    type: number
  }

  parameter: top_customber_based_on {
    type: number
    allowed_value: {
      label: "Total Payment Amount"
      value: "10"
    }
    allowed_value: {
      label: "Number of payment"
      value: "20"
    }
  }

  dimension: customer_id {}
  dimension: total_payment {}
  dimension: count_payment {}
  dimension: rank {
    type: number
    sql: ${TABLE}.DENSE_RANK ;;
  }

  measure: numember_of_payment {
    type: sum
    sql: ${count_payment} ;;
  }

  measure: sum_payment {
    type: sum
    sql: ${total_payment} ;;
  }

  measure: dynamic {
    label_from_parameter: top_customber_based_on
    type: sum
    sql:
        {% if top_customber_based_on._parameter_value == 10 %}
        ${total_payment}
        {% else %}
        ${count_payment}
        {% endif %}
    ;;
  }
}
