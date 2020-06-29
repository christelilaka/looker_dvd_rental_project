explore: actor_test {}

view: actor_test {
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
    suggestions: ["CHRISTEL", "ILAKA"]

  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."last_name" ;;
  }

  dimension_group: last_update {
    type: time
    timeframes: [raw, time,  date, week, month, quarter, year]
    sql: ${TABLE}."last_update" ;;
  }

  measure: count {
    type: count}

  parameter: param_with_100_values {
    allowed_value: {label: "Gross Sale_1" value: "sale_1"}
    allowed_value: {label: "Gross Sale_2" value: "sale_2"}
    allowed_value: {label: "Gross Sale_3" value: "sale_3"}
    allowed_value: {label: "Gross Sale_4" value: "sale_4"}
    allowed_value: {label: "Gross Sale_5" value: "sale_5"}
    allowed_value: {label: "Gross Sale_6" value: "sale_6"}
    allowed_value: {label: "Gross Sale_7" value: "sale_7"}
    allowed_value: {label: "Gross Sale_8" value: "sale_8"}
    allowed_value: {label: "Gross Sale_9" value: "sale_9"}
    allowed_value: {label: "Gross Sale_10" value: "sale_10"}
    allowed_value: {label: "Gross Sale_11" value: "sale_11"}
    allowed_value: {label: "Gross Sale_12" value: "sale_12"}
    allowed_value: {label: "Gross Sale_13" value: "sale_13"}
    allowed_value: {label: "Gross Sale_14" value: "sale_14"}
    allowed_value: {label: "Gross Sale_15" value: "sale_15"}
    allowed_value: {label: "Gross Sale_16" value: "sale_16"}
    allowed_value: {label: "Gross Sale_17" value: "sale_17"}
    allowed_value: {label: "Gross Sale_18" value: "sale_18"}
    allowed_value: {label: "Gross Sale_19" value: "sale_19"}
    allowed_value: {label: "Gross Sale_20" value: "sale_20"}
    allowed_value: {label: "Gross Sale_21" value: "sale_21"}
    allowed_value: {label: "Gross Sale_22" value: "sale_22"}
    allowed_value: {label: "Gross Sale_23" value: "sale_23"}
    allowed_value: {label: "Gross Sale_24" value: "sale_24"}
    allowed_value: {label: "Gross Sale_25" value: "sale_25"}
    allowed_value: {label: "Gross Sale_26" value: "sale_26"}
    allowed_value: {label: "Gross Sale_27" value: "sale_27"}
    allowed_value: {label: "Gross Sale_28" value: "sale_28"}
    allowed_value: {label: "Gross Sale_29" value: "sale_29"}
    allowed_value: {label: "Gross Sale_30" value: "sale_30"}
    allowed_value: {label: "Gross Sale_31" value: "sale_31"}
    allowed_value: {label: "Gross Sale_32" value: "sale_32"}
    allowed_value: {label: "Gross Sale_33" value: "sale_33"}
    allowed_value: {label: "Gross Sale_34" value: "sale_34"}
    allowed_value: {label: "Gross Sale_35" value: "sale_35"}
    allowed_value: {label: "Gross Sale_36" value: "sale_36"}
    allowed_value: {label: "Gross Sale_37" value: "sale_37"}
    allowed_value: {label: "Gross Sale_38" value: "sale_38"}
    allowed_value: {label: "Gross Sale_39" value: "sale_39"}
    allowed_value: {label: "Gross Sale_40" value: "sale_40"}
    allowed_value: {label: "Gross Sale_41" value: "sale_41"}
    allowed_value: {label: "Gross Sale_42" value: "sale_42"}
    allowed_value: {label: "Gross Sale_43" value: "sale_43"}
    allowed_value: {label: "Gross Sale_44" value: "sale_44"}
    allowed_value: {label: "Gross Sale_45" value: "sale_45"}
    allowed_value: {label: "Gross Sale_46" value: "sale_46"}
    allowed_value: {label: "Gross Sale_47" value: "sale_47"}
    allowed_value: {label: "Gross Sale_48" value: "sale_48"}
    allowed_value: {label: "Gross Sale_49" value: "sale_49"}
    allowed_value: {label: "Gross Sale_50" value: "sale_50"}
    allowed_value: {label: "Gross Sale_51" value: "sale_51"}
    allowed_value: {label: "Gross Sale_52" value: "sale_52"}
    allowed_value: {label: "Gross Sale_53" value: "sale_53"}
    allowed_value: {label: "Gross Sale_54" value: "sale_54"}
    allowed_value: {label: "Gross Sale_55" value: "sale_55"}
    allowed_value: {label: "Gross Sale_56" value: "sale_56"}
    allowed_value: {label: "Gross Sale_57" value: "sale_57"}
    allowed_value: {label: "Gross Sale_58" value: "sale_58"}
    allowed_value: {label: "Gross Sale_59" value: "sale_59"}
    allowed_value: {label: "Gross Sale_60" value: "sale_60"}
    allowed_value: {label: "Gross Sale_61" value: "sale_61"}
    allowed_value: {label: "Gross Sale_62" value: "sale_62"}
    allowed_value: {label: "Gross Sale_63" value: "sale_63"}
    allowed_value: {label: "Gross Sale_64" value: "sale_64"}
    allowed_value: {label: "Gross Sale_65" value: "sale_65"}
    allowed_value: {label: "Gross Sale_66" value: "sale_66"}
    allowed_value: {label: "Gross Sale_67" value: "sale_67"}
    allowed_value: {label: "Gross Sale_68" value: "sale_68"}
    allowed_value: {label: "Gross Sale_69" value: "sale_69"}
    allowed_value: {label: "Gross Sale_70" value: "sale_70"}
    allowed_value: {label: "Gross Sale_71" value: "sale_71"}
    allowed_value: {label: "Gross Sale_72" value: "sale_72"}
    allowed_value: {label: "Gross Sale_73" value: "sale_73"}
    allowed_value: {label: "Gross Sale_74" value: "sale_74"}
    allowed_value: {label: "Gross Sale_75" value: "sale_75"}
    allowed_value: {label: "Gross Sale_76" value: "sale_76"}
    allowed_value: {label: "Gross Sale_77" value: "sale_77"}
    allowed_value: {label: "Gross Sale_78" value: "sale_78"}
    allowed_value: {label: "Gross Sale_79" value: "sale_79"}
    allowed_value: {label: "Gross Sale_80" value: "sale_80"}
    allowed_value: {label: "Gross Sale_81" value: "sale_81"}
    allowed_value: {label: "Gross Sale_82" value: "sale_82"}
    allowed_value: {label: "Gross Sale_83" value: "sale_83"}
    allowed_value: {label: "Gross Sale_84" value: "sale_84"}
    allowed_value: {label: "Gross Sale_85" value: "sale_85"}
    allowed_value: {label: "Gross Sale_86" value: "sale_86"}
    allowed_value: {label: "Gross Sale_87" value: "sale_87"}
    allowed_value: {label: "Gross Sale_88" value: "sale_88"}
    allowed_value: {label: "Gross Sale_89" value: "sale_89"}
    allowed_value: {label: "Gross Sale_90" value: "sale_90"}
    allowed_value: {label: "Gross Sale_91" value: "sale_91"}
    allowed_value: {label: "Gross Sale_92" value: "sale_92"}
    allowed_value: {label: "Gross Sale_93" value: "sale_93"}
    allowed_value: {label: "Gross Sale_94" value: "sale_94"}
    allowed_value: {label: "Gross Sale_95" value: "sale_95"}
    allowed_value: {label: "Gross Sale_96" value: "sale_96"}
    allowed_value: {label: "Gross Sale_97" value: "sale_97"}
    allowed_value: {label: "Gross Sale_98" value: "sale_98"}
    allowed_value: {label: "Gross Sale_99" value: "sale_99"}
    allowed_value: {label: "Gross Sale_100" value: "sale_100"}
  }

}
