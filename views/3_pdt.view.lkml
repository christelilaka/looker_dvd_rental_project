view: 3_pdt {

  parameter: view_name {
    type: unquoted
    default_value: "3_pdt"
  }
  derived_table: {
    sql_trigger_value: SELECT DATE_PART('minute', NOW()) ;;
    create_process: {
      sql_step: DROP TABLE IF EXISTS LOOKER_SCRATCH.zendesk_ticket ;;
      sql_step:
        CREATE TABLE IF NOT EXISTS LOOKER_SCRATCH.zendesk_ticket
        (first_name VARCHAR (255));;
      sql_step: INSERT INTO LOOKER_SCRATCH.zendesk_ticket (first_name)
                VALUES ('Christel Ilaka');;
      sql_step: SELECT * FROM ${SQL_TABLE_NAME} ;;
    }
  }
  dimension: first_name {}

 }

explore: 3_pdt {}

explore: 4_pdt {}
view: 4_pdt {

  parameter: view_name {
    type: unquoted
    default_value: "ilaka"
  }
  derived_table: {
    sql_trigger_value: SELECT DATE_PART('minute', NOW()) ;;
    create_process: {
      sql_step: DROP TABLE IF EXISTS looker_scratch.{% parameter view_name %} ;;
      sql_step:
        CREATE TABLE IF NOT EXISTS looker_scratch.{% parameter view_name %}
        (first_name VARCHAR (255));;
      sql_step: INSERT INTO looker_scratch.{% parameter view_name %} (first_name)
        VALUES ('Christel Ilaka');;
      sql_step: SELECT * FROM ${SQL_TABLE_NAME} ;;
    }
  }
  dimension: first_name {}

}
