view: actor {
  sql_table_name: public.actor ;;
  drill_fields: [actor_id]

  dimension: actor_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
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
    drill_fields: [actor_id, last_name, first_name, actor_info.count, film_actor.count]
  }
}
