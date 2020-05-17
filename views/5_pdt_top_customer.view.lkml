
view: 5_pdt_top_customer {
  derived_table: {
    sql:
        SELECT
              payment."customer_id"  AS "customer_id",
              SUM(payment."amount") AS "total_payment",
              COUNT(payment."payment_id") AS "count_payment",
              {% if top_n_customber_based_on._parameter_value == "'sum'" %}
                  DENSE_RANK() OVER (ORDER BY SUM(payment."amount") DESC)
              {% else %}
                  DENSE_RANK() OVER (ORDER BY COUNT(payment."payment_id") DESC)
              {% endif %}
        FROM public.payment  AS payment
        WHERE {% condition date_filter %} DATE(payment."payment_date" ) {% endcondition %}
        GROUP BY 1
    ;;
  }

  parameter: top_n {
    type: number
  }

  filter: date_filter{
    type: date
  }

  parameter: top_n_customber_based_on {
    type: string
    allowed_value: { label: "Sum Amount"  value: "sum"}
    allowed_value: { label: "Count payment"     value: "count"}
  }

  dimension: is_ranked {
    hidden: yes
    type: yesno
    sql: ${rank} <= {{top_n._parameter_value}} ;;
  }

  dimension: customer_id {}

  dimension: total_payment {}

  dimension: count_payment {}

  dimension: rank {
    type: number
    sql: ${TABLE}.DENSE_RANK ;;
  }

  measure: dynamic_measure {
    label_from_parameter: top_n_customber_based_on
    type: sum
    sql:
        {% if top_n_customber_based_on._parameter_value == "'sum'" %}
        ${total_payment}
        {% else %}
        ${count_payment}
        {% endif %};;
    html:
        {% if top_n_customber_based_on._parameter_value == "'sum'" %}
            &#36;{{value}}
        {% else %}
            {{value}}
        {% endif %};;
  }
}
