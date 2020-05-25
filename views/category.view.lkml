view: category {
  sql_table_name: public.category ;;
  drill_fields: [category_id]

  dimension: category_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."category_id" ;;
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

  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }

  #----- Filter Name for LookML Dashboard --- May 25------------
  parameter: select_category_name {
    type: string
    allowed_value: {label: "All" value:"All"}
    allowed_value: {label: "Sports" value:"Sports"}
    allowed_value: {label: "Action" value:"Action"}
  }

  #--------------------------------------------------------------

  filter: filtered_category {
    type: string
  }

  dimension: selected_category {
    type: yesno
    sql:{% condition filtered_category %} ${name} {% endcondition %};;
  }

  measure: list_name {
    type: list
    list_field: name
  }

  measure: count {
    type: count
    drill_fields: [category_id, name, film_category.count]
  }
}
