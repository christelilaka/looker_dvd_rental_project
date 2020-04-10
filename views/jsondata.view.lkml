explore: jsondata {}


view: jsondata {
  derived_table: {
    sql: SELECT pk_id AS pk_id,
                jsonb_array_elements(data->'decision_data')->>'created_at' AS created_at,
                SUBSTRING(jsonb_array_elements(data->'decision_data') ->>'data_submitted' ,POSITION('retailer_id' IN jsonb_array_elements(data->'decision_data') ->>'data_submitted')+16 ,6) AS retailer_id
          FROM public.jsondata
    ;;
  }
  dimension: pk_id {}
  dimension: created_at {}
  dimension: retailer_id {}

  measure: count {
    type: count
    drill_fields: []
  }
}
