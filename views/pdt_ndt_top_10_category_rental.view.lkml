view: pdt_ndt_top_10_category_rental {
  view_label: "NDT Top 10s"
  derived_table: {
    explore_source: payment {
      column: category_name { field: category.name }
      column: count_rental { field: rental.count }
      derived_column: rank {sql: RANK() OVER (ORDER BY count_rental DESC) ;;}
      bind_all_filters: yes
      sort: {field: rental.count desc: yes }
      limit: 10
    }
  }
  dimension: category_name {}
  dimension: count_rental {type: number}
  dimension: rank { type: number}
  dimension: ranked_category_name {
    order_by_field: rank
    type: string
    sql:
        CASE
            WHEN ${rank} < 10 THEN '0' || ${rank} || ') ' || ${category_name}
            ELSE ${rank} || ') ' || ${category_name}
        END ;;
  }
}
