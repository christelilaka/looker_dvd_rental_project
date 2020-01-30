view: film {
  sql_table_name: public.film ;;
  drill_fields: [film_id]

  # Test customers -------------

  dimension: was_film_rented {
    type: yesno
    sql: ${film_id} IN (SELECT film_id FROM inventory AS i
      LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id
      WHERE {% condition rented_date %} r.rental_date {% endcondition %});;
  }

  dimension: was_lenght_more_than_120min {
    type: yesno
    sql: ${length}>120 ;;
  }

  dimension: was_cost_less_than_15 {
    type: yesno
    sql: ${replacement_cost}<15 ;;
  }


  filter: rented_date {
    type: date
  }

  measure: count_film_dist {
    type: count_distinct
    sql: ${film_id} in (133, 384, 98, 213, 10) ;;
  }

#   dimension: film_not_rented {
#     type: string
#     sql: CASE WHEN ${was_film_rented} THEN ${title} ELSE '' END;;
#   }

  dimension: film_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."film_id" ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}."description" ;;
  }

  dimension: fulltext {
    type: string
    sql: ${TABLE}."fulltext" ;;
  }

  dimension: language_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."language_id" ;;
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

  dimension: length {
    type: number
    sql: ${TABLE}."length" ;;
  }

  dimension: rating {
    type: string
    sql: ${TABLE}."rating" ;;
  }

  dimension: release_year {
    type: number
    sql: ${TABLE}."release_year" ;;
  }

  dimension: rental_duration {
    type: number
    sql: ${TABLE}."rental_duration" ;;
  }

  dimension: rental_rate {
    type: number
    sql: ${TABLE}."rental_rate" ;;
  }

  dimension: replacement_cost {
    type: number
    sql: ${TABLE}."replacement_cost" ;;
  }

  dimension: special_features {
    type: string
    sql: ${TABLE}."special_features" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}."title" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      film_id,
      language.language_id,
      language.name,
      film_actor.count,
      film_category.count,
      inventory.count
    ]
  }
}
