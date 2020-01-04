view: actor_info {
  sql_table_name: public.actor_info ;;

  dimension: actor_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: film_info {
    type: string
    sql: ${TABLE}."film_info" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }

  measure: count {
    type: count
    drill_fields: [last_name, first_name, actor.actor_id, actor.last_name, actor.first_name]
  }
}
