explore: pdt_sort_category {}
view: pdt_sort_category {
  derived_table: {
    persist_for: "24 hours"
    indexes: ["category"]
    sql:
        SELECT
          category.name AS category,
          SUM(payment.amount) AS total_payment,
          RANK() OVER(ORDER BY SUM(payment.amount) DESC) AS RNK
        FROM payment
        LEFT JOIN rental ON payment.rental_id = rental.rental_id
        LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
        LEFT JOIN film ON inventory.film_id = film.film_id
        LEFT JOIN film_category ON film.film_id = film_category.film_id
        LEFT JOIN category ON film_category.category_id = category.category_id
        WHERE {% condition category_filter %} category.name {% endcondition %}
        GROUP BY 1
    ;;
  }

  filter: category_filter {
    type: string
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: total_payment {
    type: number
    sql: ${TABLE}.total_payment ;;
  }

  dimension: rnk {
    type: number
    sql: ${TABLE}.rnk ;;
  }

  dimension: ranked_category {
    type: string
    sql:
        CASE
            WHEN ${rnk} < 10 THEN '0' || ${rnk} || ') ' || ${category}
            ELSE ${rnk} || ') ' || ${category}
        END
    ;;
  }
}
