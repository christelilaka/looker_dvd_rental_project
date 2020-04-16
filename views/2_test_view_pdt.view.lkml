explore: 2_test_view_pdt {}
view: 2_test_view_pdt {
  derived_table: {
    sql:
        WITH mytable(date,company,category,quantity) AS (
                SELECT '2020-02-01' AS date,'ABC' AS company,'Egg' AS category,200 AS quantity
                UNION ALL
                SELECT '2020-02-01','ABC','Meat',205
                UNION ALL
                SELECT '2020-02-01','ABC','Fruit',210
                UNION ALL
                SELECT '2020-02-01','ZZ','Egg',150
                UNION ALL
                SELECT '2020-02-01','ZZ','Meat',155
                UNION ALL
                SELECT '2020-02-01','ZZ','Fruit',160
                UNION ALL
                SELECT '2020-01-01','ABC','Egg',195
                UNION ALL
                SELECT '2020-01-01','ABC','Meat',200
                UNION ALL
                SELECT '2020-01-01','ABC','Fruit',205
                UNION ALL
                SELECT '2020-01-01','ZZ','Egg',145
                UNION ALL
                SELECT '2020-01-01','ZZ','Meat',150
                UNION ALL
                SELECT '2020-01-01','ZZ','Fruit',155
                UNION ALL
                SELECT '2019-02-01','ABC','Egg',190
                UNION ALL
                SELECT '2019-02-01','ABC','Meat',195
                UNION ALL
                SELECT '2019-02-01','ABC','Fruit',200
                UNION ALL
                SELECT '2019-02-01','ZZ','Egg',140
                UNION ALL
                SELECT '2019-02-01','ZZ','Meat',145
                UNION ALL
                SELECT '2019-02-01','ZZ','Fruit',150
                UNION ALL
                SELECT '2019-01-01', 'ABC', 'Egg', 135
                UNION ALL
                SELECT '2019-01-01', 'ABC', 'Meat', 140
                UNION ALL
                SELECT '2019-01-01', 'ABC', 'Fruit', 145
                UNION ALL
                SELECT '2019-01-01', 'ZZ', 'Egg', 85
                UNION ALL
                SELECT '2019-01-01', 'ZZ', 'Meat', 90
                UNION ALL
                SELECT '2019-01-01', 'ZZ', 'Fruit', 95
                )
        SELECT * FROM mytable;;
  }

  dimension: date {}
  dimension: company {}
  dimension: category {}
  dimension: quantity {}
  dimension_group: created_ {
    type: time
    timeframes: [raw,date,year,month_num,month_name]
    sql: TO_TIMESTAMP(${TABLE}.date, 'YYYY-MM-DD') ;;
  }

  dimension_group: debut {
    type: time
    timeframes: [raw,date,year,month_num,month_name]
    sql: TO_TIMESTAMP('2020-04-06', 'YYYY-MM-DD') ;;
  }

  dimension_group: fin {
    type: time
    timeframes: [raw,date,year,month_num,month_name]
    sql: TO_TIMESTAMP('2020-04-10', 'YYYY-MM-DD') ;;
  }

  dimension_group: difference {
    type: duration
    intervals: [day, hour]
    sql_start:${fin_date} ;;
    sql_end: ${debut_date} ;;
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
  }

}
