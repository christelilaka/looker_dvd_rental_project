view: 3_pdt {

  parameter: view_name {
    type: unquoted
    default_value: ""
  }
  derived_table: {
    sql_trigger_value: SELECT DATE_PART('minute', NOW()) ;;
    create_process: {
      sql_step:
        CREATE TABLE IF NOT EXISTS LOOKER_SCRATCH.{{ view_name._parameter_value }}
        (first_name VARCHAR (255));;
      sql_step: INSERT INTO LOOKER_SCRATCH.{{ view_name._parameter_value }} (first_name)
                VALUES ("Christel Ilaka");;
      sql_step: SELECT * FROM ${SQL_TABLE_NAME} ;;
    }
  }
  dimension: first_name {}

 }


view: 4_pdt {

  parameter: view_name {
    type: unquoted
    default_value: ""
  }
  derived_table: {
    sql_trigger_value: SELECT DATE_PART('minute', NOW()) ;;
    create_process: {
      sql_step:
        CREATE TABLE IF NOT EXISTS looker_scratch.{{ view_name._parameter_value }}
        (first_name VARCHAR (255));;
      sql_step: INSERT INTO looker_scratch.{{ view_name._parameter_value }} (first_name)
        VALUES ("Christel Ilaka");;
      sql_step: SELECT * FROM ${SQL_TABLE_NAME} ;;
    }
  }
  dimension: first_name {}

}
