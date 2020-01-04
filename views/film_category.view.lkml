view: film_category {
  sql_table_name: public.film_category ;;

  dimension: category_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."category_id" ;;
  }

  dimension: film_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."film_id" ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [
      raw
    ]
    sql: ${TABLE}."last_update" ;;
  }

  measure: count {
    type: count
    drill_fields: [category.name, category.category_id, film.film_id]
  }
}
