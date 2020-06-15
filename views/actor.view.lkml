
view: actor {
  sql_table_name: public.actor;;
  #drill_fields: [actor_id]

  dimension: actor_id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: first_name {
    #label: "{% if _view._name == 'actor' %} First Name {% else %} First Name {% endif %}"
    type: string
    sql: ${TABLE}."first_name" ;;
    link: {
      label: "To the dashboard"
      url: "https://self-signed.looker.com:9999/dashboards/10"
    }
  }

  dimension: last_name {
    label: "{% if _view._name == 'actor' %} Last Name {% else %} Person Last Name {% endif %}"
    type: string
    sql: ${TABLE}."last_name" ;;
  }


  dimension: name_label {
    hidden: yes
    type: string
    sql: CASE
              WHEN ${last_name} = 'Akroyd' THEN ' Label with space'
              ELSE ${last_name}
          END
    ;;
  }

  dimension: is_fName_in_last_name {
    hidden: yes
    type: yesno
    sql: ${first_name} IN (SELECT ${last_name} FROM ${TABLE}) ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [raw, time,  date, week, month, quarter, year]
    sql: ${TABLE}."last_update" ;;
  }

  measure: count {
    type: count
    drill_fields: [actor_id, last_name, first_name, actor_info.count, film_actor.count]
    link: {label: "Drill down" url:"{{link}}&f[actor.last_name]=Pesci,Paltrow"}
  }


#--------- Liquid in filters ----------
parameter: name_to_count {
  hidden: yes
  type: unquoted
  allowed_value: {label: "Dan" value: "Dan"}
}

measure: count_names {
  hidden: yes
  type: count
  #filters: [first_name: "{{name_to_count._parameter_value}}"]
  filters: [first_name: "{% parameter name_to_count %}"]
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
