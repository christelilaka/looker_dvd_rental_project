explore: pdt_feb_dates {}
explore: pdt_case_when {}

view: pdt_case_when {
  derived_table: {
    sql:
        WITH text_table(name, total) AS (
          SELECT 'Project / Engagement' AS name, 1 as total
          UNION ALL SELECT 'Order / Subscription', 0
          UNION ALL SELECT 'Other', 1
          UNION ALL SELECT '-Missing', 1
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
    label: "total"
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


explore: pdt_names {}
view: pdt_names {
  derived_table: {
    sql: WITH namestable (names) AS
          (SELECT 'sale' AS names UNION ALL SELECT 'return')
          SELECT names FROM namestable
    ;;
  }
  dimension: names {}


  parameter: demand_type_selector {
    view_label: "Product Information"
    #type: unquoted
    allowed_value: { label: "Gross" value: "sale" }
    allowed_value: { label: "Returns Only" value: "return" }
    allowed_value: { label: "Net" value: "sale',return" }
  }

  dimension: param {
    type: yesno
    sql: ${names} IN ({%parameter demand_type_selector %}) ;;
  }
}

view: pdt_feb_dates {
  derived_table: {
    indexes: ["dates"]
    persist_for: "360 hours"
    sql:
        WITH mytable(dates, amount) AS
            (SELECT '2020-01-04 18:41:57' AS dates, 7 AS amount
              UNION ALL SELECT '2020-01-09 11:34:38', 2 UNION ALL SELECT '2020-02-03 00:25:42', 3
              UNION ALL SELECT '2020-02-12 02:49:21', 4 UNION ALL SELECT '2020-02-10 00:19:13', 5
              UNION ALL SELECT '2020-01-19 05:28:34', 6 UNION ALL SELECT '2020-02-12 16:44:05', 3
              UNION ALL SELECT '2020-02-12 11:18:43', 3 UNION ALL SELECT '2020-01-10 01:34:47', 4
              UNION ALL SELECT '2020-01-07 03:39:07', 5 UNION ALL SELECT '2020-01-20 16:27:14', 1
              UNION ALL SELECT '2020-02-12 13:46:00', 1 UNION ALL SELECT '2020-01-18 12:54:24', 2
              UNION ALL SELECT '2020-01-07 11:01:36', 7 UNION ALL SELECT '2020-01-12 20:16:51', 6
              UNION ALL SELECT '2020-02-11 03:34:38', 3 UNION ALL SELECT '2020-02-11 15:09:33', 5
              UNION ALL SELECT '2020-02-12 23:51:46', 2 UNION ALL SELECT '2020-02-11 22:13:09', 3
              UNION ALL SELECT '2020-02-11 15:23:51', 4 UNION ALL SELECT '2020-02-12 08:00:27', 1
              UNION ALL SELECT '2020-02-11 09:41:30', 3 UNION ALL SELECT '2020-02-11 09:52:50', 2
              UNION ALL SELECT '2020-02-12 18:28:59', 6 UNION ALL SELECT '2020-02-12 12:25:21', 4)
            SELECT dates, amount from mytable
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
    timeframes: [raw,date,hour_of_day,week,month, month_name, time]
    sql: TO_TIMESTAMP(${TABLE}.dates, 'YYYY-MM-DD HH24:MI:SS');;
    }

  dimension: date_timestamp {
    type: date_time
    sql: TO_TIMESTAMP(${TABLE}.dates, 'YYYY-MM-DD HH24:MI:SS');;
  }

  measure: total {
    type: sum
    sql: ${TABLE}.amount ;;
  }

  dimension: string_dates {
    type: string
    sql: CAST(${TABLE}.dates AS VARCHAR) ;;}

  dimension: image {
    sql: 'iVBORw0KGgoAAAANSUhEUgAAAAQAAAADCAIAAAA7ljmRAAAAGElEQVQIW2P4DwcMDAxAfBvMAhEQMYgcACEHG8ELxtbPAAAAAElFTkSuQmCC' ;;
    html: <img src="data:image/jpeg;base64,{{value}}" alt="Test" class="rounded float-right">;;
  }
}
