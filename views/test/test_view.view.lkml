


view: test_view {
  derived_table: {
    explore_source: payment {
      column: payment_week {}
      column: total_amount {}
      column: count {}
    }
  }
  dimension: payment_week {
    type: date_week
  }
  dimension: total_amount {
    type: number
  }
  dimension: count {
    type: number
  }

  dimension: image {
    type: string
    sql: 'x4048A-main-desktop.jpg' ;;
    html: <img src="//feather-assets.s3-us-west-1.amazonaws.com/products/akepa-dresser/images/{{value}}"> ;;
  }
}
