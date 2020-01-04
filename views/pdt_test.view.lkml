explore: pdt_test {}

view: pdt_test{
  derived_table: {
    sql:
    WITH test_table (ZIP,COUNTYNAME,STATE,STCOUNTYFP,CLASSFP,FIELD6) AS
        (SELECT 36003 AS ZIP,'Autauga' AS COUNTYNAME,'County' AS STATE,'AL' AS STCOUNTYFP,1001 AS CLASSFP,'H1' AS FIELD6
        UNION ALL
        SELECT 36006,'Autauga','County','AL',1001,'H1'
        UNION ALL
        SELECT 36067,'Autauga','County','AL',1001,'H1'
        UNION ALL
        SELECT 36066,'Autauga','County','AL',1001,'H1'
        UNION ALL
        SELECT 36703,'Autauga','County','AL',1001,'H1'
        UNION ALL
        SELECT 36701,'Autauga','County','AL',1001,'H1')
    SELECT * FROM test_table
    ;;
  }

  dimension: zip {
    sql: ${TABLE}.ZIP ;;
  }
  dimension: COUNTYNAME {
    sql: ${TABLE}.COUNTYNAME;;
  }

  dimension: state {
    sql: ${TABLE}.STATE;;
  }
  dimension: stcountyfp {
    sql: ${TABLE}.STCOUNTYFP;;
  }
  dimension: classfp {
    sql: ${TABLE}.CLASSFP;;
  }
  dimension: field6 {
    sql: ${TABLE}.FIELD6;;
  }

}
