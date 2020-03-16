explore: pdt_feb_dates {}
explore: pdt_case_when {}

view: pdt_case_when {
  derived_table: {
    sql:
        WITH text_table(name, total) AS (
          SELECT 'Project / Engagement' AS name, 1 as total
          UNION ALL SELECT 'Order / Subscription', 0
          UNION ALL SELECT 'Other', 1
          UNION ALL SELECT 'Missing', 1
        )
        SELECT name, total FROM text_table
    ;;
  }
  dimension: name {type: string }

#   dimension: total {
#     type: yesno
#     sql:${TABLE}.total = 1 ;;
#     }

  dimension: total {
    type: number
    sql:${TABLE}.total ;;
  }

  measure: sum_total {
    type: sum
    sql: ${total} ;;
  }

  dimension: need_segment {
    type: string
    case: {
      when: {
        sql: ${TABLE}.name='Project / Engagement' ;;
        label: "Project / Engagement"
      }
      when: {
        sql: ${TABLE}.name='Order / Subscription' ;;
        label: "Order / Subscription"
      }
      when: {
        sql: ${TABLE}.name='Other' ;;
        label: "Other"
      }
      when: {
        sql: ${TABLE}.name='Missing' ;;
        label: "Missing"
      }
    }
  }
}


view: pdt_feb_dates {
  derived_table: {
    indexes: ["dates"]
    persist_for: "360 hours"
    sql:
        WITH mytable(dates) AS
            (SELECT '2020-01-04 18:41:57' AS dates
              UNION ALL SELECT '2020-01-09 11:34:38' UNION ALL SELECT '2020-02-03 00:25:42'
              UNION ALL SELECT '2020-02-12 02:49:21' UNION ALL SELECT '2020-02-10 00:19:13'
              UNION ALL SELECT '2020-01-19 05:28:34' UNION ALL SELECT '2020-02-12 16:44:05'
              UNION ALL SELECT '2020-02-12 11:18:43' UNION ALL SELECT '2020-01-10 01:34:47'
              UNION ALL SELECT '2020-01-07 03:39:07' UNION ALL SELECT '2020-01-20 16:27:14'
              UNION ALL SELECT '2020-02-12 13:46:00' UNION ALL SELECT '2020-01-18 12:54:24'
              UNION ALL SELECT '2020-01-07 11:01:36' UNION ALL SELECT '2020-01-12 20:16:51'
              UNION ALL SELECT '2020-02-11 03:34:38' UNION ALL SELECT '2020-02-11 15:09:33'
              UNION ALL SELECT '2020-02-12 23:51:46' UNION ALL SELECT '2020-02-11 22:13:09'
              UNION ALL SELECT '2020-02-11 15:23:51' UNION ALL SELECT '2020-02-12 08:00:27'
              UNION ALL SELECT '2020-02-11 09:41:30' UNION ALL SELECT '2020-02-11 09:52:50'
              UNION ALL SELECT '2020-02-12 18:28:59' UNION ALL SELECT '2020-02-12 12:25:21')
            SELECT dates from mytable
    ;;
  }
  parameter: hours_filter {
    type: number
    description: "Enter hour like 23 for 11pm or 10 for 10am"}

  dimension: date_before{
    type: yesno
    sql: ${dates_raw} < '{{ "now" | date: "%Y-%m-%d" }} {{pdt_feb_dates.hours_filter._parameter_value}}:00:00' ;;}

  dimension_group: dates {
    type: time
    timeframes: [raw,date,hour_of_day,week,month, month_name]
    sql: TO_TIMESTAMP(${TABLE}.dates, 'YYYY-MM-DD HH24:MI:SS');;}

  dimension: string_dates {
    type: string
    sql: CAST(${TABLE}.dates AS VARCHAR) ;;}
}
