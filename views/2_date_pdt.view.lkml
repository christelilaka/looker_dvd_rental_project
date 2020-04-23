explore: 2_date_pdt {}

view: 2_date_pdt {
  derived_table: {
    sql:

                  CREATE FUNCTION pg_temp.f_inc(int)
                  RETURNS int AS 'SELECT $1 + 1' LANGUAGE sql IMMUTABLE;

        WITH mytable(date,company,category,quantity) AS (
                SELECT '2020-04-08' AS date,'ABC' AS company,'Egg' AS category,200 AS quantity
                UNION ALL
                SELECT '2020-04-09','ABC','Meat',205
                UNION ALL
                SELECT '2020-04-10','ABC','Fruit',210
                UNION ALL
                SELECT '2020-04-11','ZZ','Egg',150
                UNION ALL
                SELECT '2020-04-12','ZZ','Meat',155
                UNION ALL
                SELECT '2020-04-13','ZZ','Fruit',160
                UNION ALL
                SELECT '2020-04-14','ABC','Egg',195
                UNION ALL
                SELECT '2020-04-15','ABC','Meat',200
                UNION ALL
                SELECT '2020-04-16','ABC','Fruit',205
                UNION ALL
                SELECT '2020-04-17','ZZ','Egg',145
                UNION ALL
                SELECT '2020-04-18','ZZ','Meat',150
                UNION ALL
                SELECT '2020-04-19','ZZ','Fruit',155
                UNION ALL
                SELECT '2020-04-20','ABC','Egg',190
                UNION ALL
                SELECT '2020-04-07','ABC','Meat',195
                UNION ALL
                SELECT '2020-04-06','ABC','Fruit',200
                UNION ALL
                SELECT '2020-04-05','ZZ','Egg',140
                UNION ALL
                SELECT '2020-04-04','ZZ','Meat',145
                UNION ALL
                SELECT '2020-04-03','ZZ','Fruit',150
                UNION ALL
                SELECT '2020-04-02', 'ABC', 'Egg', 135
                UNION ALL
                SELECT '2020-04-01', 'ABC', 'Meat', 140
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
    sql: ${TABLE}.date::date ;;
  }

  dimension_group: debut {
    type: time
    timeframes: [raw,date,year,month_num,month_name]
    sql: '2020-04-15'::date ;;
  }

  dimension_group: fin {
    type: time
    timeframes: [raw,date,year,month_num,month_name]
    sql: '2020-04-20'::date ;;
  }


  dimension: weekdays_only {
    type: number
    #sql: DATEPART('day', start - stop) ;;
    sql: noweekend(${debut_date}, ${created__date}) ;;
  }

  dimension_group: difference {
    type: duration
    intervals: [day, hour]
    sql_start: ${debut_date};;
    sql_end: ${fin_date} ;;
  }

  dimension: test_one {
    type: number
    sql: pg_temp.f_inc(12) ;;
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
  }

}
