view: actor {
  sql_table_name: public.actor;;
  drill_fields: [actor_id]

  dimension: actor_id {
    #hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: first_name {
    label: "{% if _view._name == 'actor' %} first_name {% else %} Ninja_first_name {% endif %} "
    type: string
    sql: ${TABLE}."first_name" ;;
    link: {
      label: "To the dashboard"
      url: "https://self-signed.looker.com:9999/dashboards/10"
    }
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }

  dimension: is_fName_in_last_name {
    type: yesno
    sql: ${first_name} IN (SELECT ${last_name} FROM ${TABLE}) ;;
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
    link: {label: "Drill down" url:"{{link}}&f[actor.last_name]=Pesci,Paltrow"}
  }

  measure: count_2 {
    type: number
    value_format: "$#,##0"
    link: {label:"test" url:"{{link}}"}
    sql: 1 ;;

  }

  measure: total_labor_dollars {
    type: number
    value_format: "$#,##0"
    link: {label: "Test" url: "{{link}}"}
    sql: 1 ;;
#     link: {
#       label: "Total Labor by Punch Status"
#       url: "{{link}}&fields=restaurants.name,time_punches.total_open_labor_dollars,time_punches.total_closed_labor_dollars,time_punches.total_future_labor_dollars"
#     }
#     link: {label: "Total Sales by Channel & Order Type" url: "{{link}}&fields=restaurants.name"}
#     link:  {label: "Test" url: "{{link}}" }

  }



  measure: dataTest {
    hidden: yes
    type: number
    sql: ${count}/10 ;;
  }
}

# ---- Data Test ---

test: is_count_greater {
  explore_source: actor {
    column: count {
      field: actor.count
    }
    column: dataTest {field: actor.dataTest}
  }
  assert: count_is_expected {
    expression: ${actor.count} > ${actor.dataTest} ;;
  }
}
