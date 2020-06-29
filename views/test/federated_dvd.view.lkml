explore: federated_dvd {}

view: federated_dvd {
  sql_table_name: ecommerce.public.federated_ecom ;;

  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}."person_id" ;;
  }

  measure: count {
    type: count
    drill_fields: [first_name, last_name]
  }
}
