explore: pdt_customer_test {}

view: pdt_customer_test {
  derived_table: {
    sql:
        (SELECT
            CASE WHEN (film."length")>120  THEN 'Was lenght more than 120 min' ELSE null END AS "data",
            COUNT(*) AS "count_yes",
            (SELECT COUNT(*) FROM public.film WHERE film."length"<120) AS "count_no"
          FROM public.film  AS film
          WHERE (CASE WHEN (film."length")>120  THEN 'count_yes' ELSE null END) IS NOT NULL
          GROUP BY 1)
      UNION
        (SELECT
            CASE WHEN (film."replacement_cost")<15  THEN 'Is replacement cost less than $15M' ELSE NULL END AS "data",
            COUNT(*) AS "count_yes",
            (SELECT COUNT(*) FROM public.film WHERE film."replacement_cost">15) AS "count_no"
          FROM public.film  AS film
          WHERE (CASE WHEN (film."replacement_cost")<15  THEN 'count_yes' ELSE NULL END) IS NOT NULL
          GROUP BY 1) ;;
  }

  dimension: data {sql: ${TABLE}.data ;; }
  dimension: count_yes {label: "YES"  sql: ${TABLE}.count_yes ;; }
  dimension: count_no {label: "NO"    sql: ${TABLE}.count_no ;; }
}
