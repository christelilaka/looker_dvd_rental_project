
explore: dvd_rental {}

view: pdt_functions {
  derived_table: {
    sql_trigger_value: SELECT 1 ;;
    create_process: {
      sql_step:
          CREATE OR REPLACE FUNCTION count_workdays(start_date DATE, end_date DATE)
                RETURNS integer AS $$
            BEGIN
              RETURN (SELECT count(*) AS count_days_no_weekend
                  FROM   generate_series(start_date
                                 , end_date
                                 , interval '1 day') the_day
                  WHERE  extract('ISODOW' FROM the_day) <6);
            END;
            $$ LANGUAGE PLPGSQL
      ;;
    }
  }
}

view: dvd_rental {
  derived_table: {
    sql:
        WITH dvd_rental(customer_name, rental_date, returned_date) AS
          (SELECT 'Norma' AS customer_name,'2020-04-15' AS rental_date,'2020-04-20' AS returned_date
          UNION ALL SELECT 'Catherine','2020-04-01','2020-04-25'
          UNION ALL SELECT 'Cory','2020-04-10','2020-04-14'
          UNION ALL SELECT 'Alexander','2020-05-04','2020-05-12'
          UNION ALL SELECT 'Ella','2020-05-03','2020-05-08')
        SELECT * FROM dvd_rental;;
  }

  dimension: customer_name {}

  dimension_group: rental {
    group_label: "Dates"
    type: time
    timeframes: [date, month]
    sql: ${TABLE}.rental_date::date ;;
  }

  dimension_group: returned {
    group_label: "Dates"
    type: time
    timeframes: [date]
    sql: ${TABLE}.returned_date::date ;;
  }

  dimension: number_of_days {
    sql: count_workdays(${rental_date}, ${returned_date}) ;;
  }
}
