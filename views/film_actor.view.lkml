view: film_actor {
  sql_table_name: public.film_actor ;;

  dimension: actor_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: film_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."film_id" ;;
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

  measure: count {
    type: count
    drill_fields: [film.film_id, actor.actor_id, actor.last_name, actor.first_name]
  }
}
